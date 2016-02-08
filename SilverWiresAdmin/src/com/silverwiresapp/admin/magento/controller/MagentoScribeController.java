package com.silverwiresapp.admin.magento.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.silverwiresapp.admin.magento.dao.MagentoRestGateway;
import com.silverwiresapp.admin.magento.data.MagentoHibernateHelper;
import com.silverwiresapp.admin.magento.pojo.MagentoTaxRate;
import com.silverwiresapp.admin.magento.pojo.MagentoTokens;
import com.silverwiresapp.admin.scribe.MagentoScribeApi;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;
import com.silverwiresapp.admin.utils.propertiesutils.MagentoPropertiesUtils;

@Controller
@RequestMapping("/magento/auth")
public class MagentoScribeController {

	public static final Logger LOG = Logger.getLogger(MagentoScribeController.class);

	@RequestMapping(value = "/requestToken", method = RequestMethod.GET)
	public void requestToken(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			@RequestParam(value = "mag_key", required = true) String magKey,
			@RequestParam(value = "mag_secret", required = true) String magSecret,
			@RequestParam(value = "mag_url", required = true) String magURL,
			HttpServletRequest request, HttpServletResponse response) throws IOException {

		OAuthService service = new ServiceBuilder().provider(new MagentoScribeApi(magURL))
				.apiKey(magKey).apiSecret(magSecret)
				.callback(MagentoPropertiesUtils.OAUTH_CALLBACK_URL).build();

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
			//format URL to include http:// and www.
			if(!magURL.startsWith("http://")) {
				magURL="http://"+magURL;
			}
			mgTokens.setMagentoUrl(magURL);
			mgTokens.setApiKey(magKey);
			mgTokens.setApiSecret(magSecret);
			
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
			
			response.sendRedirect(authUrl);

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}

	}

	@RequestMapping(value = "/accessTokenCallback", method = RequestMethod.GET)
	public void accessTokenCallback(@RequestParam(value = "oauth_verifier", required = false) String oauthVerifier,
			HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		MagentoTokens mgTokens = (MagentoTokens) session.getAttribute("mgTokens");
		
		
		OAuthService service = new ServiceBuilder().provider(new MagentoScribeApi(mgTokens.getMagentoUrl()))
				.apiKey(mgTokens.getApiKey()).apiSecret(mgTokens.getApiSecret())
				.build();

		LOG.info("#### OAuthController ->  CALLBACK() - started ####");
		LOG.info("AccessTokenServlet");

		try {

			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			
			Token requestToken = (Token) session.getAttribute("requestToken");
			Verifier verifier = new Verifier(oauthVerifier);

			Token accessToken = service.getAccessToken(requestToken, verifier);

			// persists remaining tokens to db (access token and & access token
			// Secret)

			mgTokens.setAccessToken(accessToken.getToken());
			mgTokens.setAccessTokenSecret(accessToken.getSecret());

			HibernatePersistanceUtil.getSession().update(mgTokens);
			tx.commit();
			
			response.sendRedirect(MagentoPropertiesUtils.MAGENTO_POPUP_CLOSE_PAGE);

		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e.getLocalizedMessage());
		} finally {
			HibernatePersistanceUtil.closeSession();
			request.getSession().removeAttribute("mgTokens");
			request.getSession().removeAttribute("token");
		}
	}
	
	@RequestMapping(value = "/status", method = RequestMethod.POST)
	public void getMagentoStatus(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			// get from DB if the tokens are saved
			MagentoTokens mgTokens = MagentoHibernateHelper.getTokensBySwUserId(swUserId);
			
			String status = "";
			String storeURL = "";
			String magentoKey= "";
			if (mgTokens == null || StringUtils.isEmpty(mgTokens.getAccessTokenSecret())
					|| StringUtils.isEmpty(mgTokens.getAccessToken())) {
				status = "not-connected";
			} else {
				status = "connected";
				// get from Magento list of taxes - check if module is installed correctly
				MagentoTaxRate[] taxRates=MagentoRestGateway.listTaxes(swUserId);
				if(taxRates==null)
					throw new Exception("Unable to connect and get taxes from Magento");
				storeURL=mgTokens.getMagentoUrl();
				magentoKey = mgTokens.getApiKey();

			}

			response.getWriter().write("{\"status\":\"" + status + "\", \"magentoURL\":\"" + storeURL + "\", \"magentoKey\":\"" + magentoKey +"\"}");

		} catch (Exception ex) {
			ex.printStackTrace();
			throw new ServletException("Server internal error on retrieveing Magento data", ex);
		}

	}
	
}
