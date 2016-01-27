package com.silverwiresapp.admin.utils.dbpersistanceutils;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import com.silverwiresapp.admin.xeroauth.pojo.XeroTokens;

public class TokensHibernateHelperDAO<T> {

	final Class<T> typeParameterClass;

	public TokensHibernateHelperDAO(Class<T> typeParameterClass) {
		this.typeParameterClass = typeParameterClass;
	}

	public T getTokensBySwUserId(String swUserId) {

		Session session = HibernatePersistanceUtil.getSessionFactory().openSession();
		Transaction tx = null;
		tx = session.beginTransaction();

		// get xero token using criteria

		Criteria criteria = session.createCriteria(XeroTokens.class);
		criteria.add(Restrictions.eq("swUserId", swUserId));
		List results = criteria.list();
		if (results.size() == 1) {
			T t = (T) results.get(0);
			return t;
		} else {
			return null;
		}

	}

}
