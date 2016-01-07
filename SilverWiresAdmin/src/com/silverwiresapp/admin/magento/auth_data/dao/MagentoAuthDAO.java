package com.silverwiresapp.admin.magento.auth_data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.silverwiresapp.admin.dao.DBHelper;

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

	public static MagentoAuthData getMagentoAuthDataBySwUserId(String swUserId) throws SQLException {
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

	public static MagentoAuthData getMagentoAuthDataBySwUserIdWithoutPass(String swUserId) throws SQLException {
		MagentoAuthData data = getMagentoAuthDataBySwUserId(swUserId);
		if (data != null)
			data.setMagentoPass("");

		return data;
	}

}
