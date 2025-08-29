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
import com.aurionpro.service.AccountService;

@WebServlet("/CustomerAccountsController")
public class CustomerAccountsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static AccountService accountService = AccountService.getAccountServiceInstance();

    public CustomerAccountsController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
		}
		int customerId = (int)(session.getAttribute("userId"));
		List<Account> accounts = accountService.getSingleCustomerAccounts(customerId);
		request.setAttribute("accounts", accounts);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("CustomerAccounts.jsp");
		dispatcher.forward(request, response);
	}
}
