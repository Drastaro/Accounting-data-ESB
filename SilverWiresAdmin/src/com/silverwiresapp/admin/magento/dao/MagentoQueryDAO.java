package com.silverwiresapp.admin.magento.dao;

import org.hibernate.HibernateException;
import org.hibernate.Transaction;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Token;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuthService;
import com.silverwiresapp.admin.magento.data.MagentoHibernateHelper;
import com.silverwiresapp.admin.magento.pojo.MagentoTokens;
import com.silverwiresapp.admin.scribe.MagentoScribeApi;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;
import com.silverwiresapp.admin.utils.propertiesutils.MagentoPropertiesUtils;

public class MagentoQueryDAO {

	public static String getMagentoData(String swUserId, String action) {

		OAuthService service = new ServiceBuilder().provider(MagentoScribeApi.class)
				.apiKey(MagentoPropertiesUtils.MAGENTO_API_KEY).apiSecret(MagentoPropertiesUtils.MAGENTO_API_SECRET)
				.callback(MagentoPropertiesUtils.OAUTH_CALLBACK_URL).build();

		try {

			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			MagentoTokens mgTokens = MagentoHibernateHelper.getTokensBySwUserId(swUserId);
			Token accesToken = new Token(mgTokens.getAccessToken(), mgTokens.getAccessTokenSecret());

			OAuthRequest request = new OAuthRequest(Verb.GET, MagentoPropertiesUtils.MAGENTO_REST_URL + "/" + action,
					service);
			service.signRequest(accesToken, request);
			Response response = request.send();
			System.out.println("Got it! Lets see what we found...");
			System.out.println();
			System.out.println(response.getBody());
		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {

			HibernatePersistanceUtil.closeSession();

		}
		return null;
	}

	public static String getMagentoDataById(String swUserId, String action, String id) {

		OAuthService service = new ServiceBuilder().provider(MagentoScribeApi.class)
				.apiKey(MagentoPropertiesUtils.MAGENTO_API_KEY).apiSecret(MagentoPropertiesUtils.MAGENTO_API_SECRET)
				.callback(MagentoPropertiesUtils.OAUTH_CALLBACK_URL).build();

		try {

			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			MagentoTokens mgTokens = MagentoHibernateHelper.getTokensBySwUserId(swUserId);
			Token accesToken = new Token(mgTokens.getAccessToken(), mgTokens.getAccessTokenSecret());

			OAuthRequest request = new OAuthRequest(Verb.GET,
					MagentoPropertiesUtils.MAGENTO_REST_URL + "/" + action + "/" + id, service);
			service.signRequest(accesToken, request);
			Response response = request.send();
			System.out.println("Got it! Lets see what we found...");
			System.out.println();
			System.out.println(response.getBody());
		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {

			HibernatePersistanceUtil.closeSession();

		}
		return null;
	}

}
