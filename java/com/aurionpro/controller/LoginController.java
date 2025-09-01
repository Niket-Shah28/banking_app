package com.aurionpro.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.service.UserService;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static UserService userService;

    public LoginController() {
        super();
        if(userService == null) {
        	userService = UserService.getUserServiceInstance();
        }
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("Login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("userId"));
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		
		String name = userService.login(userId, password, role);
		
		if(name != null) {
			HttpSession session = request.getSession(true);
			session.setAttribute("userId", userId);
			session.setAttribute("name", name);
			if(role.equals("ADMIN")) {
				response.sendRedirect("AdminDashboardController");
			}
			else {
				response.sendRedirect("CustomerDashboardController");
			}
			return;
		}
		response.sendRedirect("Login.jsp");
	}
}
