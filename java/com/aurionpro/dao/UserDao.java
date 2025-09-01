package com.aurionpro.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

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
	
	public String login(int userId, String password, String role) {
		Connection connection = DbConnection.connect();
		String name = null;
		try {
			PreparedStatement statement = null;
			if(role.equals("ADMIN")) {
				statement = connection.prepareStatement("SELECT name FROM admin WHERE admin_id = ? AND password = SHA2(?, 256)");
			}
			else {
				statement = connection.prepareStatement("SELECT name FROM customer WHERE customer_id = ? AND password = SHA2(?, 256)");
			}
			
			statement.setInt(1, userId);
			statement.setString(2, password);
			
			statement.execute();
			
			ResultSet resultSet = statement.getResultSet();
			
			if(resultSet.next()) {
				name = resultSet.getString("name");
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return name;
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
	
	public List<Customer> getAllCustomerDetails() {
		Connection connection = DbConnection.connect();
		List<Customer> customers = new ArrayList<>();
		try {
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery("SELECT name, email, phone, pan_number, "
													   + "aadhar_number, date_of_birth, address "
													   + "FROM customer");
			
			while(resultSet.next()) {
				customers.add(
					new Customer(
						resultSet.getString("name"),
						resultSet.getString("email"),
						resultSet.getString("phone"),
						resultSet.getString("pan_number"),
						resultSet.getString("aadhar_number"),
						resultSet.getDate("date_of_birth"),
						resultSet.getString("address")
					)
				);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return customers;
	}
}
