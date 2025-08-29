package com.aurionpro.service;

import java.util.List;

import com.aurionpro.dao.NomineeDao;
import com.aurionpro.model.Nominee;

public class NomineeService {
	private static NomineeService nomineeService;
	private static NomineeDao nomineeDao = NomineeDao.getNomineeDaoInstance();
	
	private NomineeService() {}
	
	public static NomineeService getNomineeServiceInstance() {
		if(nomineeService == null) {
			nomineeService = new NomineeService();
		}
		return nomineeService;
	}
	
	public List<Nominee> getCustomerNominee(int customerId){
		return nomineeDao.getCustomerNominee(customerId);
	}
	
	public void addNominee(Nominee nominee) {
		nomineeDao.addNominee(nominee);
	}
}
