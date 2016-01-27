package com.silverwiresapp.admin.magento.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.silverwiresapp.admin.magento.dao.MagentoQueryDAO;

@Controller
@RequestMapping(value = "/magento/rest")
public class MagentoRestController {

	@RequestMapping(value = "/listOrders", method = RequestMethod.GET)
	public String listOrders(@RequestParam(value = "sw_user_id") String swUserId, HttpServletRequest request,
			HttpServletResponse response) {

		MagentoQueryDAO.getMagentoData(swUserId, "orders");

		return null;

	}

	@RequestMapping(value = "/getOrderById", method = RequestMethod.GET)
	public void getOrdersById(@RequestParam(value = "sw_user_id") String swUserId,
			@RequestParam(value = "id") String id) {

		MagentoQueryDAO.getMagentoDataById(swUserId, "orders", id);

	}

	@RequestMapping(value = "/listCustomers", method = RequestMethod.GET)
	public void listCustomers(@RequestParam(value = "sw_user_id") String swUserId, HttpServletRequest request,
			HttpServletResponse response) {

		MagentoQueryDAO.getMagentoData(swUserId, "customers");

	}

	@RequestMapping(value = "/getCustomerById", method = RequestMethod.GET)
	public void getCustomersById(@RequestParam(value = "sw_user_id") String swUserId,
			@RequestParam(value = "id") String id) {

		MagentoQueryDAO.getMagentoDataById(swUserId, "customers", id);

	}

}
