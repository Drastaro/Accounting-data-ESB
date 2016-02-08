package com.silverwiresapp.admin.magento.dao;

import org.hibernate.HibernateException;
import org.hibernate.Transaction;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Token;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuthService;
import com.google.gson.Gson;
import com.silverwiresapp.admin.magento.pojo.MagentoTaxRate;
import com.silverwiresapp.admin.magento.pojo.MagentoTokens;
import com.silverwiresapp.admin.scribe.MagentoScribeApi;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;
import com.silverwiresapp.admin.utils.dbpersistanceutils.MagentoHibernateHelper;
import com.silverwiresapp.admin.utils.propertiesutils.MagentoPropertiesUtils;

public class MagentoRestGateway {

	public static MagentoTaxRate[] listTaxes(String swUserId) {
		String result = getMagentoData(swUserId, "sw/taxes");
		if (result != null) {
			System.out.println(result);
			if (result.startsWith("\"") && result.endsWith("\"")) {
				result = result.substring(1, result.length() - 1);
			}
			MagentoTaxRate[] array = new MagentoTaxRate[1];
			MagentoTaxRate[] taxRates = new Gson().fromJson(result, array.getClass());
			return taxRates;
		}
		return null;
	}

	private static String getMagentoData(String swUserId, String action) {

		MagentoTokens mgTokens = MagentoHibernateHelper.getTokensBySwUserId(swUserId);

		OAuthService service = new ServiceBuilder().provider(new MagentoScribeApi(mgTokens.getMagentoUrl()))
				.apiKey(mgTokens.getApiKey()).apiSecret(mgTokens.getApiSecret()).build();

		try {

			Transaction tx = HibernatePersistanceUtil.getTransaction();
			tx.begin();

			Token accesToken = new Token(mgTokens.getAccessToken(), mgTokens.getAccessTokenSecret());
			OAuthRequest request = new OAuthRequest(Verb.GET,
					mgTokens.getMagentoUrl() + MagentoPropertiesUtils.MAGENTO_REST_URL + "/" + action, service);
			service.signRequest(accesToken, request);
			Response response = request.send();
			return response.getBody();
		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {

			HibernatePersistanceUtil.closeSession();
		}
		return null;
	}
}
