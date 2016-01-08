package com.silverwiresapp.admin.xeroauth.hibernateutil;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

public class HibernateUtil {

	private static SessionFactory sessionFactory;
	private static ServiceRegistry serviceRegistry;
	private static Session session;

	public static SessionFactory getSessionFactory() {

		if (sessionFactory == null) {
			try {
				Configuration config = new Configuration().configure();
				serviceRegistry = new ServiceRegistryBuilder().applySettings(config.getProperties())
						.buildServiceRegistry();
				sessionFactory = config.buildSessionFactory(serviceRegistry);
			} catch (HibernateException ex) {
				ex.printStackTrace();
			}
		}

		return sessionFactory;

	}

	public static Transaction getTransaction() {
		if (session == null || session.isOpen() == false) {
			session = HibernateUtil.getSessionFactory().openSession();
		}
		return session.getTransaction();
	}

	public static void closeSession() {
		if (session != null && session.isOpen() == true) {
			session.close();
		}
	}

	public static Session getSession() {
		if (session == null || session.isOpen() == false) {
			session = sessionFactory.openSession();
		}
		return session;
	}
}
