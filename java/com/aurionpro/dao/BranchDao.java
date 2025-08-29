package com.aurionpro.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.model.Branch;
import com.aurionpro.util.DbConnection;

public class BranchDao {
	private static BranchDao branchDao;
	
	private BranchDao() {}
	
	public static BranchDao getBranchDaoInstance() {
		if(branchDao == null) {
			branchDao = new BranchDao();
		}
		return branchDao;
	}
	
	public List<Branch> getBranchDeatils() {
		Connection connection = DbConnection.connect();
		List<Branch> branches = new ArrayList<>();
		try {
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery("SELECT CONCAT(ifsc_code,' - ',branch_name) AS branch, "
												  + "branch_id "
												  + "FROM branch");
			while(resultSet.next()) {
				branches.add(
					new Branch(
						resultSet.getInt("branch_id"),
						resultSet.getString("branch")
					)
				);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return branches;
	}
}
