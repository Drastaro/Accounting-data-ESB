package com.silverwiresapp.admin.magento.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "magento_tokens")
public class MagentoTokens {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "SW_USER_ID", unique = true)
	private String swUserId;

	@Column(name = "CONSUMER_KEY")
	private String conusmerKey;

	@Column(name = "CONSUMER_SECRET")
	private String consumerSecret;

	@Column(name = "MAGENTO_URL")
	private String magentoUrl;

	@Column(name = "ACCESS_TOKEN")
	private String accessToken;

	@Column(name = "ACCESS_TOKEN_SECRET")
	private String accessTokenSecret;
	
	@Column(name = "API_KEY")
	private String apiKey;
	
	@Column(name = "API_SECRET")
	private String apiSecret;

	public MagentoTokens() {

	}

	public MagentoTokens(String swUserId) {

		this.swUserId = swUserId;
	}

	public MagentoTokens(String swUserId, String conusmerKey, String consumerSecret, String magentoUrl) {

		this.swUserId = swUserId;
		this.conusmerKey = conusmerKey;
		this.consumerSecret = consumerSecret;
		this.magentoUrl = magentoUrl;
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

	public String getMagentoUrl() {
		return magentoUrl;
	}

	public void setMagentoUrl(String magentoUrl) {
		this.magentoUrl = magentoUrl;
	}

	public String getApiKey() {
		return apiKey;
	}

	public void setApiKey(String apiKey) {
		this.apiKey = apiKey;
	}

	public String getApiSecret() {
		return apiSecret;
	}

	public void setApiSecret(String apiSecret) {
		this.apiSecret = apiSecret;
	}
	
}
