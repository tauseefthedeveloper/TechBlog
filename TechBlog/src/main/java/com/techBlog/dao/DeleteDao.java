package com.techBlog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.techBlog.helper.ConnectionProvider;

public class DeleteDao {
	Connection con;
	public DeleteDao(Connection con) {
		this.con=con;
	}
	String deleteLikes = "DELETE FROM likes WHERE PId=?";
	String deleteComments = "DELETE FROM comments WHERE PId=?";
	String deletePost = "DELETE FROM posts WHERE PId=? AND userId=?";
	boolean f=false;
	public boolean deletePost(int postId,int userId) {
		try {
			con = ConnectionProvider.getConnection();

			// Delete likes
			PreparedStatement ps1 = con.prepareStatement(deleteLikes);
			ps1.setInt(1, postId);
			ps1.executeUpdate();

			// Delete comments
			PreparedStatement ps2 = con.prepareStatement(deleteComments);
			ps2.setInt(1, postId);
			ps2.executeUpdate();

			// Delete post
			PreparedStatement ps3 = con.prepareStatement(deletePost);
			ps3.setInt(1, postId);
			ps3.setInt(2, userId);
			int rows = ps3.executeUpdate();
			f = rows > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public boolean deleteComment(int postId, int userId, int commentId) {
		boolean f=false;
		String q = "DELETE FROM comments WHERE commId = ? AND PId = ? AND UId = ?";
		try {
			PreparedStatement pstd=con.prepareStatement(q);
			pstd.setInt(1, commentId);
			pstd.setInt(2, postId);
			pstd.setInt(3, userId);
			int rows = pstd.executeUpdate();
			f = rows > 0;
		} catch (Exception e) {
			System.out.println(e);
		}
		return f;
	}
	public boolean deleteChildReply(int postId, int userId, int commentId, int replyId) {
		boolean f=false;
			String q="Delete from replies where replyId=? and commId=? and UId=? and postId=?";
			try {
				PreparedStatement ptstmt=con.prepareStatement(q);
				ptstmt.setInt(1, replyId);
				ptstmt.setInt(2, commentId);
				ptstmt.setInt(3, userId);
				ptstmt.setInt(4, postId);
				ptstmt.executeUpdate();
				f=true;
			} catch (Exception e) {
				System.out.println(e);
			}
		return f;
	}
}
