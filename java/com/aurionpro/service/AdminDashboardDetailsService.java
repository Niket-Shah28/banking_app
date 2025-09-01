package com.aurionpro.service;

import java.util.Map;

import com.aurionpro.dao.AdminDashboardDetailDao;

public class AdminDashboardDetailsService {
	private static AdminDashboardDetailDao adminDashboardDetailDao = AdminDashboardDetailDao.getAdminDahsboardDetailsDaoInstance();
	private static AdminDashboardDetailsService adminDashboardDetailsService;
	
	public AdminDashboardDetailsService() {}
	
	public static AdminDashboardDetailsService getAdminDashboardDetailsServiceInstance() {
		if(adminDashboardDetailsService == null) {
			adminDashboardDetailsService = new AdminDashboardDetailsService();
		}
		return adminDashboardDetailsService;
	}
	
	public Map<String, Object> getAdminDashBoardDetails() {
		return adminDashboardDetailDao.getAdminDashBoardDetails();
	}
}
