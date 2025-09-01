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

import com.aurionpro.service.CustomerDashboardDetailsService;

@WebServlet("/CustomerDashboardController")
public class CustomerDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static CustomerDashboardDetailsService customerDashboardDetailsService = CustomerDashboardDetailsService.getCustomerDashboardDetailsServiceInstance();

    public CustomerDashboardController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		int customerId = (int)session.getAttribute("userId");
		
		Map<String, Object> customerDashboardDetails = customerDashboardDetailsService.getCustomerDashBoardDetails(customerId);
		
		request.setAttribute("name", (String)session.getAttribute("name"));
		request.setAttribute("numberOfAccounts", (Integer)customerDashboardDetails.get("numberOfAccounts"));
		request.setAttribute("totalBalance", (Double)customerDashboardDetails.get("totalBalance"));
		request.setAttribute("numberOfTransactions", (Integer)customerDashboardDetails.get("numberOfTransactions"));
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("CustomerDashboard.jsp");
		dispatcher.forward(request, response);
	}

}
