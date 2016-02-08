package com.silverwiresapp.admin.xeroauth.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Transaction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.Token;
import com.github.scribejava.core.model.Verifier;
import com.github.scribejava.core.oauth.OAuthService;
import com.silverwiresapp.admin.scribe.XeroScribeApi;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;
import com.silverwiresapp.admin.utils.dbpersistanceutils.XeroHibernateHelper;
import com.silverwiresapp.admin.utils.propertiesutils.XeroPropertiesUtils;
import com.silverwiresapp.admin.xeroauth.pojo.XeroTokens;

@Controller
@RequestMapping("/xero/scribe")
public class XeroScribeController {

	@RequestMapping(value = "/requestToken", method = RequestMethod.GET)
	public void requestToken(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			HttpServletRequest request, HttpServletResponse response) throws IOException {

		OAuthService service = new ServiceBuilder().provider(XeroScribeApi.class)
				.apiKey(XeroPropertiesUtils.OAUTH_CONSUMER_KEY).apiSecret(XeroPropertiesUtils.OAUTH_CONSUMER_SECRET)
				.callback(XeroPropertiesUtils.SCRIBE_OAUTH_CALLBACK_URL).build();

		System.out.println("=== Mage v1.7.0.2 OAuth Workflow ===");
		System.out.println();

		HttpSession session = request.getSession();
		Token requestToken = service.getRequestToken();
		String authUrl = service.getAuthorizationUrl(requestToken);

		try {
			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			XeroTokens xeroTokens = XeroHibernateHelper.getTokensBySwUserId(swUserId);
			if (xeroTokens == null) {
				xeroTokens = new XeroTokens(swUserId);
			}

			xeroTokens.setConusmerKey(requestToken.getToken());
			xeroTokens.setConsumerSecret(requestToken.getSecret());
			xeroTokens.setAuthUrl(authUrl);

			session.setAttribute("requestToken", requestToken);

			PrintWriter respWriter = response.getWriter();
			response.setStatus(200);
			response.setContentType("text/html");
			respWriter.println("<i>Temporary Token: " + requestToken.getToken() + "</i><br><br>");
			respWriter.println("<i>Temporary Token Secret: " + requestToken.getSecret() + "</i><br><br>");
			respWriter.println("<i>Authorize URL: " + authUrl + "</i><br><br>");
			respWriter.println("<a href='" + authUrl + "'>Continue OAuth Flow</a><br><br>");

			if (xeroTokens.getId() == 0) {
				// create
				HibernatePersistanceUtil.getSession().save(xeroTokens);
			} else {
				// update
				HibernatePersistanceUtil.getSession().update(xeroTokens);

			}

			session.setAttribute("xeroTokens", xeroTokens);
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

		OAuthService service = new ServiceBuilder().provider(XeroScribeApi.class)
				.apiKey(XeroPropertiesUtils.OAUTH_CONSUMER_KEY).apiSecret(XeroPropertiesUtils.OAUTH_CONSUMER_SECRET)
				.build();

		try {

			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			Verifier verifier = new Verifier(oauthVerifier);

			HttpSession session = request.getSession();
			Token requestToken = (Token) session.getAttribute("requestToken");

			// Verifier xeroVrifier = new Verifier(verifier);
			Token accessToken = service.getAccessToken(requestToken, verifier);

			PrintWriter respWriter = response.getWriter();
			response.setStatus(200);
			response.setContentType("text/html");
			respWriter.println("<a href='/SilverWiresAdmin/xero/data/getinvoices'+'>Get Invoice</a><br><br>");
			respWriter.println("<i>Access Token: </li>" + accessToken.getToken() + "<br><br>");
			respWriter.println("<i>Access Token Secret: </li>" + accessToken.getSecret() + "<br><br>");

			XeroTokens xeroTokens = (XeroTokens) session.getAttribute("xeroTokens");
			xeroTokens.setAccessToken(accessToken.getToken());
			xeroTokens.setAccessTokenSecret(accessToken.getSecret());
			HibernatePersistanceUtil.getSession().update(xeroTokens);
			tx.commit();

			System.out.println("scribe tokens: " + accessToken.getToken() + " \n" + accessToken.getSecret());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			HibernatePersistanceUtil.closeSession();
			request.getSession().removeAttribute("xeroTokens");
			request.getSession().removeAttribute("requestToken");
		}

	}

}
