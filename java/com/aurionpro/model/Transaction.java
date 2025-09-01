package com.aurionpro.model;

import java.sql.Timestamp;

public class Transaction {
	private int transactionId;
	private int accountId;
	private int beneficiaryId;
	private String transactionType;
	private double amount;
	private String mode;
	private String description;
	private String otherBankName;
	private String otherBankIfsc;
	private String referenceId;
	private Timestamp timestamp;
	private String accountNumber;
	private String beneficiary_name;
	
	public Transaction(int accountId, int beneficiaryId, String transactionType, double amount, String mode,
			String description) {
		super();
		this.accountId = accountId;
		this.beneficiaryId = beneficiaryId;
		this.transactionType = transactionType;
		this.amount = amount;
		this.mode = mode;
		this.description = description;
	}
	
	public Transaction(String transactionType, double amount, String mode, String description, 
			String referenceId, String accountNumber, String beneficiary_name, Timestamp timestamp) {
		super();
		this.transactionType = transactionType;
		this.amount = amount;
		this.mode = mode;
		this.description = description;
		this.referenceId = referenceId;
		this.accountNumber = accountNumber;
		this.beneficiary_name = beneficiary_name;
		this.timestamp = timestamp;
	}

	public Transaction(int accountId, String transactionType, double amount, String mode, String description) {
		super();
		this.accountId = accountId;
		this.transactionType = transactionType;
		this.amount = amount;
		this.mode = mode;
		this.description = description;
	}

	public String getBeneficiary_name() {
		return beneficiary_name;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public int getTransactionId() {
		return transactionId;
	}
	public int getAccountId() {
		return accountId;
	}
	public int getBeneficiaryId() {
		return beneficiaryId;
	}
	public String getTransactionType() {
		return transactionType;
	}
	public double getAmount() {
		return amount;
	}
	public String getMode() {
		return mode;
	}
	public String getDescription() {
		return description;
	}
	public String getOtherBankName() {
		return otherBankName;
	}
	public String getOtherBankIfsc() {
		return otherBankIfsc;
	}
	public String getReferenceId() {
		return referenceId;
	}
	public Timestamp getTimestamp() {
		return timestamp;
	}
}
