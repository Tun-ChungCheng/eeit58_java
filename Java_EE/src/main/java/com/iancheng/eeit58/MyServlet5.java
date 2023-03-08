package com.iancheng.eeit58;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MyServlet5") // 要改這個
public class MyServlet5 extends HttpServlet {

	public MyServlet5() {
		System.out.println(getClass().getName());
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		
		String resultToString = "";
		String xToString = "";
		String yToString = "";
		String operator = request.getParameter("operator");
		
		if(operator == null) operator = "1";
		
		try {
			int x = Integer.parseInt(request.getParameter("x"));
			int y = Integer.parseInt(request.getParameter("y"));
			int result = 0;
			
			switch(operator) {
				case "1" -> result = x + y;
				case "2" -> result = x - y;
				case "3" -> result = x * y;
				case "4" -> result = x / y;
			}
			
			resultToString = result + "";
			xToString = x + "";
			yToString = y + "";
		} catch(Exception e) {
			System.out.println("ERR : " + e);
		}
		
		PrintWriter out = response.getWriter();
		
		out.append(   "<form action='MyServlet5'>\r\n"
					+ "	<input type='text'\r\n"
					+ "		   id='x'\r\n"
					+ "		   name='x'\r\n"
					+ "		   value="
					+ xToString
					+ "	>\r\n"
					+ "<select name='operator'>"
					+ " <option value='1' " + (operator.equals("1")? "selected": "") +">+</option>"
					+ " <option value='2' " + (operator.equals("2")? "selected": "") +">-</option>"
					+ " <option value='3' " + (operator.equals("3")? "selected": "") +">*</option>"
					+ " <option value='4' " + (operator.equals("4")? "selected": "") +">/</option>"
					+ "</select>"
					+ "	<input type='text'\r\n"
					+ "		   id='y'\r\n"
					+ "		   name='y'\r\n"
					+ "		   value="
					+ yToString
					+ "	>\r\n"
					+ "	<button type='submit'>=</button>\r\n"
					+ resultToString
					+ "</form>");
		
	}

}
