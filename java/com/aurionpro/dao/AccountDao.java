package com.aurionpro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.model.Account;
import com.aurionpro.util.DbConnection;

public class AccountDao {
	private static AccountDao accountDao;
	
	private AccountDao() {}
	
	public static AccountDao getAccountDaoInstance() {
		if(accountDao == null) {
			accountDao = new AccountDao();
		}
		return accountDao;
	}
	
	public List<Account> getSingleCustomerAccounts(int customerId) {
		Connection connection = DbConnection.connect();
		List<Account> accounts = new ArrayList<>();
		try {
			PreparedStatement statement = connection.prepareStatement("SELECT account_id, account_number, account_type, "
																	+ "balance, branch_name, ifsc_code "
																	+ "FROM customer_account_details "
																	+ "WHERE account_number IS NOT NULL "
																	+ "AND customer_id = ?");
			statement.setInt(1, customerId);
			
			statement.execute();
			
			System.out.println(customerId);
			
			ResultSet resultSet = statement.getResultSet();
			while(resultSet.next()) {
				accounts.add(new Account(
					resultSet.getInt("account_id"),
					resultSet.getString("account_number"),
					resultSet.getString("account_type"),
					resultSet.getDouble("balance"),
					resultSet.getString("branch_name"),
					resultSet.getString("ifsc_code")
				));
				System.out.println(accounts);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return accounts;
	}
}
