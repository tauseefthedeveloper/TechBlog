package com.techBlog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

import com.techBlog.dao.PostDao;
import com.techBlog.entities.Posts;
import com.techBlog.entities.User;
import com.techBlog.helper.CloudinaryHelper;
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

		String imageUrl=null;
		if(pic !=null && pic.getSize()>0) {
			 String uploadDir = req.getServletContext().getRealPath("/") + "posts_pic";
	            File uploadFolder = new File(uploadDir);
	            if (!uploadFolder.exists()) {
	                uploadFolder.mkdirs();
	            }

	            File tempFile = new File(uploadFolder, pic.getSubmittedFileName());
	            try (InputStream input = pic.getInputStream()) {
	                Files.copy(input, tempFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
	            }
	            
	            try {
	                imageUrl = CloudinaryHelper.uploadImage(tempFile.getAbsolutePath());
	            } catch (Exception e) {
	                e.printStackTrace();
	                tempFile.delete();
	            }
		}
		Posts p=new Posts(title,content,code,null,imageUrl,CId,userId);
		PostDao postDao=new PostDao();
		if(postDao.savePosts(p)) {
			resp.getWriter().println("done");
		}else {
			resp.getWriter().println("error");
		}
	}
}
