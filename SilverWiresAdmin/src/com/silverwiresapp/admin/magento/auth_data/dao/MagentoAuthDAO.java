package com.silverwiresapp.admin.magento.auth_data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.silverwiresapp.admin.magento.pojo.MagentoAuthData;
import com.silverwiresapp.admin.utils.dbpersistanceutils.HibernatePersistanceUtil;
import com.silverwiresapp.admin.utils.dbpersistanceutils.JdbcPersistanceUtil;

public class MagentoAuthDAO {

	public static void saveData(String swUserId, String url) throws SQLException {

		// test if data is already in
		if (getMagentoAuthDataBySwUserId(swUserId) == null) {
			// no data record for this user
			insertAuthData(swUserId, url);
		} else {
			// data saved before - do update
			updateAuthData(swUserId, url);
		}
	}

	public static void insertAuthDataJDBC(String swUserId, String username, String pass, String url)
			throws SQLException {
		Connection con = JdbcPersistanceUtil.createConnection();
		String insertString = "INSERT INTO magento_data (sw_user_id, username, pass, url) values(?,?,?,?)";
		PreparedStatement stmt = con.prepareStatement(insertString);

		stmt.setString(1, swUserId);
		stmt.setString(2, username);
		stmt.setString(3, pass);
		stmt.setString(4, url);

		stmt.executeUpdate();

		JdbcPersistanceUtil.closeConnection(con);

	}

	public static void insertAuthData(String swUserId, String url) throws SQLException {

		Session session = HibernatePersistanceUtil.getSessionFactory().openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();

			MagentoAuthData magentoData = new MagentoAuthData(swUserId, url);
			session.save(magentoData);
			tx.commit();

		} catch (HibernateException e) {

			e.printStackTrace();

		} finally {
			session.close();
		}

	}

	public static void updateAuthDataJDBC(String swUserId, String username, String pass, String url)
			throws SQLException {
		Connection con = JdbcPersistanceUtil.createConnection();
		String insertString = "update magento_data SET  username=?, pass=?, url=? where sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(insertString);

		stmt.setString(1, username);
		stmt.setString(2, pass);
		stmt.setString(3, url);
		stmt.setString(4, swUserId);

		stmt.executeUpdate();

		JdbcPersistanceUtil.closeConnection(con);

	}

	public static void updateAuthData(String swUserId, String url) throws SQLException {

		Session session = HibernatePersistanceUtil.getSessionFactory().openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();

			MagentoAuthData magentoData = new MagentoAuthData(swUserId, url);
			session.update(magentoData);
			tx.commit();

		} catch (HibernateException e) {

			e.printStackTrace();

		} finally {
			session.close();
		}

	}

	public static MagentoAuthData getMagentoAuthDataBySwUserIdJDBC(String swUserId) throws SQLException {
		MagentoAuthData result = null;

		Connection con = JdbcPersistanceUtil.createConnection();
		String query = "SELECT * FROM magento_data WHERE sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(query);

		stmt.setString(1, swUserId);

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			int id = rs.getInt("id");
			String swUserIdentifier = rs.getString("sw_user_id");
			String magentoURL = rs.getString("url");
			result = new MagentoAuthData(id, swUserIdentifier, magentoURL);

		}
		JdbcPersistanceUtil.closeConnection(con);
		return result;
	}

	public static MagentoAuthData getMagentoAuthDataBySwUserId(String swUserId) throws SQLException {

		Session session = HibernatePersistanceUtil.getSessionFactory().openSession();
		Transaction tx = null;

		try {

			tx = session.beginTransaction();

			Criteria cr = session.createCriteria(MagentoAuthData.class);
			cr.add(Restrictions.eq("swUserId", swUserId));
			List<MagentoAuthData> result = cr.list();
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
