package com.aurionpro.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.service.AccountRequestService;

@WebServlet("/AccountRequestReviewController")
public class AccountRequestReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static AccountRequestService accountRequestService = AccountRequestService.getAccountRequestServiceInstance();;
    public AccountRequestReviewController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<Integer, Map<String, Object>> requestAndCustomerDetails = accountRequestService.getCustomerAccountRequestDetails();
		
		request.setAttribute("requestAndCustomerDetails", requestAndCustomerDetails);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("accountRequestReviewerPage.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int requestId = Integer.parseInt(request.getParameter("requestId"));
		String status = request.getParameter("action");
		
		accountRequestService.reviewRequest(requestId, status);
		
		doGet(request, response);
	}
}
