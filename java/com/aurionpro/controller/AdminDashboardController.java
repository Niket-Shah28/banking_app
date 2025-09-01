package com.aurionpro.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.service.AdminDashboardDetailsService;

@WebServlet("/AdminDashboardController")
public class AdminDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static AdminDashboardDetailsService adminDashboardDetailsService = AdminDashboardDetailsService.getAdminDashboardDetailsServiceInstance();

    public AdminDashboardController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		Map<String, Object> adminDashboardDetails = adminDashboardDetailsService.getAdminDashBoardDetails();
		
		request.setAttribute("name", (String)session.getAttribute("name"));
		request.setAttribute("numberOfAccounts", (Integer)adminDashboardDetails.get("numberOfAccounts"));
		request.setAttribute("numberOfCustomers", (Integer)adminDashboardDetails.get("numberOfCustomers"));
		request.setAttribute("numberOfTransactions", (Integer)adminDashboardDetails.get("numberOfTransactions"));
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("AdminDashboard.jsp");
		dispatcher.forward(request, response);
	}

}
