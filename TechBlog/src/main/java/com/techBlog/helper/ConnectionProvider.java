package com.techBlog.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
	private static Connection con;
	public static Connection getConnection() {
		try {
			if(con==null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				//con=DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog","root","tauseef@123");
				con=DriverManager.getConnection("jdbc:mysql://shuttle.proxy.rlwy.net:57034/railway?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC","root","HHHKxVraMEfhejiMEecIxTbHBIXNAfOY");
			}else {
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return con;
	}
}
