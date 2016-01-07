package com.silverwiresapp.admin.users.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

import javax.servlet.ServletException;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.silverwiresapp.admin.dao.DBHelper;
import com.silverwiresapp.admin.hibernatehelper.HibernateUtil;
import com.silverwiresapp.admin.users.pojo.UserData;

public class UsersDAO {

	public static void createUserJDBC(String appUserId, String swUserID) throws SQLException {
		Connection con = DBHelper.createConnection();
		String insertString = "INSERT INTO sw_user(app_user_id, sw_user_id) values(?,?)";
		PreparedStatement stmt = con.prepareStatement(insertString);

		stmt.setString(1, appUserId);
		stmt.setString(2, swUserID);

		stmt.executeUpdate();

		DBHelper.closeConnection(con);

	}

	public static String createUser(String userID) throws ServletException, IOException {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;

		// generate UUID
		String uuid = UUID.randomUUID().toString();

		// save in db
		try {
			tx = session.beginTransaction();
			UserData user = new UserData(uuid, userID);
			session.save(user);
			tx.commit();
		} catch (HibernateException ex) {
			throw new ServletException("Server internal error on creating user");
		} finally {

			session.close();

		}

		// return the newly created uuid
		return uuid;

	}

}
