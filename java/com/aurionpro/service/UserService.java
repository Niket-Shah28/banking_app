package com.aurionpro.service;

import java.util.List;

import com.aurionpro.dao.UserDao;
import com.aurionpro.model.Customer;

public class UserService {
	private static UserDao userDao = UserDao.getUSerDaoInstance();
	private static UserService userService;
	
	private UserService() {}
	
	public static UserService getUserServiceInstance() {
		if(userService == null) {
			userService = new UserService();
		}
		return userService;
	}
	
	public String login(int userId, String password, String role) {
		return userDao.login(userId, password, role);
	}
	
	public boolean registerCustomer(Customer customer) {
		return userDao.registerCustomer(customer);
	}
	
	public List<Customer> getAllCustomerDetails() {
		return userDao.getAllCustomerDetails();
	}
}
