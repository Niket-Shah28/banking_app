package com.aurionpro.service;

import java.util.List;

import com.aurionpro.dao.BeneficiaryDao;
import com.aurionpro.model.Beneficiary;

public class BeneficiaryService {
	private static BeneficiaryDao beneficiaryDao = BeneficiaryDao.getBeneficiaryDaoInstance();
	private static BeneficiaryService beneficiaryService;
	
	private BeneficiaryService() {}
	
	public static BeneficiaryService getBeneficiaryServiceInstance() {
		if(beneficiaryService == null) {
			beneficiaryService = new BeneficiaryService();
		}
		return beneficiaryService;
	}
	
	public List<Beneficiary> getCustomerBeneficiaries(int customerId){
		return beneficiaryDao.getCustomerBeneficiaries(customerId);
	}
	
	public void addBeneficiary(Beneficiary beneficiary) {
		beneficiaryDao.addBeneficiary(beneficiary);
	}
}
