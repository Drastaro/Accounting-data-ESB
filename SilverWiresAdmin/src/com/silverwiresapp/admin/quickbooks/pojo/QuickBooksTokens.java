package com.silverwiresapp.admin.quickbooks.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "quickbooks_tokens")
public class QuickBooksTokens {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private long id;

	@Column(name = "SW_USER_ID", unique = true)
	private String swUserId;

	@Transient
	private boolean connectedToQbo;

	@Column(name = "COMPANY_ID")
	private String qboCompanyId;

	@Column(name = "CONSUMER_KEY")
	private String requestToken;

	@Column(name = "CONSUMER_SECRET")
	private String requestTokenSecret;

	@Column(name = "ACCESS_TOKEN")
	private String accessToken;

	@Column(name = "ACCESS_TOKEN_SECRET")
	private String accessTokenSecret;

	@Column(name = "AUTH_URL")
	private String authUrl;

	public QuickBooksTokens() {

	}

	public QuickBooksTokens(String swUserId, String requestToken, String requestTokenSecret, String accessToken,
			String accessTokenSecret, String authUrl) {
		this.swUserId = swUserId;
		this.requestToken = requestToken;
		this.requestTokenSecret = requestTokenSecret;
		this.accessToken = accessToken;
		this.accessTokenSecret = accessTokenSecret;
		this.authUrl = authUrl;
	}

	public QuickBooksTokens(String qboCompanyId, String accessToken, String accessTokenSecret) {
		this.qboCompanyId = qboCompanyId;
		this.accessToken = accessToken;
		this.accessTokenSecret = accessTokenSecret;
		this.connectedToQbo = true;
	}

	public QuickBooksTokens(String swUserId) {
		this.swUserId = swUserId;
		this.connectedToQbo = false;
	}

	public long getId() {
		return id;
	}

	public String getQboCompanyId() {
		return qboCompanyId;
	}

	public void setQboCompanyId(String qboCompanyId) {
		this.qboCompanyId = qboCompanyId;
	}

	public String getRequestToken() {
		return requestToken;
	}

	public void setRequestToken(String requestToken) {
		this.requestToken = requestToken;
	}

	public String getRequestTokenSecret() {
		return requestTokenSecret;
	}

	public void setRequestTokenSecret(String requestTokenSecret) {
		this.requestTokenSecret = requestTokenSecret;
	}

	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	public String getAccessTokenSecret() {
		return accessTokenSecret;
	}

	public void setAccessTokenSecret(String accessTokenSecret) {
		this.accessTokenSecret = accessTokenSecret;
	}

	public String getSwUserId() {
		return swUserId;
	}

	public void setSwUserId(String swUserId) {
		this.swUserId = swUserId;
	}

	public boolean isConnectedToQbo() {
		return connectedToQbo;
	}

	public void setConnectedToQbo(boolean connectedToQbo) {
		this.connectedToQbo = connectedToQbo;
	}

	public String getAuthUrl() {
		return authUrl;
	}

	public void setAuthUrl(String authUrl) {
		this.authUrl = authUrl;
	}

}
