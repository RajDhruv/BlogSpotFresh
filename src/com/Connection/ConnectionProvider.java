package com.Connection;
import java.sql.*;

import static com.Connection.Provider.*;

public class ConnectionProvider {
	private static Connection con=null;
	static{
		try{
			Class.forName(DRIVER);
			con=DriverManager.getConnection(URL, USER, PASSWORD);
			System.out.println("connected");
		}
		catch(Exception e){
			System.out.println("Leo LAgg Gai");
			e.printStackTrace();
		}
	}
	public static Connection getCon()
	{
		return con;
	}
}
