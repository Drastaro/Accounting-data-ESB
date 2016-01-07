package com.silverwiresapp.admin.magento.auth_data.dao;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

@Controller
@RequestMapping("/magento/auth")
public class MagentoAuthController {

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void saveMagentoAuthData(
			@RequestParam(value = "sw_user_id", required = true) String sw_user_id,
			@RequestParam(value = "mag_username", required = true) String magUsername,
			@RequestParam(value = "mag_pass", required = true) String magPass,
			@RequestParam(value = "mag_url", required = true) String magURL,
			HttpServletResponse response) throws ServletException, IOException {

		System.out.println("Save magento data in db");
		// save in db
		try {
			MagentoAuthDAO.saveData(sw_user_id, magUsername, magPass, magURL);
		} catch (SQLException ex) {
			throw new ServletException(
					"Server internal error on saving Magento data");
		}

		// return the newly created uuid
		response.getWriter().write("{ \"result\": \"true\"}");
	}

	@RequestMapping(value = "/get", method = RequestMethod.POST)
	public void getMagentoAuthData(
			@RequestParam(value = "sw_user_id", required = true) String sw_user_id,
			HttpServletResponse response) throws ServletException, IOException {

		// save in db
		try {
			MagentoAuthData magentoData = MagentoAuthDAO
					.getMagentoAuthDataBySwUserIdWithoutPass(sw_user_id);
			// return the newly created uuid
			String resp = new Gson().toJson(magentoData);
			System.out.println("MagentoData response as JSON===" + resp);
			response.getWriter().write(resp);

		} catch (SQLException ex) {
			throw new ServletException(
					"Server internal error on retrieveing Magento data");
		}

	}

}
