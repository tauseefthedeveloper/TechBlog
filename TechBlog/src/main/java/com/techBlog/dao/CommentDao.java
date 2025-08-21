package com.techBlog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.techBlog.entities.Comments;

public class CommentDao {
	Connection con;
	public CommentDao(Connection con){
		this.con=con;
	}
	public boolean insertComment(Comments comm) {
		boolean f=false;
		System.out.println("PID:"+comm.getPostId()+" UID:"+comm.getUserId());
		try {
			String q="insert into comments (PId,UId,commMessage) values (?,?,?)";
			PreparedStatement pt=con.prepareStatement(q);
			pt.setInt(1, comm.getPostId());
			pt.setInt(2, comm.getUserId());
			pt.setString(3, comm.getCommentMessage());
			pt.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public List<Comments> getCommentsByPostIdUserId(int pid) {
		List<Comments> list = new ArrayList<>();
		try {
			String q="select * from comments where PId=? ORDER BY commId DESC";
			PreparedStatement ptstmt=con.prepareStatement(q);
			ptstmt.setInt(1, pid);
			ResultSet set=ptstmt.executeQuery();
			while(set.next()) {
				Comments comm = new Comments();
				comm.setCommentId(set.getInt("commId"));
				comm.setPostId(set.getInt("PId"));
				comm.setUserId(set.getInt("UId"));
				comm.setCommentMessage(set.getString("commMessage"));
				comm.setrDate(set.getTimestamp("RDate"));
				list.add(comm);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public int countCommentOnPosts(int pid) {
		int count=0;
		try {
			String q="select count(*) from comments where PId=?";
			PreparedStatement pt=con.prepareStatement(q);
			pt.setInt(1, pid);
			ResultSet set=pt.executeQuery();
			if(set.next()) {
				count=set.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	public boolean userCommentedOrNot(int pid,int uid) {
		boolean f=false;
		try {
			String q="select * from comments where PId=? and UId=?";
			PreparedStatement pt=con.prepareStatement(q);
			pt.setInt(1, pid);
			pt.setInt(2, uid);
			ResultSet set=pt.executeQuery();
			if(set.next()) {
				f=true;
			}
		} catch (Exception e) {
		}
		return f;
	}
	public boolean deleteComment(int pid,int uid) {
		boolean f=false;
		try {
			PreparedStatement pt=con.prepareStatement("Delete from comments where PId=? and UId=?");
			pt.setInt(1, pid);
			pt.setInt(2, uid);
			pt.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}
