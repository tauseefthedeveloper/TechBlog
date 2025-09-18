package com.techBlog.servlets;

import java.io.IOException;

import com.techBlog.dao.UserDao;
import com.techBlog.entities.User;
import com.techBlog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
public class Register extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req,resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req,resp);
	}

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userCheck=req.getParameter("userCheck");
		if(userCheck==null) {
			resp.getWriter().println("Please accept the term's and condition.");
		}else {
			String userName=req.getParameter("userName");
			String userEmail=req.getParameter("userEmail");
			String userPassword=req.getParameter("userPassword");
			String userAbout=req.getParameter("userAbout");
			String userGender=req.getParameter("userGender");

			User userObject=new User(userName,userEmail,userPassword,userGender,userAbout);
			UserDao userDao=new UserDao(ConnectionProvider.getConnection());
			if(userDao.InsertUser(userObject)) {
				resp.getWriter().println("done");
			}else {
				resp.getWriter().println("Error");
			}
		}
	}

}
