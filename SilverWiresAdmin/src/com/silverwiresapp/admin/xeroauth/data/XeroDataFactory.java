package com.silverwiresapp.admin.xeroauth.data;

import com.google.api.client.auth.oauth.OAuthHmacSigner;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.silverwiresapp.admin.xeroauth.controller.OAuthGetResource;
import com.silverwiresapp.admin.xeroauth.controller.XeroPropertiesUtils;
import com.silverwiresapp.admin.xeroauth.pojo.XeroTokens;

public class XeroDataFactory {

	public static OAuthGetResource getOauthResource(String resourceName, XeroTokens tokens) {
		OAuthGetResource getResource = new OAuthGetResource(XeroPropertiesUtils.XERO_URL + resourceName);
		getResource.signer = createSigner(tokens.getAccessTokenSecret());
		getResource.consumerKey = XeroPropertiesUtils.OAUTH_CONSUMER_KEY;
		getResource.token = tokens.getAccessToken();
		getResource.transport = new NetHttpTransport();

		return getResource;
	}

	private static OAuthHmacSigner createSigner(String accessTokenSecret) {
		OAuthHmacSigner signer = new OAuthHmacSigner();
		signer.clientSharedSecret = XeroPropertiesUtils.OAUTH_CONSUMER_SECRET;
		signer.tokenSharedSecret = accessTokenSecret;
		return signer;
	}

}
