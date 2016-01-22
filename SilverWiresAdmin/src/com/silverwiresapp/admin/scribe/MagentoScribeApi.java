package com.silverwiresapp.admin.scribe;

import com.github.scribejava.core.builder.api.DefaultApi10a;
import com.github.scribejava.core.model.Token;
import com.silverwiresapp.admin.utils.propertiesutils.MagentoPropertiesUtils;

public class MagentoScribeApi extends DefaultApi10a {

	@Override
	public String getAccessTokenEndpoint() {
		return MagentoPropertiesUtils.ACCES_TOKEN_URL;
	}

	@Override
	public String getRequestTokenEndpoint() {
		return MagentoPropertiesUtils.REQUEST_TOKEN_URL;
	}

	@Override
	public String getAuthorizationUrl(Token requestToken) {
		return MagentoPropertiesUtils.AUTHORIZE_URL + "?oauth_token=" + requestToken.getToken();
	}

}
