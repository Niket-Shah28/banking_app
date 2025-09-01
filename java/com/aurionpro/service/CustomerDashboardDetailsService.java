package com.aurionpro.service;

import java.util.Map;

import com.aurionpro.dao.CustomerDashboardDetailsDao;

public class CustomerDashboardDetailsService {
	private static CustomerDashboardDetailsDao customerDashboardDetailDao = CustomerDashboardDetailsDao.getCustomerDahsboardDetailsDaoInstance();
	private static CustomerDashboardDetailsService customerDashboardDetailsService;
	
	public CustomerDashboardDetailsService() {}
	
	public static CustomerDashboardDetailsService getCustomerDashboardDetailsServiceInstance() {
		if(customerDashboardDetailsService == null) {
			customerDashboardDetailsService = new CustomerDashboardDetailsService();
		}
		return customerDashboardDetailsService;
	}
	
	public Map<String, Object> getCustomerDashBoardDetails(int customerId){
		return customerDashboardDetailDao.getCustomerDashBoardDetails(customerId);
	}
	
}
