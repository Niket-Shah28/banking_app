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

import com.aurionpro.model.Customer;
import com.aurionpro.service.UserService;

@WebServlet("/AdminCustomerDetailsViewController")
public class AdminCustomerDetailsViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static UserService userService = UserService.getUserServiceInstance();

    public AdminCustomerDetailsViewController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session.getAttribute("userId") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}
		
		List<Customer> customers = userService.getAllCustomerDetails();
		
		request.setAttribute("customers", customers);
		RequestDispatcher dispatcher = request.getRequestDispatcher("AdminCustomerDetailsViewPage.jsp");
		dispatcher.forward(request, response);
	}
}
