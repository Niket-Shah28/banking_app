package com.aurionpro.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
	private static Connection connection;
	
	private DbConnection() {
		
	}
	
	public static Connection connect() {
		if(connection == null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking_app", "", "");
				System.out.println("Connection Successful !!");
			} catch (ClassNotFoundException e) {
				System.out.println("2");
				e.printStackTrace();
			} catch (SQLException e) {
				System.out.println("3");
				e.printStackTrace();
			}
		}
		return connection;
	}
}
