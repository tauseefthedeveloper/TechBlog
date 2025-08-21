package com.techBlog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.techBlog.entities.RepliesOnComment;

public class RepliesDao {
	Connection con;
	public RepliesDao(Connection con) {
		this.con=con;
	}
	public boolean insertReplies(RepliesOnComment reply) {
		boolean f=false;
		try {
			String q="insert into replies (commId,UId,postId,replyMessage) values (?,?,?,?)";
			PreparedStatement pt=con.prepareStatement(q);
			pt.setInt(1, reply.getCommId());
			pt.setInt(2, reply.getUId());
			pt.setInt(3, reply.getPostId());
			pt.setString(4,reply.getReplyMessage());
			pt.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public boolean insertReplies2(RepliesOnComment reply) {
	    boolean success = false;

	    try {
	        // SQL: parent_reply_id can be NULL
	        String sql = "INSERT INTO replies2 (comment_id, parent_reply_id, user_id, reply_text) " +
	                     "VALUES (?, ?, ?, ?)";

	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, reply.getCommId());
	        ps.setInt(2, reply.getParent_reply_id());
	        ps.setInt(3, reply.getUId());
	        ps.setString(4, reply.getReplyMessage());
	        int rows = ps.executeUpdate();
	        success = rows > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return success;
	}

	public List<Map<String, Object>> getReplies(int commId, int postId) {
	    List<Map<String, Object>> list = new ArrayList<>();

	    try {
	        String q = "SELECT r.replyId, r.commId, r.postId, r.replyMessage, r.RDate, "
	                 + "u.Id AS userId, u.name AS userName, u.Profile AS replyUserProfile "
	                 + "FROM replies r "
	                 + "JOIN users u ON r.UId = u.Id "
	                 + "WHERE r.commId = ? AND postId=? "
	                 + "ORDER BY r.RDate DESC";

	        PreparedStatement ptstmt = con.prepareStatement(q);
	        ptstmt.setInt(1, commId);
	        ptstmt.setInt(2, postId);
	        ResultSet set = ptstmt.executeQuery();

	        while (set.next()) {
	            Map<String, Object> replyData = new HashMap<>();
	            replyData.put("replyId", set.getInt("replyId"));
	            replyData.put("commId", set.getInt("commId"));
	            replyData.put("postId", set.getInt("postId"));
	            replyData.put("replyMessage", set.getString("replyMessage"));
	            replyData.put("RDate", set.getTimestamp("RDate"));
	            replyData.put("userId", set.getInt("userId"));
	            replyData.put("userName", set.getString("userName"));
	            replyData.put("replyUserProfile", set.getString("replyUserProfile"));

	            list.add(replyData);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	public List<Map<String, Object>> getReplies2(int commentId, int parentReplyId) {
	    List<Map<String, Object>> list = new ArrayList<>();

	    try {
	        String q = "SELECT r.reply_id, r.comment_id, r.parent_reply_id, r.user_id, " +
	                   "r.reply_text, r.created_at, u.name AS userName, u.Profile AS replyUserProfile " +
	                   "FROM replies2 r " +
	                   "JOIN users u ON r.user_id = u.Id " +
	                   "WHERE r.comment_id = ? AND r.parent_reply_id = ? " +
	                   "ORDER BY r.created_at DESC";

	        PreparedStatement ptstmt = con.prepareStatement(q);
	        ptstmt.setInt(1, commentId);
	        ptstmt.setInt(2, parentReplyId);
	        ResultSet set = ptstmt.executeQuery();

	        while (set.next()) {
	            Map<String, Object> replyData = new HashMap<>();
	            replyData.put("replyId", set.getInt("reply_id"));
	            replyData.put("commentId", set.getInt("comment_id"));
	            replyData.put("parentReplyId", set.getInt("parent_reply_id"));
	            replyData.put("userId", set.getInt("user_id"));
	            replyData.put("replyText", set.getString("reply_text"));
	            replyData.put("createdAt", set.getTimestamp("created_at"));
	            replyData.put("userName", set.getString("userName"));
	            replyData.put("replyUserProfile", set.getString("replyUserProfile"));

	            list.add(replyData);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

//	public List<Map<String, Object>> getRepliesByPostIdUserId(int commId,int postId) {
//		List<Map<String, Object>> list = new ArrayList<>();
//		try {
//			String q = "SELECT r.replyId, r.commId, r.postId, r.replyMessage, r.RDate, "
//			         + "uId AS userId, u.name AS userName, u.Profile AS replyUserProfile "
//			         + "FROM replies r "
//			         + "JOIN users u ON r.UId = u.Id "
//			         + "WHERE r.commId = ? AND postId=? "
//			         + "ORDER BY r.RDate ASC";
//
//			PreparedStatement ptstmt=con.prepareStatement(q);
//			//SELECT r.replyId,  r.commId, r.postId,  r.replyMessage,  r.RDate,  u.Id AS userId, u.name AS
//			//userName, u.email AS userEmail FROM replies r JOIN users u ON r.UId = u.Id WHERE
//			//r.commId = 8 ORDER BY r.RDate ASC;
//			ptstmt.setInt(1, commId);
//			ptstmt.setInt(2, postId);
//			ResultSet set=ptstmt.executeQuery();
//			while (set.next()) {
//			    Map<String, Object> replyData = new HashMap<>();
//			    replyData.put("replyId", set.getInt("replyId"));
//			    replyData.put("commId", set.getInt("commId"));
//			    replyData.put("postId", set.getInt("postId"));
//			    replyData.put("replyMessage", set.getString("replyMessage"));
//			    replyData.put("RDate", set.getTimestamp("RDate"));
//			    replyData.put("userId", set.getInt("userId"));
//			    replyData.put("userName", set.getString("userName"));
//			    replyData.put("replyUserProfile", set.getString("replyUserProfile"));
//			    list.add(replyData);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return list;
//	}
//	public List<Map<String, Object>> getRepliesByParentId(int parentReplyId) {
//	    List<Map<String, Object>> list = new ArrayList<>();
//	    String query = "SELECT r.*, u.name AS userName, u.profile AS replyUserProfile" +
//	                   "FROM replies r JOIN users u ON r.user_id = u.id " +
//	                   "WHERE r.parent_reply_id = ? ORDER BY r.RDate ASC";
//	    try (PreparedStatement pst = con.prepareStatement(query)) {
//	        pst.setInt(1, parentReplyId);
//	        try (ResultSet rs = pst.executeQuery()) {
//	            while (rs.next()) {
//	                Map<String, Object> map = new HashMap<>();
//	                map.put("replyMessage", rs.getString("replyMessage"));
//	                map.put("RDate", rs.getTimestamp("RDate"));
//	                map.put("userName", rs.getString("userName"));
//	                map.put("replyUserProfile", rs.getString("replyUserProfile"));
//	                map.put("replyId", rs.getInt("replyId"));
//	                map.put("parent_reply_id", rs.getInt("parent_reply_id"));
//	                list.add(map);
//	            }
//	        }
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//	    return list;
//	}
}
