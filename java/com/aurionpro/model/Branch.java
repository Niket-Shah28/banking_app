package com.aurionpro.model;

import java.sql.Timestamp;

public class Branch {
	private int branchId;
	private String branchName;
	private int cityId;
	private String address;
	private String ifscCode;
	private String micrCode;
	private Timestamp createdAt;
	private String branchNameWithIfsc; // A STRING OF CONCATENATED " IFSC - BRANCH NAME "
	
	// CONSTRUCTORS
	public Branch(int branchId, String branchName, int cityId, String address, String ifscCode, String micrCode,
			Timestamp createdAt) {
		super();
		this.branchId = branchId;
		this.branchName = branchName;
		this.cityId = cityId;
		this.address = address;
		this.ifscCode = ifscCode;
		this.micrCode = micrCode;
		this.createdAt = createdAt;
	}
	
	public Branch(int branchId, String branchNameWithIfsc) {
		super();
		this.branchId = branchId;
		this.branchNameWithIfsc = branchNameWithIfsc;
	}

	// GETTERS
	public int getBranchId() {
		return branchId;
	}
	public String getBranchName() {
		return branchName;
	}
	public int getCityId() {
		return cityId;
	}
	public String getAddress() {
		return address;
	}
	public String getIfscCode() {
		return ifscCode;
	}
	public String getMicrCode() {
		return micrCode;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public String getBranchNameWithIfsc() {
		return branchNameWithIfsc;
	}
}
