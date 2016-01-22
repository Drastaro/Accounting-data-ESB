package com.silverwiresapp.admin.magento.pojo;

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

	@Column(name = "url")
	private String magentoURL;

	public MagentoAuthData() {

	}

	public MagentoAuthData(String swUserId, String magentoURL) {

		this.swUserId = swUserId;
		this.magentoURL = magentoURL;
	}

	public MagentoAuthData(int id, String swUserId, String magentoURL) {

		this.id = id;
		this.swUserId = swUserId;
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
