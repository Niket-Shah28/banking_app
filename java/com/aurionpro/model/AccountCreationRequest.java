package com.aurionpro.model;

import java.sql.Timestamp;

public class AccountCreationRequest {
	private int requestId;
	private int customerId;
	private String accountType;
	private double startBalance;
	private int branchId;
	private String status;
	private Timestamp createdAt;
	private Timestamp reviewedAt;
	
	private String branchName;
	private String ifscCode;
	
	public AccountCreationRequest(int customerId, String accountType, double startBalance, int branchId) {
		super();
		this.customerId = customerId;
		this.accountType = accountType;
		this.startBalance = startBalance;
		this.branchId = branchId;
	}

	public AccountCreationRequest(int requestId, int customerId, String accountType, double startBalance, int branchId,
			String status, Timestamp createdAt, Timestamp reviewedAt) {
		super();
		this.requestId = requestId;
		this.customerId = customerId;
		this.accountType = accountType;
		this.startBalance = startBalance;
		this.branchId = branchId;
		this.status = status;
		this.createdAt = createdAt;
		this.reviewedAt = reviewedAt;
	}
	
	public AccountCreationRequest(int requestId, int customerId, String accountType, double startBalance, int branchId,
			String branchName, String ifscCode) {
		super();
		this.requestId = requestId;
		this.customerId = customerId;
		this.accountType = accountType;
		this.startBalance = startBalance;
		this.branchId = branchId;
		this.branchName = branchName;
		this.ifscCode = ifscCode;
	}

	public int getRequestId() {
		return requestId;
	}
	public int getCustomerId() {
		return customerId;
	}
	public String getAccountType() {
		return accountType;
	}
	public double getStartBalance() {
		return startBalance;
	}
	public int getBranchId() {
		return branchId;
	}
	public String getStatus() {
		return status;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public Timestamp getReviewedAt() {
		return reviewedAt;
	}
	public String getBranchName() {
		return branchName;
	}
	public String getIfscCode() {
		return ifscCode;
	}
}
