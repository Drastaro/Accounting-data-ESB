
package com.silverwiresapp.admin.xeroauth.controller;

import com.silverwiresapp.admin.xeroauth.api.XeroClientUnexpectedException;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfContact;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfInvoice;
import com.silverwiresapp.admin.xeroauth.api.xsd.Report;
import com.silverwiresapp.admin.xeroauth.api.xsd.ResponseType;

import net.oauth.OAuth;
import net.oauth.OAuthAccessor;
import net.oauth.OAuthConsumer;
import net.oauth.OAuthMessage;
import net.oauth.OAuthProblemException;
import net.oauth.client.OAuthClient;
import net.oauth.client.httpclient3.HttpClient3;
import net.oauth.signature.RSA_SHA1;

public class XeroClient {

	private String endpointUrl;
	private String consumerKey;
	private String consumerSecret;
	private String privateKey;

	public XeroClient(String endpointUrl, String consumerKey, String consumerSecret, String privateKey) {
		this.endpointUrl = endpointUrl;
		this.consumerKey = consumerKey;
		this.consumerSecret = consumerSecret;
		this.privateKey = privateKey;
	}

	public OAuthAccessor buildAccessor() {

		OAuthConsumer consumer = new OAuthConsumer(null, consumerKey, null, null);
		consumer.setProperty(RSA_SHA1.PRIVATE_KEY, privateKey);
		consumer.setProperty(OAuth.OAUTH_SIGNATURE_METHOD, OAuth.RSA_SHA1);

		OAuthAccessor accessor = new OAuthAccessor(consumer);
		accessor.accessToken = consumerKey;
		accessor.tokenSecret = consumerSecret;

		return accessor;
	}

	public ArrayOfInvoice getInvoices() throws XeroClientUnexpectedException {
		ArrayOfInvoice arrayOfInvoices = null;
		try {
			OAuthClient client = new OAuthClient(new HttpClient3());
			OAuthAccessor accessor = buildAccessor();
			OAuthMessage response = client.invoke(accessor, OAuthMessage.GET, endpointUrl + "Invoices", null);
			arrayOfInvoices = XeroXmlManager.xmlToInvoices(response.getBodyAsStream());
		} catch (OAuthProblemException ex) {
			throw new XeroClientUnexpectedException("", ex);
		} catch (Exception ex) {
			throw new XeroClientUnexpectedException("", ex);
		}
		return arrayOfInvoices;
	}

	public Report getReport(String reportUrl) throws XeroClientUnexpectedException {
		Report report = null;
		try {
			OAuthClient client = new OAuthClient(new HttpClient3());
			OAuthAccessor accessor = buildAccessor();
			OAuthMessage response = client.invoke(accessor, OAuthMessage.GET, endpointUrl + "Reports" + reportUrl,
					null);
			ResponseType responseType = XeroXmlManager.xmlToResponse(response.getBodyAsStream());
			if (responseType != null && responseType.getReports() != null
					&& responseType.getReports().getReport() != null
					&& responseType.getReports().getReport().size() > 0) {
				report = responseType.getReports().getReport().get(0);
			}
		} catch (OAuthProblemException ex) {
			throw new XeroClientUnexpectedException("", ex);
		} catch (Exception ex) {
			throw new XeroClientUnexpectedException("", ex);
		}
		return report;
	}

	public void postContacts(ArrayOfContact arrayOfContact) throws XeroClientUnexpectedException {
		try {
			String contactsString = XeroXmlManager.contactsToXml(arrayOfContact);
			OAuthClient client = new OAuthClient(new HttpClient3());
			OAuthAccessor accessor = buildAccessor();
			OAuthMessage response = client.invoke(accessor, OAuthMessage.POST, endpointUrl + "Contacts",
					OAuth.newList("xml", contactsString));
		} catch (OAuthProblemException ex) {
			throw new XeroClientUnexpectedException("", ex);
		} catch (Exception ex) {
			throw new XeroClientUnexpectedException("", ex);
		}
	}

	public void postInvoices(ArrayOfInvoice arrayOfInvoices) throws XeroClientUnexpectedException {
		try {
			OAuthClient client = new OAuthClient(new HttpClient3());
			OAuthAccessor accessor = buildAccessor();
			String contactsString = XeroXmlManager.invoicesToXml(arrayOfInvoices);
			OAuthMessage response = client.invoke(accessor, OAuthMessage.POST, endpointUrl + "Invoices",
					OAuth.newList("xml", contactsString));
		} catch (OAuthProblemException ex) {
			throw new XeroClientUnexpectedException("", ex);
		} catch (Exception ex) {
			throw new XeroClientUnexpectedException("", ex);
		}
	}

	public void setConsumerKey(String consumerKey) {
		this.consumerKey = consumerKey;
	}

	public void setConsumerSecret(String consumerSecret) {
		this.consumerSecret = consumerSecret;
	}

	public void setEndpointUrl(String endpointUrl) {
		this.endpointUrl = endpointUrl;
	}

	public void setPrivateKey(String privateKey) {
		this.privateKey = privateKey;
	}
}
