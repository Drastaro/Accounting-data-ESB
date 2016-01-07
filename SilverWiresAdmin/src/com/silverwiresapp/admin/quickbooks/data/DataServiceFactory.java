package com.silverwiresapp.admin.quickbooks.data;

import com.intuit.ipp.core.Context;
import com.intuit.ipp.core.ServiceType;
import com.intuit.ipp.exception.FMSException;
import com.intuit.ipp.security.IAuthorizer;
import com.intuit.ipp.security.OAuthAuthorizer;
import com.intuit.ipp.services.DataService;

public class DataServiceFactory {

	public DataService getDataService(QuickBooksTokens tokens) {
		

		IAuthorizer authorizer = new OAuthAuthorizer(QuickBooksPropertiesUtils.OAUTH_CONSUMER_KEY,
				QuickBooksPropertiesUtils.OAUTH_CONSUMER_SECRET, tokens.getAccessToken(),
				tokens.getAccessTokenSecret());

		Context context;
		try {
			context = new Context(authorizer, ServiceType.QBO,
					tokens.getQboCompanyId());
		
		} catch (FMSException e) {
			throw new RuntimeException(
					"Could not initialize Intuit context object", e);
		}

		return new DataService(context);
	}

	
}
