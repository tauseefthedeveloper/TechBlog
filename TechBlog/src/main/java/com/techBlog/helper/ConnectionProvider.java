package com.techBlog.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {
	private static Connection con;
	public static Connection getConnection() {
		try {
			if(con==null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection(
    "jdbc:mysql://mysql-techblog.alwaysdata.net:3306/techblog_db",
    "techblog",
    "Tauseef@123"
);

			}else {
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		return con;
	}
}
