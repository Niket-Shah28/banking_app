package com.aurionpro.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aurionpro.model.AccountCreationRequest;
import com.aurionpro.model.Customer;
import com.aurionpro.util.DbConnection;

public class AccountRequestDao {
	private static AccountRequestDao accountRequestDao;
	
	private AccountRequestDao() {}
	
	public static AccountRequestDao getAccountRequestDaoInstance() {
		if(accountRequestDao == null) {
			accountRequestDao = new AccountRequestDao();
		}
		return accountRequestDao;
	}
	
	public void addAccountCreationRequest(AccountCreationRequest request) {
		Connection connection = DbConnection.connect();
		try {
			PreparedStatement statement = connection.prepareStatement("INSERT INTO account_creation_request"
					                                                + "(customer_id, account_type, start_balance,"
					                                                + " branch_id) VALUES(?, ?, ?, ?)");
			statement.setInt(1, request.getCustomerId());
			statement.setString(2, request.getAccountType());
			statement.setDouble(3, request.getStartBalance());
			statement.setInt(4, request.getBranchId());
			
			statement.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("serial")
	public Map<Integer, Map<String, Object>> getCustomerAccountRequestDetails() {
		Connection connection = DbConnection.connect();
		Map<Integer, Map<String, Object>> requestAndCustomerDetails = new HashMap<>(); 
		try {
			CallableStatement statement = connection.prepareCall("{CALL get_account_request_customer_details()}");
			
			statement.execute();
			
			ResultSet resultSet = statement.getResultSet();
			while(resultSet.next()) {
				AccountCreationRequest request = new AccountCreationRequest(
													resultSet.getInt("request_id"),
													resultSet.getInt("customer_id"),
													resultSet.getString("account_type"),
													resultSet.getDouble("start_balance"),
													resultSet.getInt("branch_id"),
													resultSet.getString("branch_name"),
													resultSet.getString("ifsc_code")
												 );
				Customer customer = new Customer(
										resultSet.getString("customer_name"),
										resultSet.getString("email"),
										resultSet.getString("phone"),
										resultSet.getString("pan_number"),
										resultSet.getString("aadhar_number"),
										resultSet.getDate("date_of_birth"),
										resultSet.getString("address")
									);
				
				Map<String, Object>requestDetails = new HashMap<>(){{
														put("request_details", request);
														put("customer_details", customer);
													 }};
				
				requestAndCustomerDetails.put(resultSet.getInt("request_id"), requestDetails);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return requestAndCustomerDetails;
	}
	
	public void reviewRequest(int requestId, String status) {
		Connection connection = DbConnection.connect();
		try {
			CallableStatement statement = connection.prepareCall("{CALL review_request(?, ?)}");
			statement.setInt(1, requestId);
			statement.setString(2, status);
			
			statement.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("serial")
	public Map<String, List<AccountCreationRequest>> getCustomerAccountCreationRequests(int customerId) {
		Connection connection = DbConnection.connect();
		Map<String, List<AccountCreationRequest>> requests = new HashMap<>() {{put("PENDING",new ArrayList<AccountCreationRequest>());put("REVIEWED",new ArrayList<AccountCreationRequest>());}};
		try {
			CallableStatement statement = connection.prepareCall("{CALL get_account_creation_requests_of_customer(?)}");
			statement.setInt(1, customerId);
			
			statement.execute();
			
			ResultSet resultSet = statement.getResultSet();
			
			while(resultSet.next()) {
				AccountCreationRequest request = new AccountCreationRequest(
						resultSet.getString("account_type"),
						resultSet.getDouble("start_balance"),
						resultSet.getString("status"),
						resultSet.getTimestamp("created_at"),
						resultSet.getString("branch_name"),
						resultSet.getString("ifsc_code")
					);
				
				if(request.getStatus().equals("PENDING")) {
					requests.get("PENDING").add(request);
				}
				else {
					requests.get("REVIEWED").add(request);
				}
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return requests;
	}
}
