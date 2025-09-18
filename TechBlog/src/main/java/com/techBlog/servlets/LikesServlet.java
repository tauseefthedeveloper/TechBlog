package com.techBlog.servlets;

import java.io.IOException;

import com.techBlog.dao.LikeDao;
import com.techBlog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LikesServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		processRequest(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		processRequest(req, resp);
	}
	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String operation=req.getParameter("operation");
		int pid =Integer.parseInt(req.getParameter("pid"));
		int uid =Integer.parseInt(req.getParameter("uid"));

		LikeDao like=new LikeDao(ConnectionProvider.getConnection());
		if(operation.equals("like")) {
			boolean f=like.insertLike(pid, uid);
			resp.getWriter().println(f);
		}
	}

}
