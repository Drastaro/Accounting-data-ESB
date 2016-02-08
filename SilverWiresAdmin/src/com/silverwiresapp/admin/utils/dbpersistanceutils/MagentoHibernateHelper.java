package com.silverwiresapp.admin.utils.dbpersistanceutils;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import com.silverwiresapp.admin.magento.pojo.MagentoTokens;

public class MagentoHibernateHelper {

	public static MagentoTokens getTokensBySwUserId(String swUserId) {
		// get hibernate session

		Session session = HibernatePersistanceUtil.getSessionFactory().openSession();
		Transaction tx = null;
		tx = session.beginTransaction();

		// get xero token using criteria

		Criteria criteria = session.createCriteria(MagentoTokens.class);
		criteria.add(Restrictions.eq("swUserId", swUserId));
		List results = criteria.list();
		if (results.size() == 1) {
			MagentoTokens mgTokens = (MagentoTokens) results.get(0);

			// return tokens
			return mgTokens;
		} else {
			return null;
		}

	}

}
