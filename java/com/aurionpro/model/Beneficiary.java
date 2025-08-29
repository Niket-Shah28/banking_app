package com.aurionpro.model;

import java.sql.Timestamp;

public class Beneficiary {
	private int beneficiaryId;
	private String beneficiaryAccountNumber;
	private String beneficiaryName;
	private int customerId;
	private String beneficiaryBankName;
	private String beneficiaryIfsc;
	private Timestamp createdAt;

	public Beneficiary(int beneficiaryId, String beneficiaryAccountNumber, String beneficiaryName, int customerId,
			String beneficiaryBankName, String beneficiaryIfsc, Timestamp createdAt) {
		super();
		this.beneficiaryId = beneficiaryId;
		this.beneficiaryAccountNumber = beneficiaryAccountNumber;
		this.beneficiaryName = beneficiaryName;
		this.customerId = customerId;
		this.beneficiaryBankName = beneficiaryBankName;
		this.beneficiaryIfsc = beneficiaryIfsc;
		this.createdAt = createdAt;
	}

	public Beneficiary(int beneficiaryId, String beneficiaryAccountNumber, String beneficiaryName, String beneficiaryBankName,
			String beneficiaryIfsc) {
		super();
		this.beneficiaryId = beneficiaryId;
		this.beneficiaryAccountNumber = beneficiaryAccountNumber;
		this.beneficiaryName = beneficiaryName;
		this.beneficiaryBankName = beneficiaryBankName;
		this.beneficiaryIfsc = beneficiaryIfsc;
	}

	public Beneficiary(String beneficiaryAccountNumber, String beneficiaryName, int customerId,
			String beneficiaryBankName, String beneficiaryIfsc) {
		super();
		this.beneficiaryAccountNumber = beneficiaryAccountNumber;
		this.beneficiaryName = beneficiaryName;
		this.customerId = customerId;
		this.beneficiaryBankName = beneficiaryBankName;
		this.beneficiaryIfsc = beneficiaryIfsc;
	}

	public int getBeneficiaryId() {
		return beneficiaryId;
	}

	public String getBeneficiaryAccountNumber() {
		return beneficiaryAccountNumber;
	}

	public int getCustomerId() {
		return customerId;
	}

	public String getBeneficiaryBankName() {
		return beneficiaryBankName;
	}

	public String getBeneficiaryIfsc() {
		return beneficiaryIfsc;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public String getBeneficiaryName() {
		return beneficiaryName;
	}
}
