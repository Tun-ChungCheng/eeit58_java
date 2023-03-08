package com.iancheng.eeit58;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MyServlet3") // 要改這個
public class MyServlet3 extends HttpServlet {

	
	public MyServlet3() {
		System.out.println(getClass().getName());
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter()
			.append("Served at: ")
			.append(request.getContextPath() + "/")
			.append(getClass().getName());
		
		Enumeration<String> params = request.getParameterNames();
		
		while(params.hasMoreElements()) {
			String param = params.nextElement();
			String value = request.getParameter(param);
			System.out.printf("%s : %s%n", param, value);
		}
		
	}

}
