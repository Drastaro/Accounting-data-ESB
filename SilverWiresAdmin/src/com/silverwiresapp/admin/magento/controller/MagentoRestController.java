package com.silverwiresapp.admin.magento.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.silverwiresapp.admin.magento.dao.MagentoQueryDAOImpl;

@Controller
@RequestMapping(value = "/magento/rest")
public class MagentoRestController {

	@RequestMapping(value = "/{action}", method = RequestMethod.GET)
	public void restTest(@PathVariable("action") String action, @RequestParam(value = "sw_user_Id") String swUserId) {

		MagentoQueryDAOImpl.getInvoice(swUserId, action);

	}

}
