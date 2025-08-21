package com.techBlog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	Connection con;
	public LikeDao(Connection con){
		this.con=con;
	}
	public boolean insertLike(int pid,int uid) {
		boolean f=false;
		try {
			String q="insert into likes (PId,UId) values (?,?)";
			PreparedStatement pt=con.prepareStatement(q);
			pt.setInt(1, pid);
			pt.setInt(2, uid);
			pt.executeUpdate();
			f=true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public int countLikesOnPosts(int pid) {
		int count=0;
		try {
			String q="select count(*) from likes where PId=?";
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
	public boolean userLikedOrNot(int pid,int uid) {
		boolean f=false;
		try {
			String q="select * from likes where PId=? and UId=?";
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
	public boolean deleteLike(int pid,int uid) {
		boolean f=false;
		try {
			PreparedStatement pt=con.prepareStatement("Delete from likes where PId=? and UId=?");
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
