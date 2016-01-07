package com.silverwiresapp.admin.quickbooks.auth_data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.silverwiresapp.admin.dao.DBHelper;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksSettings;
import com.silverwiresapp.admin.quickbooks.data.QuickBooksTokens;

public class QuickBooksDAO {

	public static void saveRequestTokens(String swUserId, String requestToken, String requestSecret)
			throws SQLException {
		if (getTokensBySwUserId(swUserId) == null) {
			// brand new connection is set
			insertRequestTokens(swUserId, requestToken, requestSecret);
		} else {
			// connection update
			updateRequestTokens(swUserId, requestToken, requestSecret);
		}
	}

	public static void insertRequestTokens(String swUserId, String requestToken, String requestSecret)
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

	public static void updateRequestTokens(String swUserId, String requestToken, String requestSecret)
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

	public static void deleteTokensBySwUserId(String swUserId) throws SQLException {
		Connection con = DBHelper.createConnection();
		String deleteString = "delete from quickbooks_tokens WHERE sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(deleteString);

		stmt.setString(1, swUserId);

		stmt.executeUpdate();

		DBHelper.closeConnection(con);
	}

	public static void deleteSettingsBySwUserId(String swUserId) throws SQLException {
		Connection con = DBHelper.createConnection();
		String deleteString = "delete from quickbooks_settings WHERE sw_user_id=?";
		PreparedStatement stmt = con.prepareStatement(deleteString);

		stmt.setString(1, swUserId);

		stmt.executeUpdate();

		DBHelper.closeConnection(con);
	}

	public static void updateAccessTokens(String swUserId, String realmId, String accessToken, String accessSecret)
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

	public static QuickBooksTokens getTokensBySwUserId(String swUserId) throws SQLException {
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

	public static QuickBooksSettings getSettingsByUserId(String swUserId) throws SQLException {
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

	public static void insertSettings(String swUserId, QuickBooksSettings settings) throws SQLException {
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

}
