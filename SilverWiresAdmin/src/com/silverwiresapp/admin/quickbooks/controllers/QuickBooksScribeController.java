package com.silverwiresapp.admin.quickbooks.controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.transform.stream.StreamSource;
import org.apache.log4j.Logger;
import org.hibernate.Transaction;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.Token;
import com.github.scribejava.core.model.Verifier;
import com.github.scribejava.core.oauth.OAuthService;
import com.intuit.ipp.data.CompanyInfo;
import com.silverwiresapp.admin.quickbooks.dao.QuickBooksPersistanceDAO;
import com.silverwiresapp.admin.quickbooks.data.PlatformResponse;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksDataGateway;
import com.silverwiresapp.admin.quickbooks.pojo.QuickBooksTokens;
import com.silverwiresapp.admin.scribe.QuickBooksScribeApi;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;
import com.silverwiresapp.admin.utils.dbpersistanceutils.QuickBooksHibernateHelper;
import com.silverwiresapp.admin.utils.propertiesutils.QuickBooksPropertiesUtils;
import oauth.signpost.OAuthConsumer;
import oauth.signpost.basic.DefaultOAuthConsumer;
import oauth.signpost.exception.OAuthCommunicationException;
import oauth.signpost.exception.OAuthExpectationFailedException;
import oauth.signpost.exception.OAuthMessageSignerException;

@Controller
@RequestMapping(value = "/quickbooks/scribe")
public class QuickBooksScribeController {

	public static final Logger LOG = Logger.getLogger(QuickBooksScribeController.class);

	@RequestMapping(value = "/requestToken", method = RequestMethod.GET)
	public void requestToken(@RequestParam("sw_user_id") String swUserId, HttpServletRequest request,
			HttpServletResponse response) {

		OAuthService service = new ServiceBuilder().provider(QuickBooksScribeApi.class)
				.apiKey(QuickBooksPropertiesUtils.OAUTH_CONSUMER_KEY)
				.apiSecret(QuickBooksPropertiesUtils.OAUTH_CONSUMER_SECRET)
				.callback(QuickBooksPropertiesUtils.SCRIBE_OAUTH_CALLBACK_URL).build();

		System.out.println("=== Mage v1.7.0.2 OAuth Workflow ===");

		HttpSession session = request.getSession();
		Token requestToken = service.getRequestToken();
		String authUrl = service.getAuthorizationUrl(requestToken);

		try {
			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			QuickBooksTokens quickTokens = QuickBooksHibernateHelper.getTokensBySwUserId(swUserId);
			if (quickTokens == null) {
				quickTokens = new QuickBooksTokens(swUserId);
			}

			quickTokens.setRequestToken(requestToken.getToken());
			quickTokens.setRequestTokenSecret(requestToken.getSecret());
			quickTokens.setAuthUrl(authUrl);

			session.setAttribute("requestToken", requestToken);

			PrintWriter respWriter = response.getWriter();
			response.setStatus(200);
			response.setContentType("text/html");
			respWriter.println("<i>Temporary Token: " + requestToken.getToken() + "</i><br><br>");
			respWriter.println("<i>Temporary Token Secret: " + requestToken.getSecret() + "</i><br><br>");
			respWriter.println("<i>Authorize URL: " + authUrl + "</i><br><br>");
			respWriter.println("<a href='" + authUrl + "'>Continue OAuth Flow</a><br><br>");

			if (quickTokens.getId() == 0) {
				// create
				HibernatePersistanceUtil.getSession().save(quickTokens);
			} else {
				// update
				HibernatePersistanceUtil.getSession().update(quickTokens);

			}

			session.setAttribute("quickTokens", quickTokens);
			System.out.println("scribe tokens: " + requestToken.getToken() + "\n" + requestToken.getSecret());

			// return "redirect:" + authUrl;

			tx.commit();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}

	}

	@RequestMapping(value = "/accessTokenCallback", method = RequestMethod.GET)
	public void accessTokenCallback(@RequestParam(value = "oauth_verifier", required = false) String oauthVerifier,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		OAuthService service = new ServiceBuilder().provider(QuickBooksScribeApi.class)
				.apiKey(QuickBooksPropertiesUtils.OAUTH_CONSUMER_KEY)
				.apiSecret(QuickBooksPropertiesUtils.OAUTH_CONSUMER_SECRET).build();

		try {

			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			Verifier verifier = new Verifier(oauthVerifier);

			HttpSession session = request.getSession();
			Token requestToken = (Token) session.getAttribute("requestToken");

			// Verifier xeroVrifier = new Verifier(verifier);
			Token accessToken = service.getAccessToken(requestToken, verifier);
			String realmID = request.getParameter("realmId");

			PrintWriter respWriter = response.getWriter();
			response.setStatus(200);
			response.setContentType("text/html");
			respWriter.println("<a href='/SilverWiresAdmin/xero/data/getinvoices'+'>Get Invoice</a><br><br>");
			respWriter.println("<i>Access Token: </li>" + accessToken.getToken() + "<br><br>");
			respWriter.println("<i>Access Token Secret: </li>" + accessToken.getSecret() + "<br><br>");

			QuickBooksTokens quickTokens = (QuickBooksTokens) session.getAttribute("quickTokens");
			quickTokens.setAccessToken(accessToken.getToken());
			quickTokens.setAccessTokenSecret(accessToken.getSecret());
			quickTokens.setQboCompanyId(realmID);
			HibernatePersistanceUtil.getSession().update(quickTokens);
			tx.commit();

			System.out.println("scribe tokens: " + accessToken.getToken() + " \n" + accessToken.getSecret());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			HibernatePersistanceUtil.closeSession();
			request.getSession().removeAttribute("quickTokens");
			request.getSession().removeAttribute("requestToken");
		}

	}

