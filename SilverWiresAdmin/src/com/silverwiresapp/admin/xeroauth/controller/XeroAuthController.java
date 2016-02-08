package com.silverwiresapp.admin.xeroauth.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.hibernate.Transaction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.api.client.auth.oauth.OAuthAuthorizeTemporaryTokenUrl;
import com.google.api.client.auth.oauth.OAuthCredentialsResponse;
import com.google.api.client.auth.oauth.OAuthGetAccessToken;
import com.google.api.client.auth.oauth.OAuthHmacSigner;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;
import com.silverwiresapp.admin.utils.dbpersistanceutils.XeroHibernateHelper;
import com.silverwiresapp.admin.utils.propertiesutils.XeroPropertiesUtils;
import com.silverwiresapp.admin.xeroauth.pojo.XeroTokens;

@Controller
@RequestMapping("/xero/auth")
public class XeroAuthController {

	// Session session = HibernateUtil.getSessionFactory().openSession();

	public static final Logger LOG = Logger.getLogger(XeroAuthController.class);

	@RequestMapping(value = "/requestToken", method = RequestMethod.GET)
	public void requestToken(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			HttpServletRequest request, HttpServletResponse response) {

		com.google.api.client.auth.oauth.OAuthHmacSigner signer = new com.google.api.client.auth.oauth.OAuthHmacSigner();
		// Get Temporary Token
		com.google.api.client.auth.oauth.OAuthGetTemporaryToken getTemporaryToken = new com.google.api.client.auth.oauth.OAuthGetTemporaryToken(
				XeroPropertiesUtils.REQUEST_TOKEN_URL);
		signer.clientSharedSecret = XeroPropertiesUtils.OAUTH_CONSUMER_SECRET;

		getTemporaryToken.signer = signer;
		getTemporaryToken.consumerKey = XeroPropertiesUtils.OAUTH_CONSUMER_KEY;
		getTemporaryToken.callback = XeroPropertiesUtils.OAUTH_CALLBACK_URL;
		getTemporaryToken.transport = new NetHttpTransport();

		try {
			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			OAuthCredentialsResponse temporaryTokenResponse = getTemporaryToken.execute();
			System.out.println(temporaryTokenResponse.token);
			System.out.println(temporaryTokenResponse.tokenSecret);

			// XeroTokens xero = new XeroTokens(swUserId);
			XeroTokens tokens = (XeroTokens) XeroHibernateHelper.getTokensBySwUserId(swUserId);
			if (tokens == null) {
				tokens = new XeroTokens(swUserId);
			}

			/*
			 * check db for existing swUserID
			 */

			tokens.setConusmerKey(temporaryTokenResponse.token);
			tokens.setConsumerSecret(temporaryTokenResponse.tokenSecret);

			// Build Authoirze URL

			OAuthAuthorizeTemporaryTokenUrl accessTempToken = new OAuthAuthorizeTemporaryTokenUrl(
					XeroPropertiesUtils.AUTHORIZE_URL);
			accessTempToken.temporaryToken = temporaryTokenResponse.token;
			accessTempToken.set("oauth_callback", XeroPropertiesUtils.OAUTH_CALLBACK_URL);
			String authUrl = accessTempToken.build();

			PrintWriter respWriter = response.getWriter();
			response.setStatus(200);
			response.setContentType("text/html");
			respWriter.println("<i>Temporary Token: " + "</i><br><br>");
			respWriter.println("<i>Temporary Token Secret: " + "</i><br><br>");
			respWriter.println("<i>Authorize URL: " + authUrl + "</i><br><br>");
			respWriter.println("<a href='" + authUrl + "'>Continue OAuth Flow</a><br><br>");

			tokens.setAuthUrl(authUrl);

			if (tokens.getId() == 0) {
				// create
				HibernatePersistanceUtil.getSession().save(tokens);
			} else {
				// update
				HibernatePersistanceUtil.getSession().update(tokens);
			}

			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("xeroData", tokens);

			tx.commit();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// session.close();
		}

	}

	@RequestMapping(value = "/accessTokenCallback", method = RequestMethod.GET)
	public void accessTokenCallback(HttpServletRequest req, HttpServletResponse response) {

		LOG.info("#### OAuthController ->  CALLBACK() - started ####");
		LOG.info("AccessTokenServlet");

		try {

			// Get values returned via Callback URL
			String verifier = req.getParameter("oauth_verifier");
			// String orgShortCode = req.getParameter("org");

			// Check is temp token & secret exists
			HttpSession httpSession = req.getSession();
			XeroTokens xero = (XeroTokens) httpSession.getAttribute("xeroData");
			String tempToken = xero.getConusmerKey();
			String tempTokenSecret = xero.getConsumerSecret();

			// Create HMAC Signer
			OAuthHmacSigner signer = new OAuthHmacSigner();
			signer.clientSharedSecret = XeroPropertiesUtils.OAUTH_CONSUMER_SECRET;
			signer.tokenSharedSecret = tempTokenSecret;

			// Swap Temp Token for Access Token
			OAuthGetAccessToken getAccessToken = new OAuthGetAccessToken(XeroPropertiesUtils.ACCESS_TOKEN_URL);
			getAccessToken.signer = signer;
			getAccessToken.consumerKey = XeroPropertiesUtils.OAUTH_CONSUMER_KEY;
			getAccessToken.verifier = verifier;
			getAccessToken.temporaryToken = tempToken;
			getAccessToken.transport = new NetHttpTransport();
			OAuthCredentialsResponse accessTokenResponse = getAccessToken.execute();

			// Store 30 min Access Token (from accessToken request) in Cookie
			// this is just a demo - you'll want to persist this token along
			// with
			// the user profile in a more secure way.

			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			xero.setAccessToken(accessTokenResponse.token);
			xero.setAccessTokenSecret(accessTokenResponse.tokenSecret);
			HibernatePersistanceUtil.getSession().update(xero);
			tx.commit();

			// Store 30 min Access Token Secret (from accessToken request) in
			// Cookie
			// this is just a demo - you'll want to persist this secret along
			// with
			// the user profile in a more secure way.

			PrintWriter respWriter = response.getWriter();
			response.setStatus(200);
			response.setContentType("text/html");
			respWriter.println("<a href='/SilverWiresAdmin/xero/data/getinvoices'+'>Get Invoice</a><br><br>");
			respWriter.println("<i>Access Token: </li>" + accessTokenResponse.token + "<br><br>");
			respWriter.println("<i>Access Token Secret: </li>" + accessTokenResponse.tokenSecret + "<br><br>");

		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getLocalizedMessage());
		} finally {
			HibernatePersistanceUtil.closeSession();
			req.getSession().removeAttribute("xeroData");
		}

	}

}
