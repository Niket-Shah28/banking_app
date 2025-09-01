package com.aurionpro.service;

import java.util.List;
import java.util.Map;

import com.aurionpro.dao.TransactionDao;
import com.aurionpro.model.Transaction;

public class TransactionService {
	private static TransactionDao transactionDao = TransactionDao.getTransactionDaoInstance();
	private static TransactionService transactionService;
	
	private TransactionService() {}
	
	public static TransactionService getTransactionServiceInstance() {
		if(transactionService == null) {
			transactionService = new TransactionService();
		}
		return transactionService;
	}
	
	public Map<String, Object> processPayment(Transaction transaction){
		return transactionDao.processPayment(transaction);
	}
	
	public List<Transaction> getCustomerTransactions(int customerId){
		return transactionDao.getCustomerTransactions(customerId);
	}
	
	public String processWithdrawAndDeposit(Transaction transaction) {
		return transactionDao.processWithdrawAndDeposit(transaction);
	}
	
	public List<Transaction> getAllTransactions(){
		return transactionDao.getAllTransactions();
	}
}
