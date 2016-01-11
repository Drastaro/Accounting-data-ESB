package com.silverwiresapp.admin.xeroauth.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "xero_tokens")
public class XeroTokens {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "SW_USER_ID", unique = true)
	private String swUserId;

	@Column(name = "CONSUMER_KEY")
	private String conusmerKey;

	@Column(name = "CONSUMER_SECRET")
	private String consumerSecret;

	@Column(name = "AUTH_URL")
	private String authUrl;

	@Column(name = "ACCESS_TOKEN")
	private String accessToken;

	@Column(name = "ACCESS_TOKEN_SECRET")
	private String accessTokenSecret;

	public XeroTokens() {

	}

	public XeroTokens(String swUserId) {

		this.swUserId = swUserId;

	}

	public XeroTokens(String conusmerKey, String consumerSecret, String authUrl) {
		this.conusmerKey = conusmerKey;
		this.consumerSecret = consumerSecret;
		this.authUrl = authUrl;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSwUserId() {
		return swUserId;
	}

	public void setSwUserId(String swUserId) {
		this.swUserId = swUserId;
	}

	public String getConusmerKey() {
		return conusmerKey;
	}

	public void setConusmerKey(String conusmerKey) {
		this.conusmerKey = conusmerKey;
	}

	public String getConsumerSecret() {
		return consumerSecret;
	}

	public void setConsumerSecret(String consumerSecret) {
		this.consumerSecret = consumerSecret;
	}

	public String getAuthUrl() {
		return authUrl;
	}

	public void setAuthUrl(String authUrl) {
		this.authUrl = authUrl;
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

}
