package com.silverwiresapp.admin.xeroauth.controller;

import java.io.InputStream;
import java.io.StringWriter;
import java.util.Map;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.transform.stream.StreamSource;

import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfContact;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfInvoice;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfOrganisation;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfTaxRate;
import com.silverwiresapp.admin.xeroauth.api.xsd.Contact;
import com.silverwiresapp.admin.xeroauth.api.xsd.Invoice;
import com.silverwiresapp.admin.xeroauth.api.xsd.ObjectFactory;
import com.silverwiresapp.admin.xeroauth.api.xsd.ResponseType;

import net.oauth.OAuthProblemException;

public class XeroXmlManager {

	public static ArrayOfInvoice xmlToInvoices(InputStream invoiceStream) {

		ArrayOfInvoice arrayOfInvoices = null;

		try {
			JAXBContext context = JAXBContext.newInstance(ResponseType.class);
			Unmarshaller unmarshaller = context.createUnmarshaller();
			JAXBElement<ResponseType> element = unmarshaller.unmarshal(new StreamSource(invoiceStream),
					ResponseType.class);
			ResponseType response = element.getValue();
			arrayOfInvoices = response.getInvoices();

		} catch (JAXBException ex) {
			ex.printStackTrace();
		}

		return arrayOfInvoices;
	}

	public static ResponseType xmlToResponse(InputStream responseStream) {

		ResponseType response = null;

		try {
			JAXBContext context = JAXBContext.newInstance(ResponseType.class);
			Unmarshaller unmarshaller = context.createUnmarshaller();
			JAXBElement<ResponseType> element = unmarshaller.unmarshal(new StreamSource(responseStream),
					ResponseType.class);
			response = element.getValue();

		} catch (JAXBException ex) {
			ex.printStackTrace();
		}

		return response;
	}

	public static String oAuthProblemExceptionToXml(OAuthProblemException authProblemException) {

		String oAuthProblemExceptionString = null;

		Map<String, Object> params = authProblemException.getParameters();
		for (String key : params.keySet()) {
			Object o = params.get(key);
			if (key.contains("ApiException")) {
				oAuthProblemExceptionString = key + "=" + o.toString();
			}
		}

		return oAuthProblemExceptionString;
	}

	public static String contactsToXml(ArrayOfContact arrayOfContacts) {

		String contactsString = null;

		try {

			JAXBContext context = JAXBContext.newInstance(ResponseType.class);
			Marshaller marshaller = context.createMarshaller();
			marshaller.setProperty("com.sun.xml.bind.xmlDeclaration", Boolean.FALSE);

			ObjectFactory factory = new ObjectFactory();
			JAXBElement<ArrayOfContact> element = factory.createContacts(arrayOfContacts);

			StringWriter stringWriter = new StringWriter();
			marshaller.marshal(element, stringWriter);
			contactsString = stringWriter.toString();

		} catch (JAXBException ex) {
			ex.printStackTrace();
		}

		return contactsString;
	}

	public static String invoicesToXml(ArrayOfInvoice arrayOfInvoices) {

		String invoicesString = null;

		try {

			JAXBContext context = JAXBContext.newInstance(ResponseType.class);
			Marshaller marshaller = context.createMarshaller();
			marshaller.setProperty("com.sun.xml.bind.xmlDeclaration", Boolean.FALSE);

			ObjectFactory factory = new ObjectFactory();
			JAXBElement<ArrayOfInvoice> element = factory.createInvoices(arrayOfInvoices);

			StringWriter stringWriter = new StringWriter();
			marshaller.marshal(element, stringWriter);
			invoicesString = stringWriter.toString();

		} catch (JAXBException ex) {
			ex.printStackTrace();
		}

		return invoicesString;
	}

	public static String invoiceToXml(Invoice invoice) {

		String invoicesString = null;

		try {

			JAXBContext context = JAXBContext.newInstance(ResponseType.class);
			Marshaller marshaller = context.createMarshaller();
			marshaller.setProperty("com.sun.xml.bind.xmlDeclaration", Boolean.FALSE);

			ObjectFactory factory = new ObjectFactory();
			JAXBElement<Invoice> element = factory.createInvoice(invoice);

			StringWriter stringWriter = new StringWriter();
			marshaller.marshal(element, stringWriter);
			invoicesString = stringWriter.toString();

		} catch (JAXBException ex) {
			ex.printStackTrace();
		}

		return invoicesString;
	}

	public static String contactToXml(Contact contact) {

		String contactsString = null;

		try {

			JAXBContext context = JAXBContext.newInstance(ResponseType.class);
			Marshaller marshaller = context.createMarshaller();
			marshaller.setProperty("com.sun.xml.bind.xmlDeclaration", Boolean.FALSE);

			ObjectFactory factory = new ObjectFactory();
			JAXBElement<Contact> element = factory.createContact(contact);

			StringWriter stringWriter = new StringWriter();
			marshaller.marshal(element, stringWriter);
			contactsString = stringWriter.toString();

		} catch (JAXBException ex) {
			ex.printStackTrace();
		}

		return contactsString;
	}

	public static ArrayOfOrganisation organisationsToXml(InputStream orgStream) {
		// TODO Auto-generated method stub
		ArrayOfOrganisation arrayOrOrganisation = null;

		try {
			JAXBContext context = JAXBContext.newInstance(ResponseType.class);
			Unmarshaller unmarshaller = context.createUnmarshaller();
			JAXBElement<ResponseType> element = unmarshaller.unmarshal(new StreamSource(orgStream), ResponseType.class);
			ResponseType response = element.getValue();
			arrayOrOrganisation = response.getOrganisations();

		} catch (JAXBException ex) {
			ex.printStackTrace();
		}

		return arrayOrOrganisation;
	}

	public static ArrayOfContact contactsToXml(InputStream conStream) {
		// TODO Auto-generated method stub

		ArrayOfContact arrayContact = null;
		try {
			JAXBContext context = JAXBContext.newInstance(ResponseType.class);
			Unmarshaller unmarshaller = context.createUnmarshaller();
			JAXBElement<ResponseType> element = unmarshaller.unmarshal(new StreamSource(conStream), ResponseType.class);
			ResponseType response = element.getValue();
			arrayContact = response.getContacts();

		} catch (JAXBException ex) {
			ex.printStackTrace();
		}

		return arrayContact;
	}

	public static ArrayOfTaxRate taxratesToXml(InputStream taxStream) {
		// TODO Auto-generated method stub
		ArrayOfTaxRate arrayTaxRate = null;
		try {
			JAXBContext context = JAXBContext.newInstance(ResponseType.class);
			Unmarshaller unmarshaller = context.createUnmarshaller();
			JAXBElement<ResponseType> element = unmarshaller.unmarshal(new StreamSource(taxStream), ResponseType.class);
			ResponseType response = element.getValue();
			arrayTaxRate = response.getTaxRates();

		} catch (JAXBException ex) {
			ex.printStackTrace();
		}

		return arrayTaxRate;
	}
}
