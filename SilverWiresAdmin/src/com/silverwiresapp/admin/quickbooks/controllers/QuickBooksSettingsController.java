package com.silverwiresapp.admin.quickbooks.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.google.gson.Gson;
import com.intuit.ipp.data.Account;
import com.intuit.ipp.data.CompanyInfo;
import com.intuit.ipp.data.TaxRate;
import com.silverwiresapp.admin.magento.dao.MagentoAuthDAO;
import com.silverwiresapp.admin.magento.data.MagentoGateway;
import com.silverwiresapp.admin.magento.pojo.MagentoAuthData;
import com.silverwiresapp.admin.magento.pojo.MagentoTaxRate;
import com.silverwiresapp.admin.quickbooks.auth_data.dao.QuickBooksDAO;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksDataGateway;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksSettings;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksTokens;

@Controller
@RequestMapping("/quickbooks/settings")
public class QuickBooksSettingsController {

	@RequestMapping(value = "/get", method = RequestMethod.POST)
	public void getQuickbooksSettings(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			// get from DB if the tokens are saved
			QuickBooksTokens tokens = QuickBooksDAO.getTokensBySwUserId(swUserId);

			// get from Quickbooks company name

			CompanyInfo companyInfo = QuickBooksDataGateway.getCompanyInfo(tokens);

			// get from quikbooks income accounts - to be set for items
			List<Account> incomeAccounts = QuickBooksDataGateway.getItemsIncomeAccounts(tokens);

			// get from quickbooks taxes list - See TaxCode
			List<TaxRate> taxes = QuickBooksDataGateway.getTaxes(tokens);

			// get from magento list of registered tax rates
			MagentoAuthData magentoData = MagentoAuthDAO.getMagentoAuthDataBySwUserId(swUserId);
			// MagentoTaxRate[] magentoTaxes =
			// MagentoGateway.getMagentoTaxRates(magentoData);
			MagentoTaxRate[] magentoTaxes = new MagentoTaxRate[0];

			Map<String, String> incomeAccountsMap = getIncomeAccountsMap(incomeAccounts);
			Map<String, String> taxesMap = getTaxesMap(taxes);
			Map<String, String> magentTaxesMap = getMagentoTaxesMap(magentoTaxes);
			taxesMap.put("-1", "No tax mapping");
			QuickBooksSettings qbSettings = QuickBooksDAO.getSettingsByUserId(swUserId);

			if (qbSettings == null) {
				qbSettings = new QuickBooksSettings();
			}

			qbSettings.setCompanyName(companyInfo.getCompanyName());
			qbSettings.setIncomeAccounts(incomeAccountsMap);
			qbSettings.setQbTaxes(taxesMap);
			qbSettings.setMagentoTaxes(magentTaxesMap);

			if (qbSettings.getMagQBTaxesMapping() == null || qbSettings.getMagQBTaxesMapping().isEmpty()) {
				qbSettings.setMagQBTaxesMapping(new HashMap<String, String>());
			}

			String resp = new Gson().toJson(qbSettings);
			System.out.println("QBSettings response as JSON===" + resp);
			response.getWriter().write(resp);

		} catch (Exception ex) {
			ex.printStackTrace();
			throw new ServletException("Server internal error on retrieveing Quickbooks settings");
		}

	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void saveQuickbooksSettings(@RequestParam(value = "sw_user_id", required = true) String swUserId,
			@RequestParam(value = "incomeAccount", required = true) Integer incomeAccount, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		System.out.println("Save quickbooks data in db");

		Map<String, String[]> params = request.getParameterMap();
		// indentify magento - QB taxes mapping and save in a map
		Map<String, String> magQBTaxesIds = new HashMap<String, String>();
		for (String key : params.keySet()) {
			String[] val = params.get(key);
			for (String value : val) {
				if (key.startsWith("taxes[") && key.endsWith("[mag]")) {
					String id = key.substring(6, key.indexOf("]"));
					String magTaxId = value;
					String qbTaxId = params.get("taxes[" + id + "][qb]")[0];
					magQBTaxesIds.put(magTaxId, qbTaxId);
				}
			}
		}

		// save in db
		try {
			QuickBooksSettings settings = new QuickBooksSettings();
			settings.setSelectedIncomeAccountId(incomeAccount);
			settings.setMagQBTaxesMapping(magQBTaxesIds);
			QuickBooksDAO.insertSettings(swUserId, settings);
		} catch (SQLException ex) {
			ex.printStackTrace();
			throw new ServletException("Server internal error on saving Quickbooks data");
		}

		// return the newly created uuid
		response.getWriter().write("{ \"result\": \"true\"}");
	}

	private Map<String, String> getIncomeAccountsMap(List<Account> incomeAccounts) {
		Map<String, String> result = new HashMap<String, String>();
		for (Account acc : incomeAccounts) {
			result.put(acc.getId(), acc.getName());
		}

		return result;
	}

	private Map<String, String> getTaxesMap(List<TaxRate> taxes) {
		Map<String, String> result = new HashMap<String, String>();
		for (TaxRate tax : taxes) {
			result.put(tax.getId(), tax.getName());
		}

		return result;
	}

	private Map<String, String> getMagentoTaxesMap(MagentoTaxRate[] taxes) {
		Map<String, String> result = new HashMap<String, String>();
		for (MagentoTaxRate tax : taxes) {
			result.put(tax.getValue(), tax.getLabel());
		}

		return result;
	}

}
