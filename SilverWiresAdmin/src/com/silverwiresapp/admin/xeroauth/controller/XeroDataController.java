package com.silverwiresapp.admin.xeroauth.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfContact;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfInvoice;
import com.silverwiresapp.admin.xeroauth.api.xsd.ArrayOfLineItem;
import com.silverwiresapp.admin.xeroauth.api.xsd.Contact;
import com.silverwiresapp.admin.xeroauth.api.xsd.Invoice;
import com.silverwiresapp.admin.xeroauth.api.xsd.InvoiceStatus;
import com.silverwiresapp.admin.xeroauth.api.xsd.InvoiceType;
import com.silverwiresapp.admin.xeroauth.api.xsd.LineItem;
import com.silverwiresapp.admin.xeroauth.api.xsd.Organisation;
import com.silverwiresapp.admin.xeroauth.api.xsd.TaxRate;
import com.silverwiresapp.admin.xeroauth.data.XeroDataGateway;
import com.silverwiresapp.admin.xeroauth.hibernateutil.HibernateUtil;

@Controller
@RequestMapping("/xero/data")
public class XeroDataController {

	Session session = HibernateUtil.getSessionFactory().openSession();
	Transaction tx = null;

	@RequestMapping(value = "/getorganisations", method = RequestMethod.GET)
	public void getOrganisationsList(@RequestParam("sw_user_id") String swUserId, HttpServletRequest req,
			HttpServletResponse resp) {

		try {
			List<Organisation> organisations = XeroDataGateway.getOraganisations(swUserId);
			for (Organisation organisation : organisations) {

				System.out
						.println("Organisations:" + organisation.getName() + " " + organisation.getOrganisationType());
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/postinvoice", method = RequestMethod.GET)
	public void postInvoice(@RequestParam("sw_user_id") String swUserId, HttpServletRequest req,
			HttpServletResponse resp) {

		Invoice invoice = null;

		try {

			ArrayOfInvoice arrayOfInvoice = new ArrayOfInvoice();
			List<Invoice> invoices = arrayOfInvoice.getInvoice();
			invoice = new Invoice();

			Contact contact = new Contact();
			contact.setName("Kovacs Attila2");
			contact.setEmailAddress("1111@yahoo.com");
			invoice.setContact(contact);

			ArrayOfLineItem arrayOfLineItem = new ArrayOfLineItem();
			List<LineItem> lineItems = arrayOfLineItem.getLineItem();
			LineItem lineItem = new LineItem();
			lineItem.setAccountCode("200");
			BigDecimal qty = new BigDecimal("2");
			lineItem.setQuantity(qty);
			BigDecimal amnt = new BigDecimal("5000.00");
			lineItem.setUnitAmount(amnt);
			lineItem.setDescription("Programming books");
			lineItem.setLineAmount(qty.multiply(amnt));
			lineItems.add(lineItem);
			invoice.setLineItems(arrayOfLineItem);

			invoice.setDate(Calendar.getInstance());
			Calendar due = Calendar.getInstance();
			due.set(due.get(Calendar.YEAR), due.get(Calendar.MONTH) + 1, 20);
			invoice.getLineAmountTypes().add("Inclusive");
			invoice.setDueDate(due);
			invoice.setInvoiceNumber("INV-API-002");
			invoice.setType(InvoiceType.ACCREC);
			invoice.setStatus(InvoiceStatus.AUTHORISED);

			invoices.add(invoice);

			// xeroClient.postInvoices(arrayOfInvoice);
			XeroDataGateway.postInvoice(invoice, swUserId);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/getinvoices", method = RequestMethod.GET)
	public void getInvoicesList(@RequestParam("sw_user_id") String swUserId, HttpServletRequest req,
			HttpServletResponse resp) {

		try {
			List<Invoice> invoices = XeroDataGateway.getInvoices(swUserId);

			for (Invoice invoice : invoices) {

				System.out.println("Invoice:" + invoice.getInvoiceNumber());

			}

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/gettaxrates", method = RequestMethod.GET)
	public void getTaxRatesList(@RequestParam("sw_user_id") String swUserId, HttpServletRequest req,
			HttpServletResponse resp) {

		try {
			List<TaxRate> taxRates = XeroDataGateway.getTaxRates(swUserId);

			for (TaxRate taxRate : taxRates) {

				System.out.println("TaxRate:" + taxRate.getTaxType());

			}

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/createcontact", method = RequestMethod.GET)
	public void createContact(@RequestParam("sw_user_id") String swUserId, HttpServletRequest req,
			HttpServletResponse resp) throws IOException {

		ArrayOfContact arrayOfContact = new ArrayOfContact();
		List<Contact> contacts = arrayOfContact.getContact();

		Contact contact = new Contact();
		contact.setName("Ioan33");
		contact.setFirstName("Bogdan2");
		contact.setLastName("Bela2");
		contact.setContactID("22222222-2222-2222-22222222222");
		contact.setEmailAddress("ioan33@yahoo.com");
		contacts.add(contact);
		XeroDataGateway.createContact(contact, swUserId);

	}

	@RequestMapping(value = "/getcontacts", method = RequestMethod.GET)
	public void getContactsList(@RequestParam("sw_user_id") String swUserId, HttpServletRequest req,
			HttpServletResponse resp) {

		try {
			List<Contact> contacts = XeroDataGateway.getContacts(swUserId);

			for (Contact contact : contacts) {

				System.out.println("Contact:" + contact.getName() + " " + contact.getContactID());
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/updatecontact", method = RequestMethod.GET)
	public void updateContact(@RequestParam("sw_user_id") String swUserId, @RequestParam("name") String name,
			@RequestParam("firstName") String firstName, HttpServletRequest req, HttpServletResponse resp) {

		try {
			List<Contact> contacts = XeroDataGateway.getContacts(swUserId);

			for (Contact contact : contacts) {

				if (contact.getName().equalsIgnoreCase(name) && contact.getFirstName().equalsIgnoreCase(firstName)) {
					System.out.println("Contact:" + contact.getName());

					// contact.setName("Ioan33");
					contact.setFirstName("Ioanye333");
					XeroDataGateway.createContact(contact, swUserId);

					System.out.println("Contact:" + contact.getName());
				}

			}

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
