package com.silverwiresapp.admin.magento.data;

import org.apache.axis2.AxisFault;

import com.google.code.magja.soap.MagentoSoapClient;
import com.google.code.magja.soap.SoapConfig;
import com.google.gson.Gson;
import com.silverwiresapp.admin.magento.auth_data.dao.MagentoAuthData;


public class MagentoGateway {
	
	public static MagentoTaxRate[] getMagentoTaxRates(MagentoAuthData magData) {
		MagentoTaxRate[] result= null;
		
		// get default connection
		// configure connection
		SoapConfig soapConfig = new SoapConfig(magData.getMagentoUsername(), magData.getMagentoPass(), magData.getMagentoAPIURL());
		MagentoSoapClient magentoSoapClient = MagentoSoapClient.getInstance(soapConfig);

		
		try {
			String response=(String)magentoSoapClient.call("quickbookswire_api.swlisttaxes", "");
			Gson gson = new Gson();
			System.out.println(response);
			result=gson.fromJson(response, MagentoTaxRate[].class);
			
		} catch (AxisFault e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	        
		return result;
	}

}
