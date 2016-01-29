package com.silverwiresapp.admin.utils.propertiesutils;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import org.apache.log4j.Logger;

public class MagentoPropertiesUtils {

	public static final Logger LOG = Logger.getLogger(MagentoPropertiesUtils.class);

	public static Properties propConfig = null;
	public static String PROP_FILE = "magentoapi.properties";
	
	public static String MAGENTO_REST_URL;
	public static String ACCES_TOKEN_URL;
	public static String REQUEST_TOKEN_URL;
	public static String AUTHORIZE_URL;
	public static String OAUTH_CALLBACK_URL;

	public static String MAGENTO_POPUP_CLOSE_PAGE;

	static {
		try {

			Properties propConfig = new Properties();
			InputStream input = null;

			input = Thread.currentThread().getContextClassLoader().getResourceAsStream(PROP_FILE);
			propConfig.load(input);

			MAGENTO_REST_URL = propConfig.getProperty("magento_rest_url");
			ACCES_TOKEN_URL = propConfig.getProperty("acces_token_endpoint");
			REQUEST_TOKEN_URL = propConfig.getProperty("request_token_endpoint");
			AUTHORIZE_URL = propConfig.getProperty("authorize_url");
			OAUTH_CALLBACK_URL = propConfig.getProperty("oauth_callback_url");

			MAGENTO_POPUP_CLOSE_PAGE = propConfig.getProperty("magento_popup_close_page");

		} catch (IOException e) {
			LOG.error("Properties File can not be loaded!!! " + e.getLocalizedMessage());
		}

	}

	public void load(FileInputStream fileInputStream) {
		// TODO Auto-generated method stub

	}
}
