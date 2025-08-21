package com.techBlog.servlets;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.techBlog.dao.UserDao;
import com.techBlog.entities.Message;
import com.techBlog.entities.User;
import com.techBlog.helper.ConnectionProvider;
import com.techBlog.helper.Helper;

@MultipartConfig
public class EditedUserData extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name=req.getParameter("user_name");
		String email=req.getParameter("user_email");
		String password=req.getParameter("user_password");
		String about=req.getParameter("user_about");

		Part profile_pic=req.getPart("user_pic");
		String imageName=profile_pic.getSubmittedFileName();
		HttpSession s=req.getSession();
		User user=(User)s.getAttribute("current_user");
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.setAbout(about);
		String oldProfile=user.getProfile();
		user.setProfile(imageName);
		UserDao userDao=new UserDao(ConnectionProvider.getConnection());
		boolean f=userDao.updateUser(user);
		if(f) {
			String path=req.getRealPath("/")+"pic"+File.separator+user.getProfile();
			String Oldpath=req.getRealPath("/")+"pic"+File.separator+oldProfile;
			System.out.println("path:"+path);
			System.out.println("Old path:"+Oldpath);
			if(!oldProfile.equals("default.png")) {
				Helper.deleteFile(Oldpath);
			}
			if(Helper.saveFile(profile_pic.getInputStream(), path)) {
				Message msg=new Message("Profile Updated Successfully...","success","alert-success");
				s.setAttribute("message", msg);
				resp.sendRedirect("profile.jsp");
			}else {
				Message msg=new Message("Profile picture not save...","error","alert-danger");
				s.setAttribute("message", msg);
				resp.sendRedirect("profile.jsp");
			}
		}else {
			Message msg=new Message("Something went wrong...","error","alert-danger");
			s.setAttribute("message", msg);
			resp.sendRedirect("profile.jsp");
		}


	}

}
