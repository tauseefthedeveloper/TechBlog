package com.techBlog.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.techBlog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/resetpassword")
public class ResetPassword extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}
	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String email=(String)session.getAttribute("email");
		String password=req.getParameter("password");

		try {
			Connection con=ConnectionProvider.getConnection();
			String q="UPDATE users SET Password=? WHERE Email=?";
			PreparedStatement ptstmt=con.prepareStatement(q);
			ptstmt.setString(1, password);
			ptstmt.setString(2, email);
			int row=ptstmt.executeUpdate();
			boolean f=row>0;
			if(f) {
				resp.getWriter().println("passwordReset");
			}else {
				resp.getWriter().println("notReset");
			}

		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
