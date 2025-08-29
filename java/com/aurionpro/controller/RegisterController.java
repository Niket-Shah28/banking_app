package com.aurionpro.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.Customer;
import com.aurionpro.service.UserService;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static UserService userService;

    public RegisterController() {
        super();
        if(userService == null) {
        	userService = UserService.getUserServiceInstance();
        }
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("Register.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String panNumber = request.getParameter("panNumber");
		String aadharNumber = request.getParameter("aadharNumber");
		Date dateOfBirth = Date.valueOf(request.getParameter("dateOfBirth"));
		String address = request.getParameter("address");
		String password = request.getParameter("password");
		
		Customer customer = new Customer(name, email, phone, panNumber, aadharNumber, dateOfBirth, address, password);
		
		boolean success = userService.registerCustomer(customer);
		
		if(!success) {
			response.sendRedirect("Register.jsp?errorMessage=User already exists");
			return;
		}
		
		response.sendRedirect("Login.jsp");
		
	}

}
