package com.silverwiresapp.admin.users.pojo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="sw_user")
public class UserData {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@Column(name = "sw_user_id", unique = true)
	private String swUserId;

	@Column(name = "app_user_id")
	private String appUserId;

	public UserData() {

	}

	public UserData(String swUserId, String appUserId) {
		this.swUserId = swUserId;
		this.appUserId = appUserId;
	}

	public UserData(int id, String swUserId, String appUserId) {
		this.id = id;
		this.swUserId = swUserId;
		this.appUserId = appUserId;
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

	public String getAppUserId() {
		return appUserId;
	}

	public void setAppUserId(String appUserId) {
		this.appUserId = appUserId;
	}

}
