package com.aurionpro.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.Account;
import com.aurionpro.model.Nominee;
import com.aurionpro.service.AccountService;
import com.aurionpro.service.NomineeService;

@WebServlet("/NomineeController")
public class NomineeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static AccountService accountService = AccountService.getAccountServiceInstance();
	private static NomineeService nomineeService = NomineeService.getNomineeServiceInstance();
 
    public NomineeController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		int customerId = (int)(session.getAttribute("userId"));
		
		List<Nominee> nominees = nomineeService.getCustomerNominee(customerId);
		List<Account> accounts = accountService.getSingleCustomerAccounts(customerId);
		
		request.setAttribute("accounts", accounts);
		request.setAttribute("nominees", nominees);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("Nominee.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String nomineeName = request.getParameter("nomineeName");
		Date nomineeDateOfBirth = Date.valueOf(request.getParameter("nomineeDob"));
		String address = request.getParameter("nomineeAddress");
		String panNumber = request.getParameter("nomineePan");
		String relation = request.getParameter("nomineeRelation");
		int accountId = Integer.valueOf(request.getParameter("accountId"));
		
		Nominee nominee = new Nominee(nomineeName, nomineeDateOfBirth, address, panNumber, relation, accountId);
		
		nomineeService.addNominee(nominee);
		
		doGet(request, response);
	}

}
