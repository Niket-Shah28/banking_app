package com.aurionpro.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import com.aurionpro.model.Customer;
import com.aurionpro.util.DbConnection;

public class UserDao {
	private static UserDao userDao;
	
	private UserDao() {}
	
	public static UserDao getUSerDaoInstance() {
		if(userDao == null) {
			userDao = new UserDao();
		}
		return userDao;
	}
	
	public boolean login(int userId, String password, String role) {
		Connection connection = DbConnection.connect();
		
		try {
			PreparedStatement statement = null;
			if(role.equals("ADMIN")) {
				statement = connection.prepareStatement("SELECT 1 FROM admin WHERE admin_id = ? AND password = SHA2(?, 256)");
			}
			else {
				statement = connection.prepareStatement("SELECT 1 FROM customer WHERE customer_id = ? AND password = SHA2(?, 256)");
			}
			
			statement.setInt(1, userId);
			statement.setString(2, password);
			
			statement.execute();
			
			ResultSet resultSet = statement.getResultSet();
			
			if(resultSet.next()) {
				if(resultSet.getInt(1) == 1) {
					return true;
				}
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean registerCustomer(Customer customer) {
		Connection connection = DbConnection.connect();
		boolean success = false;
		
		try {
			CallableStatement statement = connection.prepareCall("{CALL add_customer(?, ?, ?, ?, ?, ?, ?, ?, ?)}");
			
			statement.setString(1, customer.getName());
			statement.setString(2, customer.getEmail());
			statement.setString(3, customer.getPhone());
			statement.setString(4, customer.getPanNumber());
			statement.setString(5, customer.getAadharNumber());
			statement.setDate(6, customer.getDateOfBirth());
			statement.setString(7, customer.getAddress());
			statement.setString(8, customer.getPassword());
			
			statement.registerOutParameter(9, Types.BOOLEAN);
			
			statement.executeUpdate();
			
			success = statement.getBoolean(9);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return success;
	}
}
