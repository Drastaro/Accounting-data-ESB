package com.silverwiresapp.admin.magento.auth_data.dao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "magento_data")
public class MagentoAuthData {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@Column(name = "sw_user_id", unique = true)
	private String swUserId;

	@Column(name = "username")
	private String magentoUsername;

	@Column(name = "pass")
	private String magentoPass;

	@Column(name = "url")
	private String magentoURL;

	public MagentoAuthData() {

	}

	public MagentoAuthData(String swUserId, String magentoUsername, String magentoPass, String magentoURL) {
		this.swUserId = swUserId;
		this.magentoUsername = magentoUsername;
		this.magentoPass = magentoPass;
		this.magentoURL = magentoURL;
	}

	public MagentoAuthData(int id, String swUserId, String magentoUsername, String magentoPass, String magentoURL) {
		super();
		this.id = id;
		this.swUserId = swUserId;
		this.magentoUsername = magentoUsername;
		this.magentoPass = magentoPass;
		this.magentoURL = magentoURL;
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

	public String getMagentoUsername() {
		return magentoUsername;
	}

	public void setMagentoUsername(String magentoUsername) {
		this.magentoUsername = magentoUsername;
	}

	public String getMagentoPass() {
		return magentoPass;
	}

	public void setMagentoPass(String magentoPass) {
		this.magentoPass = magentoPass;
	}

	public String getMagentoURL() {
		return magentoURL;
	}

	public void setMagentoURL(String magentoURL) {
		this.magentoURL = magentoURL;
	}

	public String getMagentoAPIURL() {
		String result = "";
		if (!magentoURL.startsWith("http://")) {
			result = "http://" + magentoURL;
		}
		result = result + "/api/soap";
		return result;
	}

}
