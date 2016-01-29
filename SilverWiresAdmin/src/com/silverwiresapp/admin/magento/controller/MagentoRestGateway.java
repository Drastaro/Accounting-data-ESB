package com.silverwiresapp.admin.magento.controller;

import com.google.gson.Gson;
import com.silverwiresapp.admin.magento.dao.MagentoQueryDAO;
import com.silverwiresapp.admin.magento.pojo.MagentoTaxRate;

public class MagentoRestGateway {

	
	public static MagentoTaxRate[] listTaxes(String swUserId) {
		String result=MagentoQueryDAO.getMagentoData(swUserId, "sw/taxes");
		if(result!=null) {
			MagentoTaxRate[] taxRates= new Gson().fromJson(result, MagentoTaxRate.class);
			return taxRates;
		}
		return null;

	}
	
	
	public static String listOrders(String swUserId) {
		//TODO return type
		MagentoQueryDAO.getMagentoData(swUserId, "orders");

		return null;

	}

	public static void getOrderById(String swUserId, String id) {
		//TODO return type
		MagentoQueryDAO.getMagentoDataById(swUserId, "orders", id);

	}

	public static void listCustomers(String swUserId) {
		//TODO return type
		MagentoQueryDAO.getMagentoData(swUserId, "customers");

	}

	public static void getCustomerById(String swUserId,String id) {

		//TODO return type
		MagentoQueryDAO.getMagentoDataById(swUserId, "customers", id);

	}

}
