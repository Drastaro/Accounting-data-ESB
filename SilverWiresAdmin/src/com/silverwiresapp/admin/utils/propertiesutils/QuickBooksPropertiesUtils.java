
package com.silverwiresapp.admin.utils.propertiesutils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

public class QuickBooksPropertiesUtils {

	public static final Logger LOG = Logger.getLogger(QuickBooksPropertiesUtils.class);

	public static Properties propConfig = null;
	public static String PROP_FILE = "qbapi.properties";

	public static String REQUEST_TOKEN_URL;
	public static String ACCESS_TOKEN_URL;
	public static String AUTHORIZE_URL;
	public static String DISCONNECT_URL;
	public static String API_KEY;
	public static String OAUTH_CONSUMER_KEY;
	public static String OAUTH_CONSUMER_SECRET;
	public static String OAUTH_CALLBACK_URL;
	public static String SCRIBE_OAUTH_CALLBACK_URL;
	public static String QBO_URL;
	public static String QB_POPUP_CLOSE_PAGE;

	static {
		try {

			Properties propConfig = new Properties();
			InputStream input = null;

			input = Thread.currentThread().getContextClassLoader().getResourceAsStream(PROP_FILE);

			// load properties file
			propConfig.load(input);
			API_KEY = propConfig.getProperty("quickbooks_api_key");
			OAUTH_CONSUMER_KEY = propConfig.getProperty("oauth_consumer_key");
			OAUTH_CONSUMER_SECRET = propConfig.getProperty("oauth_consumer_secret");

			OAUTH_CALLBACK_URL = propConfig.getProperty("oauth_callback_url");
			SCRIBE_OAUTH_CALLBACK_URL = propConfig.getProperty("scribe_oauth_callback_url");

			QBO_URL = propConfig.getProperty("qbo_url");

			REQUEST_TOKEN_URL = propConfig.getProperty("request_token_url");
			ACCESS_TOKEN_URL = propConfig.getProperty("access_token_url");
			AUTHORIZE_URL = propConfig.getProperty("authorize_url");
			DISCONNECT_URL = propConfig.getProperty("disconnect_url");

			QB_POPUP_CLOSE_PAGE = propConfig.getProperty("qb_popup_close_page");

		} catch (IOException e) {
			LOG.error("Properties File can not be loaded!!! " + e.getLocalizedMessage());
		}

	}

}
