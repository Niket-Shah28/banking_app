package com.aurionpro.service;

import java.util.List;
import java.util.Map;

import com.aurionpro.dao.AccountRequestDao;
import com.aurionpro.model.AccountCreationRequest;

public class AccountRequestService {
	private static AccountRequestService accountRequestService;
	private static AccountRequestDao accountRequestDao = AccountRequestDao.getAccountRequestDaoInstance();

	private AccountRequestService() {}
	
	public static AccountRequestService getAccountRequestServiceInstance() {
		if(accountRequestService == null) {
			accountRequestService = new AccountRequestService();
		}
		return accountRequestService;
	}
	
	public void addAccountCreationRequest(AccountCreationRequest request) {
		accountRequestDao.addAccountCreationRequest(request);
	}
	
	public Map<Integer, Map<String, Object>> getCustomerAccountRequestDetails(){
		return accountRequestDao.getCustomerAccountRequestDetails();
	}
	
	public void reviewRequest(int requestId, String status) {
		accountRequestDao.reviewRequest(requestId, status);
	}
	
	public Map<String, List<AccountCreationRequest>> getCustomerAccountCreationRequests(int customerId) {
		return accountRequestDao.getCustomerAccountCreationRequests(customerId);
	}
}
