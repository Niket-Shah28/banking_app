package com.aurionpro.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aurionpro.model.Transaction;
import com.aurionpro.util.DbConnection;

public class TransactionDao {
	private static TransactionDao transactionDao;
	
	private TransactionDao() {}
	
	public static TransactionDao getTransactionDaoInstance() {
		if(transactionDao == null) {
			transactionDao = new TransactionDao();
		}
		return transactionDao;
	}
	
	public Map<String, Object> processPayment(Transaction transaction) {
		Connection connection  = DbConnection.connect();
		Map<String, Object> response = new HashMap<>();
		response.put("success", null);
		response.put("message", null);
		try {
			CallableStatement statement = connection.prepareCall("{CALL process_payment(?, ?, ?, ?, ?, ?, ?, ?)}");
			statement.setInt(1, transaction.getAccountId());
			statement.setInt(2, transaction.getBeneficiaryId());
			statement.setString(3, transaction.getTransactionType());
			statement.setDouble(4, transaction.getAmount());
			statement.setString(5, transaction.getMode());
			statement.setString(6, transaction.getDescription());
			
			statement.registerOutParameter(7, Types.BOOLEAN);
			statement.registerOutParameter(8, Types.VARCHAR);
			
			statement.executeUpdate();
			
			boolean success = statement.getBoolean(7);
			String message = statement.getString(8);
			
			response.put("success", success);
			response.put("message", message);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return response;
	}
	
	public List<Transaction> getCustomerTransactions(int customerId) {
		Connection connection = DbConnection.connect();
		List<Transaction> customerTransactions = new ArrayList<>();
		try {
			PreparedStatement statement = connection.prepareStatement("SELECT transaction_type, amount, "
																	+ "mode, description, "
																	+ "reference_id, account_number, "
																	+ "beneficiary_name, timestamp "
																	+ "FROM transaction_account_customer_beneficiary "
																	+ "WHERE customer_id = ?");
			statement.setInt(1, customerId);
			
			statement.execute();
			
			ResultSet resultSet = statement.getResultSet();
			
			while(resultSet.next()) {
				customerTransactions.add(
					new Transaction(
						resultSet.getString("transaction_type"),
						resultSet.getDouble("amount"),
						resultSet.getString("mode"),
						resultSet.getString("description"),
						resultSet.getString("reference_id"),
						resultSet.getString("account_number"),
						resultSet.getString("beneficiary_name"),
						resultSet.getTimestamp("timestamp")
					)
				);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return customerTransactions;
	}
	
	public String processWithdrawAndDeposit(Transaction transaction) {
		Connection connection = DbConnection.connect();
		String message = null;
		try {
			CallableStatement statement = connection.prepareCall("{CALL process_withdraw_and_deposit(?, ?, ?, ?, ?, ?, ?)}");
			statement.setInt(1, transaction.getAccountId());
			statement.setString(2, transaction.getTransactionType());
			statement.setDouble(3, transaction.getAmount());
			statement.setString(4, transaction.getMode());
			statement.setString(5, transaction.getDescription());
			
			statement.registerOutParameter(6, Types.BOOLEAN);
			statement.registerOutParameter(7, Types.VARCHAR);
			
			statement.execute();
			
			message = statement.getString(7);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return message;
	}
	
	public List<Transaction> getAllTransactions(){
		Connection connection = DbConnection.connect();
		List<Transaction> allTransactions = new ArrayList<>();
		try {
			PreparedStatement statement = connection.prepareStatement("SELECT transaction_type, amount, "
																	+ "mode, description, "
																	+ "reference_id, account_number, "
																	+ "beneficiary_name, timestamp "
																	+ "FROM transaction_account_customer_beneficiary ");
			
			statement.execute();
			
			ResultSet resultSet = statement.getResultSet();
			
			while(resultSet.next()) {
				allTransactions.add(
					new Transaction(
						resultSet.getString("transaction_type"),
						resultSet.getDouble("amount"),
						resultSet.getString("mode"),
						resultSet.getString("description"),
						resultSet.getString("reference_id"),
						resultSet.getString("account_number"),
						resultSet.getString("beneficiary_name"),
						resultSet.getTimestamp("timestamp")
					)
				);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return allTransactions;
	}
}
