package com.aurionpro.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import com.aurionpro.util.DbConnection;

public class CustomerDashboardDetailsDao {
	private static CustomerDashboardDetailsDao customerDashboardDetailsDao;
	
	private CustomerDashboardDetailsDao() {}
	
	public static CustomerDashboardDetailsDao getCustomerDahsboardDetailsDaoInstance() {
		if(customerDashboardDetailsDao == null) {
			customerDashboardDetailsDao = new CustomerDashboardDetailsDao();
		}
		return customerDashboardDetailsDao;
	}
	
	@SuppressWarnings("serial")
	public Map<String, Object> getCustomerDashBoardDetails(int customerId) {
		Connection connection = DbConnection.connect();
		Map<String, Object> customerDashboardDetails = new HashMap<>() {{	put("numberOfAccounts", null);
																			put("totalBalance", null);
																			put("numberOfTransactions", null);
																		}};
		try {
			CallableStatement statement = connection.prepareCall("{CALL get_customer_dashboard_details(?, ?, ?, ?)}");
			
			statement.setInt(1, customerId);
			
			statement.registerOutParameter(2, Types.INTEGER);
			statement.registerOutParameter(3, Types.DOUBLE);
			statement.registerOutParameter(4, Types.INTEGER);
			
			statement.execute();
			
			int numberOfAccounts = statement.getInt(2);
			double totalBalance = statement.getDouble(3);
			int numberOfTransactions = statement.getInt(4);
			
			customerDashboardDetails.put("numberOfAccounts", numberOfAccounts);
			customerDashboardDetails.put("totalBalance", totalBalance);
			customerDashboardDetails.put("numberOfTransactions", numberOfTransactions);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return customerDashboardDetails;
	}
}
