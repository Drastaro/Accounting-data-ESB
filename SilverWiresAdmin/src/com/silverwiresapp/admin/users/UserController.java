package com.silverwiresapp.admin.users;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.silverwiresapp.admin.users.dao.UsersDAO;

@Controller
@RequestMapping("/users")
public class UserController {

	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public void getClientById(@RequestParam(value = "user_id", required = true) String userId,
			HttpServletResponse response) throws ServletException, IOException {

		String uuid = UsersDAO.createUser(userId);

		response.getWriter().write("{ \"sw_user_id\": \"" + uuid + "\"}");

	}

}
