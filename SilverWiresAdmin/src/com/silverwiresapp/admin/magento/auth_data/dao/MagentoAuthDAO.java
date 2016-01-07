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
import org.hibernate.criterion.Restrictions;

import com.silverwiresapp.admin.dao.DBHelper;
import com.silverwiresapp.admin.hibernatehelper.HibernateUtil;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksTokens;

public class MagentoAuthDAO {

	public static void saveData(String swUserId, String username, String pass, String url) throws SQLException {

		// test if data is already in
		if (getMagentoAuthDataBySwUserId(swUserId) == null) {
			// no data record for this user
			insertAuthData(swUserId, username, pass, url);
		} else {
			// data saved before - do update
			updateAuthData(swUserId, username, pass, url);
		}
	}

	public static void insertAuthData(String swUserId, String username, String pass, String url) throws SQLException {
		Connection con = DBHelper.createConnection();
		String insertString = "INSERT INTO magento_data (sw_user_id, username, pass, url) values(?,?,?,?)";
		PreparedStatement stmt = con.prepareStatement(insertString);

		stmt.setString(1, swUserId);
		stmt.setString(2, username);
		stmt.setString(3, pass);
		stmt.setString(4, url);

		stmt.executeUpdate();

		DBHelper.closeConnection(con);

	}

	public static void updateAuthData(String swUserId, String username, String pass, String url) throws SQLException {
		Connection con = DBHelper.createConnection();
		String insertString = "update magento_data SET  username=?, pass=?, url=? where sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(insertString);

		stmt.setString(1, username);
		stmt.setString(2, pass);
		stmt.setString(3, url);
		stmt.setString(4, swUserId);

		stmt.executeUpdate();

		DBHelper.closeConnection(con);

	}

	public static MagentoAuthData getMagentoAuthDataBySwUserIdJDBC(String swUserId) throws SQLException {
		MagentoAuthData result = null;

		Connection con = DBHelper.createConnection();
		String query = "SELECT * FROM magento_data WHERE sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(query);

		stmt.setString(1, swUserId);

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			int id = rs.getInt("id");
			String swUserIdentifier = rs.getString("sw_user_id");
			String magentoUsername = rs.getString("username");
			String magentoPass = rs.getString("pass");
			String magentoURL = rs.getString("url");
			result = new MagentoAuthData(id, swUserIdentifier, magentoUsername, magentoPass, magentoURL);

		}
		DBHelper.closeConnection(con);
		return result;
	}

	public static MagentoAuthData getMagentoAuthDataBySwUserId(String swUserId) throws SQLException {

		Session session = HibernateUtil.getSessionFactory().openSession();

		Transaction tx = null;

		try {

			tx = session.beginTransaction();

			Criteria cr = session.createCriteria(QuickBooksTokens.class);
			cr.add(Restrictions.eq("sw_user_id", swUserId));
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

	public static MagentoAuthData getMagentoAuthDataBySwUserIdWithoutPass(String swUserId) throws SQLException {
		MagentoAuthData data = getMagentoAuthDataBySwUserId(swUserId);
		if (data != null)

			data.setMagentoPass("");

		return data;
	}

}
