package com.aurionpro.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Nominee {
	private int nomineeId;
	private int accountId;
	private String name;
	private Date dateOfBirth;
	private String address;
	private String panNumber;
	private String relation;
	private Timestamp createdAt;
	private String linkedAccountNumber;
	
	public Nominee(int nomineeId, String name, Date dateOfBirth, String address, String panNumber, String relation,
			Timestamp createdAt, int accountId) {
		super();
		this.nomineeId = nomineeId;
		this.name = name;
		this.dateOfBirth = dateOfBirth;
		this.address = address;
		this.panNumber = panNumber;
		this.relation = relation;
		this.createdAt = createdAt;
		this.accountId = accountId;
	}

	public Nominee(String name, Date dateOfBirth, String address, String panNumber, String relation, int accountId) {
		super();
		this.name = name;
		this.dateOfBirth = dateOfBirth;
		this.address = address;
		this.panNumber = panNumber;
		this.relation = relation;
		this.accountId = accountId;
	}

	public Nominee(String name, Date dateOfBirth, String address, String panNumber, String relation,
			String linkedAccountNumber) {
		super();
		this.name = name;
		this.dateOfBirth = dateOfBirth;
		this.address = address;
		this.panNumber = panNumber;
		this.relation = relation;
		this.linkedAccountNumber = linkedAccountNumber;
	}
	
	public int getAccountId() {
		return accountId;
	}
	public String getLinkedAccountNumber() {
		return linkedAccountNumber;
	}
	public int getNomineeId() {
		return nomineeId;
	}
	public String getName() {
		return name;
	}
	public Date getDateOfBirth() {
		return dateOfBirth;
	}
	public String getAddress() {
		return address;
	}
	public String getPanNumber() {
		return panNumber;
	}
	public String getRelation() {
		return relation;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
}
