package com.techBlog.servlets;

import java.io.File;
import java.io.IOException;

import com.techBlog.dao.PostDao;
import com.techBlog.entities.Posts;
import com.techBlog.entities.User;
import com.techBlog.helper.Helper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
public class AddPostServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processReqeust(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processReqeust(req, resp);
	}
	protected void processReqeust(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int CId=Integer.parseInt(req.getParameter("CId"));
		String title=req.getParameter("title");
		String content=req.getParameter("content");
		String code=req.getParameter("code");
		Part pic=req.getPart("post_pic");
		//get the current user
		HttpSession s=req.getSession();
		User user=(User)s.getAttribute("current_user");
		int userId=user.getId();

		Posts p=new Posts(title,content,code,null,pic.getSubmittedFileName(),CId,userId);
		PostDao postDao=new PostDao();
		if(postDao.savePosts(p)) {
			String path=req.getServletContext().getRealPath("/")+"posts_pic"+File.separator+pic.getSubmittedFileName();
			Helper.saveFile(pic.getInputStream(), path);
			resp.getWriter().println("done");
			resp.sendRedirect("profile.jsp");
		}else {
			resp.getWriter().println("error");
		}
	}
}
