package com.aurionpro.model;

public class Account {
	private int accountId;
	private int customerId;
	private String accountNumber;
	private String accountType;
	private double balance;
	private int branchId;
	private String branchName;
	private String ifscCode;
	
	public Account(int accountId, int customerId, String accountNumber, String accountType, double balance, int branchId,
			String branchName, String ifscCode) {
		super();
		this.accountId = accountId;
		this.customerId = customerId;
		this.accountNumber = accountNumber;
		this.accountType = accountType;
		this.balance = balance;
		this.branchId = branchId;
		this.branchName = branchName;
		this.ifscCode = ifscCode;
	}
	
	public Account(int accountId, int customerId, String accountNumber, String accountType, double balance, int branchId) {
		super();
		this.accountId = accountId;
		this.customerId = customerId;
		this.accountNumber = accountNumber;
		this.accountType = accountType;
		this.balance = balance;
		this.branchId = branchId;
	}
	
	public Account(int accountId, int customerId, String accountNumber, String accountType, double balance,
			String branchName, String ifscCode) {
		super();
		this.accountId = accountId;
		this.customerId = customerId;
		this.accountNumber = accountNumber;
		this.accountType = accountType;
		this.balance = balance;
		this.branchName = branchName;
		this.ifscCode = ifscCode;
	}

	public Account(int accountId, String accountNumber, String accountType, double balance, String branchName, String ifscCode) {
		super();
		this.accountId = accountId;
		this.accountNumber = accountNumber;
		this.accountType = accountType;
		this.balance = balance;
		this.branchName = branchName;
		this.ifscCode = ifscCode;
	}

	public int getCustomerId() {
		return customerId;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public int getAccountId() {
		return accountId;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public String getAccountType() {
		return accountType;
	}
	public int getBranchId() {
		return branchId;
	}
	public String getBranchName() {
		return branchName;
	}
	public String getIfscCode() {
		return ifscCode;
	}

	@Override
	public String toString() {
		return "Account [accountId=" + accountId + ", customerId=" + customerId + ", accountNumber=" + accountNumber
				+ ", accountType=" + accountType + ", balance=" + balance + ", branchId=" + branchId + ", branchName="
				+ branchName + ", ifscCode=" + ifscCode + "]";
	}
	
	
}
