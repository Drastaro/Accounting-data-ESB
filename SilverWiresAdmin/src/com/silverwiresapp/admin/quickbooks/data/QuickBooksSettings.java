package com.silverwiresapp.admin.quickbooks.data;

import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.google.gson.Gson;

@Entity
@Table(name="quickbooks_settings")
public class QuickBooksSettings {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@Column(name = "sw_user_id", unique = true)
	private String swUserId;

	@Transient
	private String companyName;

	@Transient
	private Map<String, String> incomeAccounts;

	@Column(name = "income_account_id")
	private int selectedIncomeAccountId;

	@Transient
	private Map<String, String> qbTaxes;

	@Transient
	private Map<String, String> magentoTaxes;
	// json value with pairs first being magento tax id and second qb tax id

	@Column(name = "taxes_mapping")
	private String magQBTaxesMapping;

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

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public Map<String, String> getIncomeAccounts() {
		return incomeAccounts;
	}

	public void setIncomeAccounts(Map<String, String> incomeAccounts) {
		this.incomeAccounts = incomeAccounts;
	}

	public int getSelectedIncomeAccountId() {
		return selectedIncomeAccountId;
	}

	public void setSelectedIncomeAccountId(int selectedIncomeAccountId) {
		this.selectedIncomeAccountId = selectedIncomeAccountId;
	}

	public Map<String, String> getQbTaxes() {
		return qbTaxes;
	}

	public void setQbTaxes(Map<String, String> qbTaxes) {
		this.qbTaxes = qbTaxes;
	}

	public Map<String, String> getMagentoTaxes() {
		return magentoTaxes;
	}

	public void setMagentoTaxes(Map<String, String> magentoTaxes) {
		this.magentoTaxes = magentoTaxes;
	}

	public String getMagQBTaxesMapping() {
		return magQBTaxesMapping;
	}

	public void setMagQBTaxesMapping(String magQBTaxesMapping) {
		this.magQBTaxesMapping = magQBTaxesMapping;
	}

	public void setMagQBTaxesMapping(Map<String, String> magQBTaxesMapping) {
		Gson gson = new Gson();
		this.magQBTaxesMapping = gson.toJson(magQBTaxesMapping);
		;
	}

}
