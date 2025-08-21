package com.techBlog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.techBlog.entities.User;
import com.techBlog.helper.ConnectionProvider;

public class UserDao {
	private Connection con;
	public UserDao(Connection con) {
		this.con=con;
	}

	public boolean InsertUser(User user) {
		boolean f=false;
		try {
			String q="insert into users(Name,Email,Password,Gender,About) value(?,?,?,?,?)";
			PreparedStatement pstmt=this.con.prepareStatement(q);
			pstmt.setString(1, user.getName());
			pstmt.setString(2,user.getEmail());
			pstmt.setString(3,user.getPassword());
			pstmt.setString(4,user.getGender());
			pstmt.setString(5,user.getAbout());
			pstmt.executeUpdate();
			f=true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return f;
	}

	//get user by email and password
	public User getUserByEmailAndPassword(String Email,String password) {
		User user=null;
		try {
			String q="select * from users where Email=? and Password=?";
			PreparedStatement ptstmt=con.prepareStatement(q);
			ptstmt.setString(1, Email);
			ptstmt.setString(2, password);
			ResultSet set=ptstmt.executeQuery();
			if(set.next()) {
				user=new User();
				String userName=set.getString("Name");
				user.setName(userName);
				user.setId(set.getInt("ID"));
				user.setEmail(set.getString("Email"));
				user.setPassword(set.getString("Password"));
				user.setGender(set.getString("Gender"));
				user.setAbout(set.getString("About"));
				user.setDateTime(set.getTimestamp("RDate"));
				user.setProfile(set.getString("Profile"));
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return user;
	}
	public boolean updateUser(User user) {
		boolean f=false;
		try {
			String q="update users set Name=?, Email=?, Password=?, About=?, Profile=? where ID=?";
			PreparedStatement ptstmt=con.prepareStatement(q);
			ptstmt.setString(1, user.getName());
			ptstmt.setString(2, user.getEmail());
			ptstmt.setString(3, user.getPassword());
			ptstmt.setString(4, user.getAbout());
			ptstmt.setString(5, user.getProfile());
			ptstmt.setInt(6, user.getId());
			ptstmt.executeUpdate();
			f=true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return f;
	}

	public User getUserByUserId(int userId) {
		User user=null;
		try {
			String q="Select * from users where Id=?";
			con=ConnectionProvider.getConnection();
			PreparedStatement ptstmt=con.prepareStatement(q);
			ptstmt.setInt(1, userId);
			ResultSet set=ptstmt.executeQuery();
			if(set.next()) {
				user=new User();
				String userName=set.getString("Name");
				user.setName(userName);
				user.setId(set.getInt("ID"));
				user.setEmail(set.getString("Email"));
				user.setPassword(set.getString("Password"));
				user.setGender(set.getString("Gender"));
				user.setAbout(set.getString("About"));
				user.setDateTime(set.getTimestamp("RDate"));
				user.setProfile(set.getString("Profile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
}
