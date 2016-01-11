package com.silverwiresapp.admin.xeroauth.data;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import com.silverwiresapp.admin.xeroauth.hibernateutil.HibernateUtil;
import com.silverwiresapp.admin.xeroauth.pojo.XeroTokens;

public class XeroHibernateHelper {

	public static XeroTokens getTokensBySwUserId(String swUserId) {
		// get hibernate session

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;
		tx = session.beginTransaction();

		// get xero token using criteria

		Criteria criteria = session.createCriteria(XeroTokens.class);
		criteria.add(Restrictions.eq("swUserId", swUserId));
		List results = criteria.list();
		if (results.size() == 1) {
			XeroTokens xeroTokens = (XeroTokens) results.get(0);

			// return tokens
			return xeroTokens;
		} else {
			return null;
		}

	}
}
