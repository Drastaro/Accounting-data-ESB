package com.silverwiresapp.admin.quickbooks.auth_data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import com.silverwiresapp.admin.dao.DBHelper;
import com.silverwiresapp.admin.hibernatehelper.HibernateUtil;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksSettings;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksTokens;

public class QuickBooksDAO {

	public static void saveRequestTokens(String swUserId, String requestToken, String requestSecret)
			throws SQLException {

		try {

			if (getTokensBySwUserId(swUserId) == null) {
				// brand new connection is set
				insertRequestTokens(swUserId, requestToken, requestSecret);
			} else {
				// connection update
				updateRequestTokens(swUserId, requestToken, requestSecret);
			}
		} catch (HibernateException e)

		{
			e.printStackTrace();

		} finally

		{

		}

	}

	public static void insertRequestTokensJDBC(String swUserId, String requestToken, String requestSecret)
			throws SQLException {
		Connection con = DBHelper.createConnection();
		String insertString = "INSERT INTO quickbooks_tokens(sw_user_id, requestToken, requestTokenSecret) values(?,?,?)";
		PreparedStatement stmt = con.prepareStatement(insertString);

		stmt.setString(1, swUserId);
		stmt.setString(2, requestToken);
		stmt.setString(3, requestSecret);

		stmt.executeUpdate();

		DBHelper.closeConnection(con);
	}

