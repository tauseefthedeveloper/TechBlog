package com.techBlog.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.techBlog.dao.EditDao;
import com.techBlog.helper.ConnectionProvider;

public class EditCommentAndReplyServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		service(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		service(req, resp);
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String operation=req.getParameter("operation");
		if(operation.equals("commentEdit")) {
			int commentId = Integer.parseInt(req.getParameter("commentId"));
			int postId = Integer.parseInt(req.getParameter("postId"));
			int userId = Integer.parseInt(req.getParameter("userId"));
			String message = req.getParameter("commentMessage");

			boolean f=false;
			EditDao editComment=new EditDao(ConnectionProvider.getConnection());
			f=editComment.updateComment(postId, userId, commentId, message);
			resp.getWriter().println(f);
		}else if(operation.equals("editChildReply")) {
			boolean f=false;
			int replyId=Integer.parseInt(req.getParameter("replyId"));
			int commentId = Integer.parseInt(req.getParameter("commentId"));
			int postId = Integer.parseInt(req.getParameter("postId"));
			int userId = Integer.parseInt(req.getParameter("userId"));
			String message = req.getParameter("message");
			EditDao edit=new EditDao(ConnectionProvider.getConnection());
			f=edit.editReply(replyId,commentId,postId,userId,message);
			resp.getWriter().println(f);

		}

	}
}
