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

import com.aurionpro.model.Transaction;
import com.aurionpro.service.TransactionService;

@WebServlet("/AdminTransactionViewController")
public class AdminTransactionViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static TransactionService transactionService = TransactionService.getTransactionServiceInstance();

    public AdminTransactionViewController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		List<Transaction> transactions = transactionService.getAllTransactions();
		
		request.setAttribute("transactions", transactions);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("AdminTransactionsView.jsp");
		dispatcher.forward(request, response);
	}
}
