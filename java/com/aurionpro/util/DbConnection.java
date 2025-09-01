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
				
				connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking_app", "root", "Tekin@3002");
				System.out.println("Connection Successful !!");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return connection;
	}
}
