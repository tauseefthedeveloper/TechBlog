package com.techBlog.servlets;

import java.io.IOException;

import com.techBlog.dao.CommentDao;
import com.techBlog.entities.Comments;
import com.techBlog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CommentServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		requestProcess(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		requestProcess(req, resp);
	}
	protected void requestProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String commentMessage=req.getParameter("message");
		int pid=Integer.parseInt(req.getParameter("pid"));
		int uid=Integer.parseInt(req.getParameter("uid"));
		String operaton=req.getParameter("operation");
		CommentDao commentDao=new CommentDao(ConnectionProvider.getConnection());
		Comments comm=new Comments(uid,pid,commentMessage);
		if(operaton.equals("comment")) {
			boolean f=commentDao.insertComment(comm);
			resp.getWriter().println(f);
		}
	}

}
