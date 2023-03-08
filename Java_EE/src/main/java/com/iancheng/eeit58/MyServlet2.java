package com.iancheng.eeit58;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MyServlet2") // 要改這個
public class MyServlet2 extends HttpServlet {

	
	public MyServlet2() {
		System.out.println("MyServlet2()");
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter()
		.append("Served at: ")
		.append(request.getContextPath() + "/")
		.append(getClass().getName());
		
	}

}
