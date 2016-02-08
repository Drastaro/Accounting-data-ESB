package com.silverwiresapp.admin.magento.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import com.silverwiresapp.admin.magento.pojo.MagentoTokens;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;
import com.silverwiresapp.admin.utils.dbpersistanceutils.JdbcPersistanceUtil;

public class MagentoPersistanceDAO {

	public static void saveData(String swUserId, String url) throws SQLException {

		// test if data is already in
		if (getMagentoDataBySwUserId(swUserId) == null) {
			// no data record for this user
			insertAuthData(swUserId);
		} else {
			// data saved before - do update
			updateAuthData(swUserId);
		}
	}

	public static void insertAuthData(String swUserId) throws SQLException {

		Session session = HibernatePersistanceUtil.getSessionFactory().openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();

			MagentoTokens tokens = new MagentoTokens(swUserId);
			session.save(tokens);
			tx.commit();

		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	public static void updateAuthData(String swUserId) throws SQLException {

		Session session = HibernatePersistanceUtil.getSessionFactory().openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();

			MagentoTokens magentoData = new MagentoTokens(swUserId);
			session.update(magentoData);
			tx.commit();

		} catch (HibernateException e) {

			e.printStackTrace();

		} finally {
			session.close();
		}
	}

	public static MagentoTokens getMagentoDataBySwUserId(String swUserId) throws SQLException {

		Session session = HibernatePersistanceUtil.getSessionFactory().openSession();
		Transaction tx = null;

		try {
			tx = session.beginTransaction();

			Criteria cr = session.createCriteria(MagentoTokens.class);
			cr.add(Restrictions.eq("swUserId", swUserId));
			List<MagentoTokens> result = cr.list();
			if (result.size() < 1) {
				return null;
			} else {
				return result.get(0);
			}

		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {
			tx.commit();
			session.close();
		}
		return null;
	}
}
