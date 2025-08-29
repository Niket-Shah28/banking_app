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
import com.aurionpro.model.Beneficiary;
import com.aurionpro.service.AccountService;
import com.aurionpro.service.BeneficiaryService;

@WebServlet("/PaymentController")
public class PaymentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static BeneficiaryService beneficiaryService = BeneficiaryService.getBeneficiaryServiceInstance();
    private static AccountService accountService = AccountService.getAccountServiceInstance();
	public PaymentController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		int customerId = (int)(session.getAttribute("userId"));
		List<Beneficiary> beneficiaries = beneficiaryService.getCustomerBeneficiaries(customerId);
		List<Account> accounts = accountService.getSingleCustomerAccounts(customerId);
		
		request.setAttribute("accounts", accounts);
		request.setAttribute("beneficiaries", beneficiaries);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("PaymentPage.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int beneficiaryId = Integer.parseInt(request.getParameter("beneficiaryId"));
		int accountId = Integer.parseInt(request.getParameter("accountId"));
		String paymentMode = request.getParameter("mode");
		double amount = Double.parseDouble(request.getParameter("amount"));
		
		
	}

}
