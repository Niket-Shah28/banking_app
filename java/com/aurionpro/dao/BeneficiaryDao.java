package com.aurionpro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.model.Beneficiary;
import com.aurionpro.util.DbConnection;

public class BeneficiaryDao {
	private static BeneficiaryDao beneficiaryDao;
	
	private BeneficiaryDao() {}
	
	public static BeneficiaryDao getBeneficiaryDaoInstance() {
		if(beneficiaryDao == null) {
			beneficiaryDao = new BeneficiaryDao();
		}
		return beneficiaryDao;
	}
	
	public List<Beneficiary> getCustomerBeneficiaries(int customerId) {
		Connection connection = DbConnection.connect();
		List<Beneficiary> beneficiaries = new ArrayList<>();
		try {
			PreparedStatement statement = connection.prepareStatement("SELECT beneficiary_id, beneficiary_name, "
																	+ "beneficiary_account_number, "
																	+ "beneficiary_bank_name, beneficiary_ifsc "
																	+ "FROM beneficiary "
																	+ "WHERE customer_id = ?");
			statement.setInt(1, customerId);
			
			statement.execute();
			ResultSet resultSet = statement.getResultSet();
			
			while(resultSet.next()) {
				beneficiaries.add(new Beneficiary(
					resultSet.getInt("beneficiary_id"),
					resultSet.getString("beneficiary_account_number"),
					resultSet.getString("beneficiary_name"),
					resultSet.getString("beneficiary_bank_name"),
					resultSet.getString("beneficiary_ifsc")
				));
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return beneficiaries;
	}
	
	public void addBeneficiary(Beneficiary beneficiary) {
		Connection connection = DbConnection.connect();
		try {
			PreparedStatement statement = connection.prepareStatement("INSERT INTO beneficiary(customer_id, "
																	+ "beneficiary_name, beneficiary_account_number, "
																	+ "beneficiary_bank_name, beneficiary_ifsc) "
																	+ "VALUES(?, ?, ?, ?, ?)");
			statement.setInt(1, beneficiary.getCustomerId());
			statement.setString(2, beneficiary.getBeneficiaryName());
			statement.setString(3, beneficiary.getBeneficiaryAccountNumber());
			statement.setString(4, beneficiary.getBeneficiaryBankName());
			statement.setString(5, beneficiary.getBeneficiaryIfsc());
			
			statement.executeUpdate();	
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
