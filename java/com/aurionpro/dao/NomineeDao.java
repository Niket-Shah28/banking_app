package com.aurionpro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.model.Nominee;
import com.aurionpro.util.DbConnection;

public class NomineeDao {
	private static NomineeDao nomineeDao;
	
	private NomineeDao() {}
	
	public static NomineeDao getNomineeDaoInstance() {
		if(nomineeDao == null) {
			nomineeDao = new NomineeDao();
		}
		return nomineeDao;
	}
	
	public List<Nominee> getCustomerNominee(int customerId) {
		Connection connection = DbConnection.connect();
		List<Nominee> nominees = new ArrayList<>();
		try {
			PreparedStatement statement = connection.prepareStatement("SELECT name, date_of_birth, address, "
					  												+ "pan_number, relation, linked_account_number "
					  												+ "FROM customer_account_nominee "
					  												+ "WHERE name IS NOT NULL AND customer_id = ?");
			statement.setInt(1, customerId);
			
			statement.execute();
			
			ResultSet resultSet = statement.getResultSet();
			
			while(resultSet.next()) {
				nominees.add(new Nominee(
							resultSet.getString("name"),
							resultSet.getDate("date_of_birth"),
							resultSet.getString("address"),
							resultSet.getString("pan_number"),
							resultSet.getString("relation"),
							resultSet.getString("linked_account_number")
						));
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return nominees;
	}
	
	public void addNominee(Nominee nominee) {
		Connection connection = DbConnection.connect();
		try {
			PreparedStatement statement = connection.prepareStatement("INSERT INTO nominee(account_id, "
																	+ "name, date_of_birth, address, "
																	+ "pan_number, relation) VALUES(?, ?, ?, ?, ?, ?)");
			statement.setInt(1, nominee.getAccountId());
			statement.setString(2, nominee.getName());
			statement.setDate(3, nominee.getDateOfBirth());
			statement.setString(4, nominee.getAddress());
			statement.setString(5, nominee.getPanNumber());
			statement.setString(6, nominee.getRelation());
			
			statement.executeUpdate();
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
