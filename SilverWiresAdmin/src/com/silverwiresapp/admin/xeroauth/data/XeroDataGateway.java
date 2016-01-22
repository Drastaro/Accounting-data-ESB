package com.silverwiresapp.admin.xeroauth.data;

import java.io.IOException;
import java.util.List;
import com.google.api.client.http.ByteArrayContent;
import com.google.api.client.http.HttpContent;
import com.google.api.client.http.HttpResponse;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfContact;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfInvoice;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfOrganisation;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfTaxRate;
import com.silverwiresapp.admin.xeroauth.api.xsd.Contact;
import com.silverwiresapp.admin.xeroauth.api.xsd.Invoice;
import com.silverwiresapp.admin.xeroauth.api.xsd.Organisation;
import com.silverwiresapp.admin.xeroauth.api.xsd.TaxRate;
import com.silverwiresapp.admin.xeroauth.controller.OAuthGetResource;
import com.silverwiresapp.admin.xeroauth.controller.XeroXmlManager;
import com.silverwiresapp.admin.xeroauth.pojo.XeroTokens;

public class XeroDataGateway {

	public static List<Invoice> getInvoices(String swUserId) throws IOException {

		// get xeroauth data from hibernate
		XeroTokens tokens = XeroHibernateHelper.getTokensBySwUserId(swUserId);

		// call xero with auth data
		HttpResponse response = XeroDataFactory.getOauthResource("Invoice", tokens).execute();

		ArrayOfInvoice arrayOfInvoices = XeroXmlManager.xmlToInvoices(response.getContent());
		if (arrayOfInvoices != null && arrayOfInvoices.getInvoice() != null) {

			return arrayOfInvoices.getInvoice();
		} else {
			return null;
		}
	}

	public static List<Organisation> getOraganisations(String swUserId) throws IOException {

		// get xeroauth data from hibernate
		XeroTokens tokens = XeroHibernateHelper.getTokensBySwUserId(swUserId);

		// call xero with auth data
		HttpResponse response = XeroDataFactory.getOauthResource("Organisation", tokens).execute();

		ArrayOfOrganisation array = XeroXmlManager.organisationsToXml(response.getContent());
		if (array != null && array.getOrganisation() != null) {

			return array.getOrganisation();
		} else {
			return null;
		}
	}

	public static List<Contact> getContacts(String swUserId) throws IOException {

		// get xeroauth data from hibernate
		XeroTokens tokens = XeroHibernateHelper.getTokensBySwUserId(swUserId);

		// call xero with auth data
		HttpResponse response = XeroDataFactory.getOauthResource("Contact", tokens).execute();

		ArrayOfContact array = XeroXmlManager.contactsToXml(response.getContent());
		if (array != null && array.getContact() != null) {
			return array.getContact();
		} else {
			return null;
		}

	}

	public static List<TaxRate> getTaxRates(String swUserId) throws IOException {

		// get xeroauth data from hibernate
		XeroTokens tokens = XeroHibernateHelper.getTokensBySwUserId(swUserId);

		// call xero with auth data
		HttpResponse response = XeroDataFactory.getOauthResource("TaxRate", tokens).execute();

		ArrayOfTaxRate array = XeroXmlManager.taxratesToXml(response.getContent());
		if (array != null && array.getTaxRate() != null) {
			return array.getTaxRate();
		} else {
			return null;
		}

	}

	public static void postInvoice(Invoice invoice, String swUserId) throws IOException {

		// get xeroauth data from hibernate
		XeroTokens tokens = XeroHibernateHelper.getTokensBySwUserId(swUserId);

		String arrayString = XeroXmlManager.invoiceToXml(invoice);

		// call xero with auth data
		OAuthGetResource caller = XeroDataFactory.getOauthResource("Invoice", tokens);

		System.out.println("XXX" + arrayString);

		caller.set("xml", arrayString);

		HttpContent content = new ByteArrayContent("application/xml", arrayString.getBytes());

		HttpResponse response = caller.executePost(content);

		System.out.println(response.getContent());

	}

	public static void createContact(Contact contact, String swUserId) throws IOException {

		// get xeroauth data from hibernate
		XeroTokens tokens = XeroHibernateHelper.getTokensBySwUserId(swUserId);

		String arrayString = XeroXmlManager.contactToXml(contact);

		// call xero with auth data
		OAuthGetResource caller = XeroDataFactory.getOauthResource("Contact", tokens);

		System.out.println("");
		System.out.println("Contact created:" + contact.getName());

		caller.set("xml", arrayString);

		HttpContent content = new ByteArrayContent("application/xml", arrayString.getBytes());

		HttpResponse response = caller.executePost(content);

		System.out.println(response.getContent());

	}

}
