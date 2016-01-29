package com.silverwiresapp.admin.scribe;

import com.github.scribejava.core.builder.api.DefaultApi10a;
import com.github.scribejava.core.model.Token;
import com.silverwiresapp.admin.utils.propertiesutils.MagentoPropertiesUtils;

public class MagentoScribeApi extends DefaultApi10a {

	private String baseMagentoURL;
	
	public MagentoScribeApi(String baseMagentoURL) {
		if(!baseMagentoURL.startsWith("http://")) {
			baseMagentoURL = "http://"+baseMagentoURL;
		}
		if(baseMagentoURL.endsWith("/") || baseMagentoURL.endsWith("\\"))
			baseMagentoURL.substring(0, baseMagentoURL.length()-1);
		this.baseMagentoURL=baseMagentoURL;
	}
	
	@Override
	public String getAccessTokenEndpoint() {
		return this.baseMagentoURL+MagentoPropertiesUtils.ACCES_TOKEN_URL;
	}

	@Override
	public String getRequestTokenEndpoint() {
		return this.baseMagentoURL+MagentoPropertiesUtils.REQUEST_TOKEN_URL;
	}

	@Override
	public String getAuthorizationUrl(Token requestToken) {
		return this.baseMagentoURL+MagentoPropertiesUtils.AUTHORIZE_URL + "?oauth_token=" + requestToken.getToken();
	}

}