	@RequestMapping(value = "/status", method = RequestMethod.POST)
	public void getQuickBooksStatus(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			// get from DB if the tokens are saved
			QuickBooksTokens tokens = QuickBooksPersistanceDAO.getTokensBySwUserId(swUserId);
			String status = "";
			String companyName = "";
			if (tokens == null || StringUtils.isEmpty(tokens.getAccessTokenSecret())
					|| StringUtils.isEmpty(tokens.getAccessToken())) {
				status = "not-connected";
			} else {
				status = "connected";
				// get from Quickbooks company name
				CompanyInfo companyInfo = QuickBooksDataGateway.getCompanyInfo(tokens);
				companyName = companyInfo.getCompanyName();

			}

			response.getWriter().write("{\"status\":\"" + status + "\", \"companyName\":\"" + companyName + "\"}");

		} catch (Exception ex) {
			ex.printStackTrace();
			throw new ServletException("Server internal error on retrieveing Quickbooks data");
		}

	}

	@RequestMapping(value = "/disconnect", method = RequestMethod.POST)
	public void disconnectQuickbooks(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			HttpServletResponse response) throws ServletException, IOException, SQLException {

		try {

			// get from DB if the tokens are saved
			QuickBooksTokens tokens = QuickBooksPersistanceDAO.getTokensBySwUserId(swUserId);
			if (tokens == null) {
				response.getWriter().write("{ \"result\": \"false\"}");
				return;
			}

			OAuthConsumer oauthconsumer = new DefaultOAuthConsumer(QuickBooksPropertiesUtils.OAUTH_CONSUMER_KEY,
					QuickBooksPropertiesUtils.OAUTH_CONSUMER_SECRET);

			oauthconsumer.setTokenWithSecret(tokens.getAccessToken(), tokens.getAccessTokenSecret());
			// Sign the call
			String signedURL = oauthconsumer.sign(QuickBooksPropertiesUtils.DISCONNECT_URL);

			URL url = new URL(signedURL);

			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.setRequestMethod("GET");

			System.out.println("DISCONNECTTTT ");

			if (urlConnection != null) {
				BufferedReader rd = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
				StringBuffer responseReceived = new StringBuffer();
				String line;
				while ((line = rd.readLine()) != null) {
					responseReceived.append(line);

				}

				rd.close();
				System.out.println("Disconnect response===" + responseReceived.toString());
				// parse xml reponse to get response error code
				JAXBContext jaxbContext = JAXBContext.newInstance(PlatformResponse.class);
				Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
				StreamSource streamSource = new StreamSource(new StringReader(responseReceived.toString()));
				JAXBElement<PlatformResponse> je = jaxbUnmarshaller.unmarshal(streamSource, PlatformResponse.class);
				PlatformResponse platResponse = je.getValue();

				System.out.println(je.getValue().getErrorCode());

				System.out.println("Platforms resp mesg:== " + platResponse.getErrorMessage() + "  code==="
						+ platResponse.getErrorCode());

				if (platResponse != null && "0".equals(platResponse.getErrorCode())) {
					// delete tokens from DB
					QuickBooksPersistanceDAO.deleteTokensBySwUserId(swUserId);
					// delete quickbooks settings
					QuickBooksPersistanceDAO.deleteSettingsBySwUserId(swUserId);

					// reply with success true
					response.getWriter().write("{ \"result\": \"true\"}");
				} else {
					if ("270".equals(platResponse.getErrorCode())) {
						// the tokens are already invalid -- delete
						QuickBooksPersistanceDAO.deleteTokensBySwUserId(swUserId);
						// delete quickbooks settings
						QuickBooksPersistanceDAO.deleteSettingsBySwUserId(swUserId);

					}
					response.getWriter().write("{ \"result\": \"false\"}");
				}
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (OAuthMessageSignerException e) {
			e.printStackTrace();
		} catch (OAuthExpectationFailedException e) {
			e.printStackTrace();
		} catch (OAuthCommunicationException e) {
			e.printStackTrace();
		} catch (JAXBException e) {
			e.printStackTrace();
		}
	}

}
