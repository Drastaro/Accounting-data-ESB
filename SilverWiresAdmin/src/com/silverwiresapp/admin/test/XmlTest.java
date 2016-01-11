package com.silverwiresapp.admin.test;

import java.io.StringReader;
import javax.xml.bind.JAXB;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import com.silverwiresapp.admin.quickbooks.data.PlatformResponse;

public class XmlTest {

	public static void main(String[] args) {

		String source = "<?xml version=\"1.0\" encoding=\"utf-8\"?><PlatformResponse xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://platform.intuit.com/api/v1\">  <ErrorMessage>OAuth Token rejected</ErrorMessage>  <ErrorCode>270</ErrorCode>  <ServerTime>2016-01-08T13:45:31.6718434Z</ServerTime></PlatformResponse>";

		try {

			// parse xml reponse to get response error code
			JAXBContext jaxbContext = JAXBContext.newInstance(PlatformResponse.class);
			Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();

			PlatformResponse platformResp = (PlatformResponse) jaxbUnmarshaller.unmarshal(new StringReader(source));

			System.out.println("Platforms resp mesg:== " + platformResp.getErrorMessage() + "  code==="
					+ platformResp.getErrorCode());

		} catch (JAXBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		PlatformResponse platformResp = (PlatformResponse) JAXB.unmarshal(new StringReader(source),
				PlatformResponse.class);

		System.out.println(
				"Platforms resp mesg:== " + platformResp.getErrorMessage() + "  code===" + platformResp.getErrorCode());

	}
}
