package com.techBlog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class EditDao {
	Connection con;
	public EditDao(Connection con) {
		this.con=con;
	}
	public boolean updatePost(int postId, String title, String content, String code, String pic) {
	    boolean f = false;
	    try {
	        String query = "UPDATE posts SET Title=?, Content=?, Code=?, Picture=? WHERE PId=?";
	        PreparedStatement pstmt = this.con.prepareStatement(query);
	        pstmt.setString(1, title);
	        pstmt.setString(2, content);
	        pstmt.setString(3, code);
	        pstmt.setString(4, pic);
	        pstmt.setInt(5, postId);

	        pstmt.executeUpdate();
	        f = true;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return f;
	}
	public boolean updateComment(int postId,int userId,int commentId,String message) {
		boolean f=false;
		String q="UPDATE comments SET commMessage=? WHERE commId=? AND PId=? AND UId=?";
		try {
			PreparedStatement ptstc=this.con.prepareStatement(q);
			ptstc.setString(1, message);
			ptstc.setInt(2, commentId);
			ptstc.setInt(3, postId);
			ptstc.setInt(4, userId);
			ptstc.executeUpdate();
			f=true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return f;
	}
	public boolean editReply(int replyId, int commentId, int postId, int userId, String message) {
		boolean f=false;
		String q="UPDATE replies SET replyMessage=? WHERE replyId=? AND commId=? AND UId=? AND postId=?";
		try {
			PreparedStatement ptstc=this.con.prepareStatement(q);
			ptstc.setString(1, message);
			ptstc.setInt(2, replyId);
			ptstc.setInt(3, commentId);
			ptstc.setInt(4, userId);
			ptstc.setInt(5, postId);
			ptstc.executeUpdate();
			f=true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return f;
	}

}
