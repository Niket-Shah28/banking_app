package com.aurionpro.service;

import java.util.List;

import com.aurionpro.dao.BranchDao;
import com.aurionpro.model.Branch;

public class BranchService {
	private static BranchService branchService;
	private static BranchDao branchDao = BranchDao.getBranchDaoInstance(); 
	
	private BranchService() {}
	
	public static BranchService getBranchServiceInstance() {
		if(branchService == null) {
			branchService = new BranchService();
		}
		return branchService;
	}
	
	public List<Branch> getBranchDetails() {
		return branchDao.getBranchDeatils();
	}
}
