package com.silverwiresapp.admin.xeroauth.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.silverwiresapp.admin.xeroauth.dao.XeroQueryDAO;

@Controller
@RequestMapping(value = "/xero/rest")
public class XeroScribeRestController {

	@RequestMapping(value = "/listContacts", method = RequestMethod.GET)
	public void listContacts(@RequestParam("sw_user_id") String swUserId) {

		XeroQueryDAO.getXeroData(swUserId, "contacts");

	}
	//
	// @RequestMapping(value = "/createContact", method = RequestMethod.GET)
	// public void createContact(@RequestParam("sw_user_id") String swUserId) {
	//
	// XeroQueryDAO.createXeroData(swUserId, "contacts");
	//
	// }

	@RequestMapping(value = "/listAccounts", method = RequestMethod.GET)
	public void listAccounts(@RequestParam("sw_user_id") String swUserId) {

		XeroQueryDAO.getXeroData(swUserId, "accounts");
	}

	@RequestMapping(value = "/listBankTransactions", method = RequestMethod.GET)
	public void listBankTransactions(@RequestParam("sw_user_id") String swUserId) {

		XeroQueryDAO.getXeroData(swUserId, "banktransactions");
	}

	@RequestMapping(value = "/listInvoices", method = RequestMethod.GET)
	public void listInvoices(@RequestParam("sw_user_id") String swUserId) {

		XeroQueryDAO.getXeroData(swUserId, "invoices");
	}

	@RequestMapping(value = "/listTaxRates", method = RequestMethod.GET)
	public void listTaxRates(@RequestParam("sw_user_id") String swUserId) {

		XeroQueryDAO.getXeroData(swUserId, "taxrates");
	}

	@RequestMapping(value = "/listUsers", method = RequestMethod.GET)
	public void listUsers(@RequestParam("sw_user_id") String swUserId) {

		XeroQueryDAO.getXeroData(swUserId, "users");
	}

}
