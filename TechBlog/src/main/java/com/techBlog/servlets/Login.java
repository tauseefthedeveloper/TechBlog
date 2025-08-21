package com.techBlog.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techBlog.dao.UserDao;
import com.techBlog.entities.Message;
import com.techBlog.entities.User;
import com.techBlog.helper.ConnectionProvider;

public class Login extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req,resp);
	}

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		String email=req.getParameter("email");
		String password=req.getParameter("password");

		UserDao userDao=new UserDao(ConnectionProvider.getConnection());
		User user=userDao.getUserByEmailAndPassword(email, password);
		if(user==null) {
			Message msg=new Message("Please enter correct email and password...","error","alert-danger");
			HttpSession s=req.getSession();
			s.setAttribute("message", msg);
		    resp.sendRedirect("login.jsp");
		}else {
			HttpSession session=req.getSession();
			session.setAttribute("current_user", user);
			resp.sendRedirect("profile.jsp");
		}
	}

}
