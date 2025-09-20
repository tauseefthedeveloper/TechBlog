package com.techBlog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import com.techBlog.dao.UserDao;
import com.techBlog.entities.Message;
import com.techBlog.entities.User;
import com.techBlog.helper.CloudinaryHelper;
import com.techBlog.helper.ConnectionProvider;
import com.techBlog.helper.Helper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
public class EditedUserData extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get user inputs
        String name = req.getParameter("user_name");
        String email = req.getParameter("user_email");
        String password = req.getParameter("user_password");
        String about = req.getParameter("user_about");

        // Get uploaded profile picture
        Part profile_pic = req.getPart("user_pic");

        // Get current user from session
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("current_user");

        // Update basic details
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setAbout(about);

        String oldProfile = user.getProfile();
        String newProfile = oldProfile; // default to old profile

        if (profile_pic != null && profile_pic.getSize() > 0) {
            // Save uploaded file temporarily
            String uploadDir = req.getServletContext().getRealPath("/") + "pic";
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) uploadFolder.mkdirs();

            File tempFile = new File(uploadFolder, profile_pic.getSubmittedFileName());
            try (InputStream input = profile_pic.getInputStream()) {
                Files.copy(input, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            try {
                // Upload to Cloudinary and get URL
                newProfile = CloudinaryHelper.uploadImage(tempFile.getAbsolutePath());

                // Delete temp file
                tempFile.delete();

                // Optionally, delete old local file if it's not default.png and exists locally
                if (oldProfile != null && !oldProfile.isEmpty() && !oldProfile.contains("default.png") && oldProfile.startsWith("pic/")) {
                    Helper.deleteFile(req.getServletContext().getRealPath("/") + oldProfile);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Set the final profile (Cloudinary URL or old one)
        user.setProfile(newProfile);

        // Update DB
        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
        boolean updated = userDao.updateUser(user);

        // Set message
        Message msg;
        if (updated) {
            msg = new Message("Profile Updated Successfully...", "success", "alert-success");
        } else {
            msg = new Message("Something went wrong...", "error", "alert-danger");
        }
        session.setAttribute("message", msg);

        // Redirect to profile page
        resp.sendRedirect("profile.jsp");
    }
}
