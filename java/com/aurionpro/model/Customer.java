package com.aurionpro.model;

import java.sql.Timestamp;
import java.sql.Date;

public class Customer {
	private int customerId;
	private String name;
	private String email;
	private String phone;
	private String panNumber;
	private String aadharNumber;
	private Date dateOfBirth;
	private String address;
	private String password;
	private Timestamp createdAt;
	
	public Customer(String name, String email, String phone, String panNumber, String aadharNumber, Date dateOfBirth,
			String address, String password) {
		super();
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.panNumber = panNumber;
		this.aadharNumber = aadharNumber;
		this.dateOfBirth = dateOfBirth;
		this.address = address;
		this.password = password;
	}
	
	public Customer(int customerId, String name, String email, String phone, String panNumber, String aadharNumber,
			Date dateOfBirth, String address, String password, Timestamp createdAt) {
		super();
		this.customerId = customerId;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.panNumber = panNumber;
		this.aadharNumber = aadharNumber;
		this.dateOfBirth = dateOfBirth;
		this.address = address;
		this.password = password;
		this.createdAt = createdAt;
	}
	
	public Customer(String name, String email, String phone, String panNumber, String aadharNumber, Date dateOfBirth,
			String address) {
		super();
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.panNumber = panNumber;
		this.aadharNumber = aadharNumber;
		this.dateOfBirth = dateOfBirth;
		this.address = address;
	}

	public int getCustomerId() {
		return customerId;
	}
	public String getName() {
		return name;
	}
	public String getEmail() {
		return email;
	}
	public String getPhone() {
		return phone;
	}
	public String getPanNumber() {
		return panNumber;
	}
	public String getAadharNumber() {
		return aadharNumber;
	}
	public Date getDateOfBirth() {
		return dateOfBirth;
	}
	public String getAddress() {
		return address;
	}
	public String getPassword() {
		return password;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
}
