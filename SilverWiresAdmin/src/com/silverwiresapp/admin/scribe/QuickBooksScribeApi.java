package com.silverwiresapp.admin.scribe;

import com.github.scribejava.core.builder.api.DefaultApi10a;
import com.github.scribejava.core.model.Token;
import com.silverwiresapp.admin.utils.propertiesutils.QuickBooksPropertiesUtils;

public class QuickBooksScribeApi extends DefaultApi10a {

	@Override
	public String getRequestTokenEndpoint() {
		return QuickBooksPropertiesUtils.REQUEST_TOKEN_URL;
	}

	@Override
	public String getAccessTokenEndpoint() {
		return QuickBooksPropertiesUtils.ACCESS_TOKEN_URL;
	}

	@Override
	public String getAuthorizationUrl(Token requestToken) {
		return QuickBooksPropertiesUtils.AUTHORIZE_URL + "?oauth_token=" + requestToken.getToken();
	}

}
