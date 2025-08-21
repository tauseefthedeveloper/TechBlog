package com.techBlog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.techBlog.entities.Categories;
import com.techBlog.entities.Posts;
import com.techBlog.helper.ConnectionProvider;

public class PostDao {
	Connection con;
	public ArrayList<Categories> getAllCategory() {
		ArrayList<Categories> list=new ArrayList<>();
		try {
			String q="select * from categories";
			con=ConnectionProvider.getConnection();
			PreparedStatement pstmt=con.prepareStatement(q);
			ResultSet set=pstmt.executeQuery();
			while(set.next()) {
				int cid=set.getInt("CId");
				String Name=set.getString("Name");
				String Description=set.getString("Description");
				Categories category=new Categories(cid,Name,Description);
				list.add(category);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return list;
	}
	public boolean savePosts(Posts p) {
		boolean f=false;
		try {
			String q="insert into posts(Title,Content,Code,Picture,CatId,userId) value(?,?,?,?,?,?)";
			con=ConnectionProvider.getConnection();
			PreparedStatement ptstmt=con.prepareStatement(q);
			ptstmt.setString(1, p.getTitle());
			ptstmt.setString(2, p.getContent());
			ptstmt.setString(3, p.getCode());
			ptstmt.setString(4, p.getPic());
			ptstmt.setInt(5, p.getCatId());
			ptstmt.setInt(6, p.getUserId());
			ptstmt.executeUpdate();
			f=true;

		} catch (Exception e) {
			System.out.println(e);
		}
		return f;
	}

	public List<Posts> getAllPost(){
		    List<Posts> list=new ArrayList<>();
		    try {
		    	con=ConnectionProvider.getConnection();
				PreparedStatement ptstmt=con.prepareStatement("Select * from posts order by PId desc");
				ResultSet set=ptstmt.executeQuery();
				while(set.next()) {
					int pid=set.getInt("PId");
					String title=set.getString("Title");
					String content=set.getString("Content");
					String code=set.getString("Code");
					Timestamp date=set.getTimestamp("Date");
					String pic=set.getString("Picture");
					int CId=set.getInt("CatId");
					int userId=set.getInt("userId");
					Posts p=new Posts(pid,title,content,code,date,pic,CId,userId);
					list.add(p);
				}

			} catch (Exception e) {
				System.out.println(e);
			}
			return list;
	}
	public List<Posts> getPostByCatId(int CatId){
		List<Posts> list=new ArrayList<>();
	    try {
	    	con=ConnectionProvider.getConnection();
			PreparedStatement ptstmt=con.prepareStatement("Select * from posts where CatId=? order by PId desc");
			ptstmt.setInt(1, CatId);
			ResultSet set=ptstmt.executeQuery();
			while(set.next()) {
				int pid=set.getInt("PId");
				String title=set.getString("Title");
				String content=set.getString("Content");
				String code=set.getString("Code");
				Timestamp date=set.getTimestamp("Date");
				String pic=set.getString("Picture");
				int userId=set.getInt("userId");
				Posts p=new Posts(pid,title,content,code,date,pic,CatId,userId);
				list.add(p);
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return list;
	}

	public Posts getPostByPostId(int postId) {
		Posts post=null;
		try {
			Thread.sleep(500);
			String q="select * from posts where PId=?";
			con=ConnectionProvider.getConnection();
			PreparedStatement ptstmt=con.prepareStatement(q);
			ptstmt.setInt(1, postId);
			ResultSet set=ptstmt.executeQuery();
			if(set.next()) {
				int pid=set.getInt("PId");
				String title=set.getString("Title");
				String content=set.getString("Content");
				String code=set.getString("Code");
				Timestamp date=set.getTimestamp("Date");
				String pic=set.getString("Picture");
				int catId=set.getInt("CatId");
				int userId=set.getInt("userId");
				post=new Posts(pid,title,content,code,date,pic,catId,userId);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}
}
