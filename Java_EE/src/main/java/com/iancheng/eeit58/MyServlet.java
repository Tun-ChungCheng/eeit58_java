package com.iancheng.eeit58;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MyServlet")
public class MyServlet extends HttpServlet {

	
	public MyServlet() {
		System.out.println(getClass().getName());
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter()
		.append("Served at: ")
		.append(request.getContextPath() + "/")
		.append(getClass().getName());
		
		Enumeration<String> names = request.getHeaderNames();
		
		while(names.hasMoreElements()) {
			String name = names.nextElement();
			String value = request.getHeader(name);
			
			System.out.printf("%s : %s%n", name, value);
		}
		
	}

}
