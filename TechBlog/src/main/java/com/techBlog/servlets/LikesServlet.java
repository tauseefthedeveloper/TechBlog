package com.techBlog.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.techBlog.dao.LikeDao;
import com.techBlog.helper.ConnectionProvider;

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
