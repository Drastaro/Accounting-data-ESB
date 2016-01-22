package com.silverwiresapp.admin.quickbooks.utils;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import com.silverwiresapp.admin.quickbooks.data.QuickBooksTokens;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;

public class QuickBooksHibernateUtil {

	public static QuickBooksTokens getTokensBySwUserId(String swUserId) {
		// get hibernate session

		Session session = HibernatePersistanceUtil.getSessionFactory().openSession();
		Transaction tx = null;
		tx = session.beginTransaction();

		// get xero token using criteria

		Criteria criteria = session.createCriteria(QuickBooksTokens.class);
		criteria.add(Restrictions.eq("swUserId", swUserId));
		List results = criteria.list();
		if (results.size() == 1) {
			QuickBooksTokens quickTokens = (QuickBooksTokens) results.get(0);

			// return tokens
			return quickTokens;
		} else {
			return null;
		}

	}
}
