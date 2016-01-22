package com.silverwiresapp.admin.magento.controller;

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
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.Token;
import com.github.scribejava.core.model.Verifier;
import com.github.scribejava.core.oauth.OAuthService;
import com.silverwiresapp.admin.magento.data.MagentoHibernateHelper;
import com.silverwiresapp.admin.magento.pojo.MagentoTokens;
import com.silverwiresapp.admin.scribe.MagentoScribeApi;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;
import com.silverwiresapp.admin.utils.propertiesutils.MagentoPropertiesUtils;

@Controller
@RequestMapping("/magento/scribe")
public class MagentoScribeController {

	public static final Logger LOG = Logger.getLogger(MagentoScribeController.class);

	@RequestMapping(value = "/requestToken", method = RequestMethod.GET)
	public void requestToken(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			HttpServletRequest request, HttpServletResponse response) throws IOException {

		OAuthService service = new ServiceBuilder().provider(MagentoScribeApi.class)
				.apiKey(MagentoPropertiesUtils.MAGENTO_API_KEY).apiSecret(MagentoPropertiesUtils.MAGENTO_API_SECRET)
				.callback(MagentoPropertiesUtils.OAUTH_CALLBACK_URL).build();

		System.out.println("=== Mage v1.7.0.2 OAuth Workflow ===");
		System.out.println();

		// Obtain the Request Token
		HttpSession session = request.getSession();
		Token requestToken = service.getRequestToken();
		String authUrl = service.getAuthorizationUrl(requestToken);

		try {
			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			MagentoTokens mgTokens = MagentoHibernateHelper.getTokensBySwUserId(swUserId);
			if (mgTokens == null) {
				mgTokens = new MagentoTokens(swUserId);
			}

			mgTokens.setConusmerKey(requestToken.getToken());
			mgTokens.setConsumerSecret(requestToken.getSecret());
			mgTokens.setAuthUrl(authUrl);
			System.out.println("token:" + requestToken.getToken() + "\nsecret:" + requestToken.getSecret());

			PrintWriter respWriter = response.getWriter();
			response.setStatus(200);
			response.setContentType("text/html");
			respWriter.println("<i>Temporary Token: " + requestToken.getToken() + "</i><br><br>");
			respWriter.println("<i>Temporary Token Secret: " + requestToken.getSecret() + "</i><br><br>");
			respWriter.println("<i>Authorize URL: " + authUrl + "</i><br><br>");
			respWriter.println("<a href='" + authUrl + "'>Continue OAuth Flow</a><br><br>");

			if (mgTokens.getId() == 0) {
				// create
				HibernatePersistanceUtil.getSession().save(mgTokens);
			} else {
				// update
				HibernatePersistanceUtil.getSession().update(mgTokens);

			}

			session.setAttribute("mgTokens", mgTokens);
			session.setAttribute("requestToken", requestToken);
			tx.commit();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}

	}

	@RequestMapping(value = "/accessTokenCallback", method = RequestMethod.GET)
	public void accessTokenCallback(@RequestParam(value = "oauth_verifier", required = false) String oauthVerifier,
			HttpServletRequest request, HttpServletResponse response) {

		OAuthService service = new ServiceBuilder().provider(MagentoScribeApi.class)
				.apiKey(MagentoPropertiesUtils.MAGENTO_API_KEY).apiSecret(MagentoPropertiesUtils.MAGENTO_API_SECRET)
				.build();

		LOG.info("#### OAuthController ->  CALLBACK() - started ####");
		LOG.info("AccessTokenServlet");

		try {

			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			HttpSession session = request.getSession();
			MagentoTokens mgTokens = (MagentoTokens) session.getAttribute("mgTokens");
			Token requestToken = (Token) session.getAttribute("requestToken");
			Verifier verifier = new Verifier(oauthVerifier);

			Token accessToken = service.getAccessToken(requestToken, verifier);

			// persists remaining tokens to db (access token and & access token
			// Secret)

			mgTokens.setAccessToken(accessToken.getToken());
			mgTokens.setAccessTokenSecret(accessToken.getSecret());

			PrintWriter respWriter = response.getWriter();
			response.setStatus(200);
			response.setContentType("text/html");
			respWriter.println("<a href='/SilverWiresAdmin/xero/data/getinvoices'+'>Get Invoice</a><br><br>");
			respWriter.println("<i>Access Token: </li>" + mgTokens.getAccessToken() + "<br><br>");
			respWriter.println("<i>Access Token Secret: </li>" + mgTokens.getAccessTokenSecret() + "<br><br>");

			HibernatePersistanceUtil.getSession().update(mgTokens);
			tx.commit();

		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getLocalizedMessage());
		} finally {
			HibernatePersistanceUtil.closeSession();
			request.getSession().removeAttribute("mgTokens");
			request.getSession().removeAttribute("token");
		}
	}

}
