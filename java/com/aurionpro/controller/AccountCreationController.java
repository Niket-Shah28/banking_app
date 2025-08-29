package com.aurionpro.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.AccountCreationRequest;
import com.aurionpro.model.Branch;
import com.aurionpro.service.AccountRequestService;
import com.aurionpro.service.BranchService;

@WebServlet("/AccountCreationController")
public class AccountCreationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static BranchService branchService = BranchService.getBranchServiceInstance();;
	private static AccountRequestService accountRequestService = AccountRequestService.getAccountRequestServiceInstance();
    public AccountCreationController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		Integer customerId = (Integer)(session.getAttribute("userId"));
		if(customerId == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		List<Branch> branches = branchService.getBranchDetails();
		request.setAttribute("branches", branches);
		RequestDispatcher dispatcher = request.getRequestDispatcher("AccountCreationPage.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		Integer customerId = (Integer)(session.getAttribute("userId"));
		if(customerId == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		String accountType = request.getParameter("accountType");
		double startBalance = Double.parseDouble(request.getParameter("startBalance"));
		int branchId = Integer.parseInt(request.getParameter("branchId"));
		
		System.out.println("Account Type: "+accountType);
		System.out.println("Start Balance: "+startBalance);
		System.out.println("Branch Id: "+branchId);
		
		accountRequestService.addAccountCreationRequest(new AccountCreationRequest(customerId, accountType, startBalance, branchId));
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("CustomerDashboard.jsp");
		dispatcher.forward(request, response);
	}

}
