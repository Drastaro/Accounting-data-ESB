package com.silverwiresapp.admin.quickbooks.data;

import java.util.List;

import com.intuit.ipp.core.IEntity;
import com.intuit.ipp.data.Account;
import com.intuit.ipp.data.CompanyInfo;
import com.intuit.ipp.data.TaxRate;
import com.intuit.ipp.exception.FMSException;
import com.intuit.ipp.services.DataService;
import com.intuit.ipp.services.QueryResult;
import com.intuit.ipp.util.Config;

public class QuickBooksDataGateway {

	static {

	}

	public static CompanyInfo getCompanyInfo(QuickBooksTokens tokens) {
		Config.setProperty(Config.BASE_URL_QBO, QuickBooksPropertiesUtils.QBO_URL);
		DataServiceFactory dataServiceFactory = new DataServiceFactory();
		DataService dataService = dataServiceFactory.getDataService(tokens);
		String query = "select * from CompanyInfo ";
		return executeQuery(dataService, query, CompanyInfo.class);
	}

	public static List<Account> getItemsIncomeAccounts(QuickBooksTokens tokens) {
		Config.setProperty(Config.BASE_URL_QBO, QuickBooksPropertiesUtils.QBO_URL);
		DataServiceFactory dataServiceFactory = new DataServiceFactory();
		DataService dataService = dataServiceFactory.getDataService(tokens);

		String query = "select * from account where AccountType='Income'";
		return executeQueryList(dataService, query, Account.class);
	}

	public static List<TaxRate> getTaxes(QuickBooksTokens tokens) {
		Config.setProperty(Config.BASE_URL_QBO, QuickBooksPropertiesUtils.QBO_URL);
		DataServiceFactory dataServiceFactory = new DataServiceFactory();
		DataService dataService = dataServiceFactory.getDataService(tokens);

		String query = "select * from TaxRate";
		return executeQueryList(dataService, query, TaxRate.class);
	}

	private static com.intuit.ipp.data.Customer findExistingCustomer(DataService dataService, String firstName) {
		String query = String.format("select * from customer where active = true and givenName = '%s'", firstName);
		return executeQuery(dataService, query, com.intuit.ipp.data.Customer.class);
	}

	private static <T extends IEntity> T executeQuery(DataService dataService, String query, Class<T> qboType) {
		try {

			final QueryResult queryResult = dataService.executeQuery(query);
			final List<? extends IEntity> entities = queryResult.getEntities();
			if (entities.size() == 0) {
				return null;
			} else {
				final IEntity entity = entities.get(0);
				return (T) entity;
			}

		} catch (FMSException e) {
			throw new RuntimeException("Failed to execute an entity query: " + query, e);
		}
	}

	private static <T extends IEntity> List<T> executeQueryList(DataService dataService, String query,
			Class<T> qboType) {
		try {
			final QueryResult queryResult = dataService.executeQuery(query);
			return (List<T>) queryResult.getEntities();

		} catch (FMSException e) {
			throw new RuntimeException("Failed to execute an entity query: " + query, e);
		}
	}

}
