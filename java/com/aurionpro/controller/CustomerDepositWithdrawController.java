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

import com.aurionpro.model.Account;
import com.aurionpro.model.Transaction;
import com.aurionpro.service.AccountService;
import com.aurionpro.service.TransactionService;

@WebServlet("/CustomerDepositWithdrawController")
public class CustomerDepositWithdrawController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static TransactionService transactionService = TransactionService.getTransactionServiceInstance();
	private static AccountService accountService = AccountService.getAccountServiceInstance();
	
    public CustomerDepositWithdrawController() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		int customerId = (int)session.getAttribute("userId");
		
		List<Account> accounts = accountService.getSingleCustomerAccounts(customerId);
		request.setAttribute("accounts", accounts);
    	
    	String action = request.getParameter("action");
    	RequestDispatcher dispatcher = null;
    	if(action.equals("WITHDRAW")) {
    		dispatcher = request.getRequestDispatcher("WithdrawAmount.jsp");
    	}
    	else {
    		dispatcher = request.getRequestDispatcher("DepositAmount.jsp");
    	}
    	dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int accountId = Integer.parseInt(request.getParameter("accountId"));
		double amount = Double.parseDouble(request.getParameter("amount"));
		String transactionType = request.getParameter("transactionType");
		String description;
		if(transactionType.equals("WITHDRAW")) {
			description = "AMOUNT WITHDRAWN";
		}
		else {
			description = "AMOUNT DEPOSITED";
		}
		
		Transaction transaction = new Transaction(accountId, transactionType, amount, "CASH", description);
		
		String message = transactionService.processWithdrawAndDeposit(transaction);
		
		request.setAttribute("message", message);
		request.setAttribute("action", transactionType);
		response.sendRedirect("CustomerDashboardController");
	}

}
