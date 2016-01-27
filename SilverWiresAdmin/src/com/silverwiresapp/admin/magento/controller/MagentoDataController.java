package com.silverwiresapp.admin.magento.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.silverwiresapp.admin.magento.dao.MagentoAuthDAO;
import com.silverwiresapp.admin.magento.pojo.MagentoAuthData;

@Controller
@RequestMapping("/magento/data")
public class MagentoDataController {

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void saveMagentoAuthData(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			@RequestParam(value = "mag_url", required = true) String magURL, HttpServletResponse response)
					throws ServletException, IOException {

		System.out.println("Save magento data in db");
		// save in db
		try {
			MagentoAuthDAO.saveData(swUserId, magURL);
		} catch (SQLException ex) {
			throw new ServletException("Server internal error on saving Magento data");
		}

		// return the newly created uuid
		response.getWriter().write("{ \"result\": \"true\"}");
	}

	@RequestMapping(value = "/get", method = RequestMethod.POST)
	public void getMagentoAuthData(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			HttpServletResponse response) throws ServletException, IOException {

		// save in db
		try {
			MagentoAuthData magentoData = MagentoAuthDAO.getMagentoAuthDataBySwUserId(swUserId);
			// return the newly created uuid
			String resp = new Gson().toJson(magentoData);
			System.out.println("MagentoData response as JSON===" + resp);
			response.getWriter().write(resp);

		} catch (SQLException ex) {
			throw new ServletException("Server internal error on retrieveing Magento data");
		}

	}

}
