package com.aurionpro.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.model.AccountCreationRequest;
import com.aurionpro.service.AccountRequestService;

@WebServlet("/AccountCreationRequestStatusController")
public class AccountCreationRequestStatusController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static AccountRequestService accountRequestService = AccountRequestService.getAccountRequestServiceInstance();

    public AccountCreationRequestStatusController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		int customerId = (int)(session.getAttribute("userId"));
		
		Map<String, List<AccountCreationRequest>> requests = accountRequestService.getCustomerAccountCreationRequests(customerId);
		
		request.setAttribute("pendingRequests", requests.get("PENDING"));
		request.setAttribute("reviewedRequests", requests.get("REVIEWED"));
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("AccountCreationRequestStatusView.jsp");
		dispatcher.forward(request, response);
	}

}
