package com.silverwiresapp.admin.xeroauth.dao;

import org.hibernate.Transaction;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Token;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuthService;
import com.silverwiresapp.admin.scribe.XeroScribeApi;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;
import com.silverwiresapp.admin.utils.dbpersistanceutils.XeroHibernateHelper;
import com.silverwiresapp.admin.utils.propertiesutils.XeroPropertiesUtils;
import com.silverwiresapp.admin.xeroauth.pojo.XeroTokens;

public class XeroQueryDAO {

	public static String getXeroData(String swUserId, String action) {

		OAuthService service = new ServiceBuilder().provider(XeroScribeApi.class)
				.apiKey(XeroPropertiesUtils.OAUTH_CONSUMER_KEY).apiSecret(XeroPropertiesUtils.OAUTH_CONSUMER_SECRET)
				.callback(XeroPropertiesUtils.OAUTH_CALLBACK_URL).build();

		try {
			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			XeroTokens xeroTokens = XeroHibernateHelper.getTokensBySwUserId(swUserId);
			Token accesToken = new Token(xeroTokens.getAccessToken(), xeroTokens.getAccessTokenSecret());
			System.out.println(xeroTokens.getAccessToken() + "\n" + xeroTokens.getAccessTokenSecret());

			OAuthRequest request = new OAuthRequest(Verb.GET, XeroPropertiesUtils.XERO_URL + action, service);
			service.signRequest(accesToken, request);
			Response response = request.send();
			System.out.println("Got it! Lets see what we found...");
			System.out.println();
			System.out.println(response.getBody());

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			HibernatePersistanceUtil.closeSession();
		}
		return null;
	}

	public static String createXeroData(String swUserId, String action) {

		OAuthService service = new ServiceBuilder().provider(XeroScribeApi.class)
				.apiKey(XeroPropertiesUtils.OAUTH_CONSUMER_KEY).apiSecret(XeroPropertiesUtils.OAUTH_CONSUMER_SECRET)
				.callback(XeroPropertiesUtils.OAUTH_CALLBACK_URL).build();

		try {
			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			XeroTokens xeroTokens = XeroHibernateHelper.getTokensBySwUserId(swUserId);
			Token accesToken = new Token(xeroTokens.getAccessToken(), xeroTokens.getAccessTokenSecret());
			System.out.println(xeroTokens.getAccessToken() + "\n" + xeroTokens.getAccessTokenSecret());

			OAuthRequest request = new OAuthRequest(Verb.POST, XeroPropertiesUtils.XERO_URL + action, service);
			service.signRequest(accesToken, request);

			request.addQuerystringParameter("name", "Barta.Janos");
			request.addQuerystringParameter("firstName", "Barta");
			request.addQuerystringParameter("lastName", "Janos");
			request.addQuerystringParameter("contactID", "22222222-2222-2222-22222222222");
			request.addQuerystringParameter("email", "Janos@yahoo.com");

			Response response = request.send();
			System.out.println("Got it! Lets see what we found...");
			System.out.println();
			System.out.println(response.getBody());

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			HibernatePersistanceUtil.closeSession();
		}
		return null;

	}
}