	public static void insertRequestTokens(String swUserId, String requestToken, String requestSecret) {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;

		try {

			tx = session.beginTransaction();

			QuickBooksTokens qTokens = new QuickBooksTokens();
			qTokens.setSwUserId(swUserId);
			qTokens.setRequestToken(requestToken);
			qTokens.setRequestTokenSecret(requestSecret);

			session.save(qTokens);
			tx.commit();

		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {
			session.close();
		}

	}

	public static void updateRequestTokensJDBC(String swUserId, String requestToken, String requestSecret)
			throws SQLException {
		Connection con = DBHelper.createConnection();
		String updateString = "UPDATE quickbooks_tokens SET requestToken=?, requestTokenSecret=? WHERE sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(updateString);

		stmt.setString(1, requestToken);
		stmt.setString(2, requestSecret);
		stmt.setString(3, swUserId);

		stmt.executeUpdate();

		DBHelper.closeConnection(con);
	}

	public static void updateRequestTokens(String swUserId, String requestToken, String requestSecret) {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;

		try {
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(QuickBooksTokens.class);
			cr.add(Restrictions.eq("swUserId", swUserId));
			List<QuickBooksTokens> result = cr.list();
			for (QuickBooksTokens quickBooksTokens : result) {

				quickBooksTokens.setRequestToken(requestToken);
				quickBooksTokens.setRequestTokenSecret(requestSecret);

				session.update(quickBooksTokens);

			}

			tx.commit();

		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {

			session.close();
		}

	}

	public static void deleteTokensBySwUserIdJDBC(String swUserId) throws SQLException {
		Connection con = DBHelper.createConnection();
		String deleteString = "delete from quickbooks_tokens WHERE sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(deleteString);

		stmt.setString(1, swUserId);

		stmt.executeUpdate();

		DBHelper.closeConnection(con);
	}

	public static void deleteTokensBySwUserId(String swUserId) throws SQLException {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;

		try {

			tx = session.beginTransaction();
			// Criteria cr = session.createCriteria(QuickBooksTokens.class);
			// session.delete(cr.add(Restrictions.eq("swUserId", swUserId)));

			QuickBooksTokens quick = (QuickBooksTokens) session.createCriteria(QuickBooksTokens.class)
					.add(Restrictions.eq("swUserId", swUserId)).uniqueResult();
			session.delete(quick);

			tx.commit();

		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {
			session.close();
		}

	}

	public static void deleteSettingsBySwUserIdJDBC(String swUserId) throws SQLException {
		Connection con = DBHelper.createConnection();
		String deleteString = "delete from quickbooks_settings WHERE sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(deleteString);

		stmt.setString(1, swUserId);

		stmt.executeUpdate();

		DBHelper.closeConnection(con);
	}

	public static void deleteSettingsBySwUserId(String swUserId) throws SQLException {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;

		try {

			tx = session.beginTransaction();

			// Criteria cr = session.createCriteria(QuickBooksSettings.class);
			// session.delete(cr.add(Restrictions.eq("swUserId", swUserId)));
			QuickBooksSettings quickSettings = (QuickBooksSettings) session.createCriteria(QuickBooksSettings.class)
					.add(Restrictions.eq("swUserId", swUserId)).uniqueResult();
			session.delete(quickSettings);

			tx.commit();

		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {
			session.close();
		}

	}

	public static void updateAccessTokensJDBC(String swUserId, String realmId, String accessToken, String accessSecret)
			throws SQLException {
		Connection con = DBHelper.createConnection();
		String updateString = "UPDATE quickbooks_tokens SET realmId=?, accessToken=?, accessTokenSecret=? WHERE sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(updateString);

		stmt.setString(1, realmId);
		stmt.setString(2, accessToken);
		stmt.setString(3, accessSecret);
		stmt.setString(4, swUserId);

		stmt.executeUpdate();

		DBHelper.closeConnection(con);
	}

	public static void updateAccessTokens(String swUserId, String realmId, String accessToken, String accessSecret) {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;

		try {

			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(QuickBooksTokens.class);
			cr.add(Restrictions.eq("swUserId", swUserId));
			List<QuickBooksTokens> token = cr.list();
			for (QuickBooksTokens quickBooksTokens : token) {

				quickBooksTokens.setQboCompanyId(realmId);
				quickBooksTokens.setAccessToken(accessToken);
				quickBooksTokens.setAccessTokenSecret(accessSecret);
				quickBooksTokens.setSwUserId(swUserId);

				session.update(quickBooksTokens);
			}

			tx.commit();

		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {
			session.close();
		}

	}

	public static QuickBooksTokens getTokensBySwUserIdJDBC(String swUserId) throws SQLException {
		QuickBooksTokens result = null;

		Connection con = DBHelper.createConnection();
		String query = "SELECT * FROM quickbooks_tokens WHERE sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(query);

		stmt.setString(1, swUserId);

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			String realmId = rs.getString("realmId");
			String accessToken = rs.getString("accessToken");
			String accessTokenSecret = rs.getString("accessTokenSecret");
			result = new QuickBooksTokens(realmId, accessToken, accessTokenSecret);

		}
		DBHelper.closeConnection(con);
		return result;
	}

	public static QuickBooksTokens getTokensBySwUserId(String swUserId) throws SQLException {

		Session session = HibernateUtil.getSessionFactory().openSession();
		session.beginTransaction();
		try {

			Criteria cr = session.createCriteria(QuickBooksTokens.class);
			cr.add(Restrictions.eq("swUserId", swUserId));
			List<QuickBooksTokens> result = cr.list();
			if (result.size() < 1) {
				return null;
			} else {
				return result.get(0);
			}

		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {

			session.close();
		}
		return null;
	}

	public static QuickBooksSettings getSettingsByUserIdJDBC(String swUserId) throws SQLException {
		QuickBooksSettings result = null;

		Connection con = DBHelper.createConnection();
		String query = "SELECT * FROM quickbooks_settings WHERE sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(query);

		stmt.setString(1, swUserId);

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			result = new QuickBooksSettings();
			result.setSelectedIncomeAccountId(rs.getInt("income_account_id"));
			result.setMagQBTaxesMapping(rs.getString("taxes_mapping"));

		}
		DBHelper.closeConnection(con);
		if (result == null) {
			result = new QuickBooksSettings();
		}
		return result;
	}

	public static QuickBooksSettings getSettingsByUserId(String swUserId) throws SQLException {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;

		try {

			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(QuickBooksSettings.class);
			cr.add(Restrictions.eq("swUserId", swUserId));
			List<QuickBooksSettings> rs = cr.list();

			if (rs.size() != 0) {

				return rs.get(0);

			} else {

				return null;
			}

		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {
			tx.commit();

		}
		return null;
	}

	public static void insertSettingsJDBC(String swUserId, QuickBooksSettings settings) throws SQLException {
		Connection con = DBHelper.createConnection();
		String deleteString = "DELETE from quickbooks_settings where sw_user_id=? ";
		PreparedStatement stmtDel = con.prepareStatement(deleteString);
		stmtDel.setString(1, swUserId);
		stmtDel.executeUpdate();

		String insertString = "INSERT INTO quickbooks_settings(sw_user_id, income_account_id, taxes_mapping) values(?,?, ?)";
		PreparedStatement stmt = con.prepareStatement(insertString);

		stmt.setString(1, swUserId);
		stmt.setInt(2, settings.getSelectedIncomeAccountId());
		stmt.setString(3, settings.getMagQBTaxesMapping());

		stmt.executeUpdate();

		DBHelper.closeConnection(con);
	}

	public static void insertSettings(String swUserId, QuickBooksSettings settings) throws SQLException {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;

		try {

			tx = session.beginTransaction();

			// Criteria cr = session.createCriteria(QuickBooksSettings.class);
			// session.delete(cr.add(Restrictions.eq("swUserId", swUserId)));
			Criteria cr = session.createCriteria(QuickBooksSettings.class);
			QuickBooksSettings quickSettings = (QuickBooksSettings) cr.add(Restrictions.eq("swUserId", swUserId))
					.uniqueResult();
			List<QuickBooksSettings> result = cr.list();
			if (result.size() < 1) {
				QuickBooksSettings qSettings = new QuickBooksSettings(swUserId, settings.getSelectedIncomeAccountId(),
						settings.getMagQBTaxesMapping());

				session.save(qSettings);
			} else {
				session.delete(quickSettings);
				tx.commit();
				tx = session.beginTransaction();
				QuickBooksSettings qSettings = new QuickBooksSettings(swUserId, settings.getSelectedIncomeAccountId(),
						settings.getMagQBTaxesMapping());

				session.save(qSettings);

			}

			tx.commit();

		} catch (HibernateException e) {
			e.printStackTrace();

		} finally {
			session.close();
		}

	}

}
