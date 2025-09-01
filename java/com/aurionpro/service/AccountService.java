package com.aurionpro.service;

import java.util.List;

import com.aurionpro.dao.AccountDao;
import com.aurionpro.model.Account;

public class AccountService {
	private AccountDao accountDao = AccountDao.getAccountDaoInstance();
	private static AccountService accountService;
	
	private AccountService() {}
	
	public static AccountService getAccountServiceInstance() {
		if(accountService == null) {
			accountService = new AccountService();
		}
		return accountService;
	}
	
	public List<Account> getSingleCustomerAccounts(int customerId){
		return accountDao.getSingleCustomerAccounts(customerId);
	}
	
	public List<String> getCustomerAccountNumbers(int customerId){
		return accountDao.getCustomerAccountNumbers(customerId);
	}
	
	public List<Account> getallAccounts(){
		return accountDao.getallAccounts();
	}
}
