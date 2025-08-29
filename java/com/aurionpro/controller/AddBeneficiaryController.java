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

@WebServlet("/AddBeneficiaryController")
public class AddBeneficiaryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static AccountService accountService = AccountService.getAccountServiceInstance();
	private static BeneficiaryService beneficaryService = BeneficiaryService.getBeneficiaryServiceInstance();

    public AddBeneficiaryController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		int customerId = (int)(session.getAttribute("userId"));
		//System.out.println(customerId);
		List<Beneficiary> beneficiaries = beneficaryService.getCustomerBeneficiaries(customerId);
		
		List<Account> accounts = accountService.getSingleCustomerAccounts(customerId);
		
		request.setAttribute("accounts", accounts);
		System.out.println(accounts);
		request.setAttribute("beneficiaries", beneficiaries);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("Beneficiary.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		String beneficiaryName = request.getParameter("beneficiaryName");
		String beneficiaryAccountNumber = request.getParameter("beneficiaryAccountNumber");
		String beneficiaryBankName = request.getParameter("beneficiaryBankName");
		String beneficiaryIfsc = request.getParameter("beneficiaryIfsc");
		int customerId = (int)(session.getAttribute("userId"));
		
		System.out.println("Beneficiary Name: " + beneficiaryName);
		System.out.println("Beneficiary Account Number: " + beneficiaryAccountNumber);
		System.out.println("Beneficiary Bank Name: " + beneficiaryBankName);
		System.out.println("Beneficiary IFSC: " + beneficiaryIfsc);
		
		Beneficiary beneficiary = new Beneficiary(beneficiaryAccountNumber, beneficiaryName, customerId,
												  beneficiaryBankName, beneficiaryIfsc);
		
		beneficaryService.addBeneficiary(beneficiary);
		
		doGet(request, response);
	}

}
