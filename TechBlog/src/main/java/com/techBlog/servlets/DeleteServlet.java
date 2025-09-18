package com.techBlog.servlets;

import java.io.IOException;

import com.techBlog.dao.DeleteDao;
import com.techBlog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteServlet extends HttpServlet {

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
		int postId = Integer.parseInt(req.getParameter("postId"));
		int userId = Integer.parseInt(req.getParameter("userId"));
		int commentId=Integer.parseInt(req.getParameter("commentId"));
		String operation = req.getParameter("operation");
		boolean deleted = false;

		if (operation.equals("delete")) {
			DeleteDao deleteDao=new DeleteDao(ConnectionProvider.getConnection());
			deleted=deleteDao.deletePost(postId, userId);
		}else if(operation.equals("commentDelete")) {
			DeleteDao deleteDao2=new DeleteDao(ConnectionProvider.getConnection());
			deleted=deleteDao2.deleteComment(postId,userId,commentId);
		}else if(operation.equals("childCommentDelete")) {
			int replyId=Integer.parseInt(req.getParameter("replyId"));
			DeleteDao deleteDao3=new DeleteDao(ConnectionProvider.getConnection());
			deleted=deleteDao3.deleteChildReply(postId,userId,commentId,replyId);
		}
		resp.getWriter().println(deleted);
	}
}