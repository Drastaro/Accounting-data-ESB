package com.silverwiresapp.admin.scribe;

import com.github.scribejava.core.builder.api.DefaultApi10a;
import com.github.scribejava.core.model.Token;
import com.silverwiresapp.admin.utils.propertiesutils.XeroPropertiesUtils;

public class XeroScribeApi extends DefaultApi10a {

	@Override
	public String getRequestTokenEndpoint() {
		return XeroPropertiesUtils.REQUEST_TOKEN_URL;
	}

	@Override
	public String getAccessTokenEndpoint() {
		return XeroPropertiesUtils.ACCESS_TOKEN_URL;
	}

	@Override
	public String getAuthorizationUrl(Token requestToken) {
		return XeroPropertiesUtils.AUTHORIZE_URL + "?oauth_token=" + requestToken.getToken();
	}

}
