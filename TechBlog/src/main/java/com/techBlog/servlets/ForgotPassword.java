package com.techBlog.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techBlog.dao.EmailSendDao;
import com.techBlog.entities.Message;
import com.techBlog.helper.ConnectionProvider;

@WebServlet("/forgot")
public class ForgotPassword extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String name = req.getParameter("name");
		String email = req.getParameter("email");

		try {
			Connection con = ConnectionProvider.getConnection();
			String q = "SELECT * FROM users WHERE Name=? AND Email=?";
			PreparedStatement ptstmt = con.prepareStatement(q);
			ptstmt.setString(1, name);
			ptstmt.setString(2, email);
			ResultSet set = ptstmt.executeQuery();
			if (set.next()) {
				HttpSession session = req.getSession();
				EmailSendDao emailSend = new EmailSendDao();
				String otp = emailSend.generateAlphaOtp();
				Message me=new Message("OTP sent successfully","success","alet-success");
				session.setAttribute("message", me);
				session.setAttribute("otp", otp);
				session.setAttribute("email", email);

				boolean sent = emailSend.OtpSendToEmail(email, otp);
				if(sent) {
					resp.getWriter().write("otpSent");
				}else {
					resp.getWriter().write("emailFail");
				}
			}else {
                resp.getWriter().write("invalidUser");
            }
		} catch (Exception e) {
			System.out.println(e);
		}
	}

}
