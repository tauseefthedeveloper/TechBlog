package com.techBlog.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.techBlog.dao.RepliesDao;
import com.techBlog.entities.RepliesOnComment;
import com.techBlog.helper.ConnectionProvider;

public class RepliesServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		requestProcess(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		requestProcess(req, resp);
	}
	protected void requestProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int commId=Integer.parseInt(req.getParameter("commentId"));
		int UId=Integer.parseInt(req.getParameter("userId"));
		int postId=Integer.parseInt(req.getParameter("postId"));
		String replyMessage=req.getParameter("replyMessage");
		String operation=req.getParameter("operation");
		RepliesDao replyDao=new RepliesDao(ConnectionProvider.getConnection());
		if(operation.equals("reply")) {
			RepliesOnComment reply2=new RepliesOnComment(commId,UId,postId,replyMessage);
			boolean f=replyDao.insertReplies(reply2);
			resp.getWriter().println(f);
		}
		if(operation.equals("reply2")) {
			int parent_reply_id=Integer.parseInt(req.getParameter("parent_reply_id"));
			RepliesOnComment reply2=new RepliesOnComment(commId,UId,postId,replyMessage,parent_reply_id);
			boolean f=replyDao.insertReplies2(reply2);
			resp.getWriter().println(f);
		}
	}
}
