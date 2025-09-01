package com.aurionpro.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import com.aurionpro.util.DbConnection;

public class AdminDashboardDetailDao {
	private static AdminDashboardDetailDao adminDashboardDetailsDao;
	
	private AdminDashboardDetailDao() {}
	
	public static AdminDashboardDetailDao getAdminDahsboardDetailsDaoInstance() {
		if(adminDashboardDetailsDao == null) {
			adminDashboardDetailsDao = new AdminDashboardDetailDao();
		}
		return adminDashboardDetailsDao;
	}
	
	@SuppressWarnings("serial")
	public Map<String, Object> getAdminDashBoardDetails() {
		Connection connection = DbConnection.connect();
		Map<String, Object> adminDashboardDetails = new HashMap<>() {{	put("numberOfAccounts", null);
																			put("numberOfCustomers", null);
																			put("numberOfTransactions", null);
																		}};
		try {
			CallableStatement statement = connection.prepareCall("{CALL get_admin_dashboard_details(?, ?, ?)}");
			
			statement.registerOutParameter(1, Types.INTEGER);
			statement.registerOutParameter(2, Types.INTEGER);
			statement.registerOutParameter(3, Types.INTEGER);
			
			statement.execute();
			
			int numberOfAccounts = statement.getInt(1);
			int numberOfCustomers = statement.getInt(2);
			int numberOfTransactions = statement.getInt(3);
			
			adminDashboardDetails.put("numberOfAccounts", numberOfAccounts);
			adminDashboardDetails.put("numberOfCustomers", numberOfCustomers);
			adminDashboardDetails.put("numberOfTransactions", numberOfTransactions);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return adminDashboardDetails;
	}
}
