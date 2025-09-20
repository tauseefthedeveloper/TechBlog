package com.techBlog.servlets;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import com.techBlog.dao.EditDao;
import com.techBlog.helper.CloudinaryHelper;
import com.techBlog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	int postId = Integer.parseInt(request.getParameter("postId"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String code = request.getParameter("code");
        String oldPic = request.getParameter("old_pic");

        Part part = request.getPart("new_pic");
        String imageUrl=oldPic;
        
        if (part != null && part.getSize() > 0) {
        	String uploadDir = request.getServletContext().getRealPath("/") + "posts_pic";
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }

            File tempFile = new File(uploadFolder, part.getSubmittedFileName());
            try (InputStream input = part.getInputStream()) {
                Files.copy(input, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            try {
                // Upload to Cloudinary and get the hosted URL
                imageUrl = CloudinaryHelper.uploadImage(tempFile.getAbsolutePath());
            } catch (Exception e) {
                e.printStackTrace();
                tempFile.delete(); 
            }
        }

        EditDao dao = new EditDao(ConnectionProvider.getConnection());
        boolean updated = dao.updatePost(postId, title, content, code, imageUrl);

        if (updated) {
        	response.getWriter().println(updated);
        } else {
            response.getWriter().println("Error");
        }
    }
}
