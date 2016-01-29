package com.silverwiresapp.admin.test;

import java.io.StringReader;

import javax.xml.bind.JAXB;

import com.silverwiresapp.admin.quickbooks.data.PlatformResponse;

public class JaxTest {

	public static void main(String[] args) {
		String source="<?xml version=\"1.0\" encoding=\"utf-8\"?><PlatformResponse xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://platform.intuit.com/api/v1\">  <ErrorMessage>OAuth Token rejected</ErrorMessage>  <ErrorCode>270</ErrorCode>  <ServerTime>2016-01-08T14:24:28.5894172Z</ServerTime></PlatformResponse>";
		
		PlatformResponse platformResp = (PlatformResponse) JAXB.unmarshal(new StringReader(source),
				PlatformResponse.class);

		System.out.println(
				"Platforms resp mesg:== " + platformResp.getErrorMessage() + "  code===" + platformResp.getErrorCode());


	}

}
