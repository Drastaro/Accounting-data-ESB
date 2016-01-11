package com.silverwiresapp.admin.quickbooks.controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
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
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.intuit.ipp.data.CompanyInfo;
import com.silverwiresapp.admin.quickbooks.auth_data.dao.QuickBooksDAO;
import com.silverwiresapp.admin.quickbooks.data.PlatformResponse;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksDataGateway;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksPropertiesUtils;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksTokens;
import oauth.signpost.OAuth;
import oauth.signpost.OAuthConsumer;
import oauth.signpost.OAuthProvider;
import oauth.signpost.basic.DefaultOAuthConsumer;
import oauth.signpost.basic.DefaultOAuthProvider;
import oauth.signpost.exception.OAuthCommunicationException;
import oauth.signpost.exception.OAuthExpectationFailedException;
import oauth.signpost.exception.OAuthMessageSignerException;
import oauth.signpost.http.HttpParameters;

@Controller
@RequestMapping("/quickbooks/auth")
public class QuickBooksAuthController {

	public static final Logger LOG = Logger.getLogger(QuickBooksAuthController.class);

	@RequestMapping(value = "/requestToken", method = RequestMethod.GET)
	public void requestToken(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			HttpServletRequest request, HttpServletResponse response) {

		LOG.info("#### OAuthController -> requestToken() - started ####");

		LOG.info("RequestToken");
		// Invoke the helper class and retrieve the request token.
		OAuthConsumer oauthconsumer;

		// Initialize the Provider class with the request token, access token
		// and authorize URLs
		OAuthProvider provider = new DefaultOAuthProvider(QuickBooksPropertiesUtils.REQUEST_TOKEN_URL,
				QuickBooksPropertiesUtils.ACCESS_TOKEN_URL, QuickBooksPropertiesUtils.AUTHORIZE_URL);

		try {

			// Read the consumer key and secret from the Properties file to
			// create the OauthConsumer object
			oauthconsumer = new DefaultOAuthConsumer(QuickBooksPropertiesUtils.OAUTH_CONSUMER_KEY,
					QuickBooksPropertiesUtils.OAUTH_CONSUMER_SECRET);

			LOG.info("OATH CONSUMER KEY+++" + QuickBooksPropertiesUtils.OAUTH_CONSUMER_KEY);
			// The retrieveRequestToken method in the signpost library calls the
			// request token URL configured in the OAuthProvider object
			// to retrieve the token and sends the response to the URL
			// configured in the Oauth Callback URL configured in the properties
			// file
			String authUrl = provider.retrieveRequestToken(oauthconsumer, QuickBooksPropertiesUtils.OAUTH_CALLBACK_URL);

			System.out.println("AuthURL - " + authUrl);
			System.out.println("RequestToken - " + oauthconsumer.getToken());
			System.out.println("RequestTokenSecret - " + oauthconsumer.getTokenSecret());

			// SAVE REQUEST TOKEN IN DB
			QuickBooksDAO.saveRequestTokens(swUserId, oauthconsumer.getToken(), oauthconsumer.getTokenSecret());

			// Store the request token and secret in the session object. These
			// tokens need not be persisted in DB
			HttpSession session = request.getSession();
			/*
			 * session.setAttribute("requestToken", oauthconsumer.getToken());
			 * session.setAttribute("requestTokenSecret",
			 * oauthconsumer.getTokenSecret());
			 */
			session.setAttribute("oauthConsumer", oauthconsumer);
			session.setAttribute("sw_user_id", swUserId);
			response.sendRedirect(authUrl);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/accessTokenCallback", method = RequestMethod.GET)
	public void accessTokenCallback(HttpServletRequest request, HttpServletResponse response) {

		LOG.info("#### OAuthController ->  CALLBACK() - started ####");
		LOG.info("AccessTokenServlet");

		try {

			HttpSession session = request.getSession();

			// The realm Id is returned in the callback and read into the
			// session
			String realmID = request.getParameter("realmId");
			// session.setAttribute("realmId", realmID);
			String dataSource = request.getParameter("dataSource");
			// session.setAttribute("dataSource", dataSource);

			String swUserId = (String) session.getAttribute("sw_user_id");
			OAuthConsumer oauthconsumer = (OAuthConsumer) session.getAttribute("oauthConsumer");

			HttpParameters additionalParams = new HttpParameters();
			additionalParams.put("oauth_callback", OAuth.OUT_OF_BAND);
			additionalParams.put("oauth_verifier", request.getParameter("oauth_verifier"));
			oauthconsumer.setAdditionalParameters(additionalParams);

			// Sign the call to retrieve the access token request
			String signedURL = oauthconsumer.sign(QuickBooksPropertiesUtils.ACCESS_TOKEN_URL);
			URL url = new URL(signedURL);

			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.setRequestMethod("GET");

			String accesstokenresponse = "";
			String accessToken, accessTokenSecret = "";
			if (urlConnection != null) {
				BufferedReader rd = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
				StringBuffer sb = new StringBuffer();
				String line;
				while ((line = rd.readLine()) != null) {
					sb.append(line);
					System.out.println(sb.toString());
				}
				rd.close();
				accesstokenresponse = sb.toString();
			}
			if (accesstokenresponse != null) {
				String[] responseElements = accesstokenresponse.split("&");
				if (responseElements.length > 1) {
					accessToken = responseElements[1].split("=")[1];
					accessTokenSecret = responseElements[0].split("=")[1];
					LOG.info("OAuth accessToken: " + accessToken);
					LOG.info("OAuth accessTokenSecret: " + accessTokenSecret);

					QuickBooksDAO.updateAccessTokens(swUserId, realmID, accessToken, accessTokenSecret);

				}
				// String respMsg
				// ="<script
				// type=\"text/javascript\">window.opener.location.href =
				// window.opener.location.href;window.close();</script>";
				// String respMsg
				// ="<BODY
				// OnLoad=\"javascript:window.opener.location.reload(true);parent.window.close()\">";
				// response.getWriter().write(respMsg);
				response.sendRedirect(QuickBooksPropertiesUtils.QB_POPUP_CLOSE_PAGE);
			}
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getLocalizedMessage());
		}

	}

	@RequestMapping(value = "/status", method = RequestMethod.POST)
	public void getQuickBooksStatus(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			// get from DB if the tokens are saved
			QuickBooksTokens tokens = QuickBooksDAO.getTokensBySwUserId(swUserId);
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
			QuickBooksTokens tokens = QuickBooksDAO.getTokensBySwUserId(swUserId);
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

				// PlatformResponse platformResp = (PlatformResponse)
				// jaxbUnmarshaller
				// .unmarshal(new StringReader(responseReceived.toString()));

				System.out.println(je.getValue().getErrorCode());

				System.out.println("Platforms resp mesg:== " + platResponse.getErrorMessage() + "  code==="
						+ platResponse.getErrorCode());

				if (platResponse != null && "0".equals(platResponse.getErrorCode())) {
					// delete tokens from DB
					QuickBooksDAO.deleteTokensBySwUserId(swUserId);
					// delete quickbooks settings
					QuickBooksDAO.deleteSettingsBySwUserId(swUserId);

					// reply with success true
					response.getWriter().write("{ \"result\": \"true\"}");
				} else {
					if ("270".equals(platResponse.getErrorCode())) {
						// the tokens are already invalid -- delete
						QuickBooksDAO.deleteTokensBySwUserId(swUserId);
						// delete quickbooks settings
						QuickBooksDAO.deleteSettingsBySwUserId(swUserId);

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
