package com.Connection;

public interface Provider {
	//String DRIVER="oracle.jdbc.driver.OracleDriver";
	String DRIVER="com.mysql.jdbc.Driver";
	//String URL="jdbc:oracle:thin:@localhost:1521:xe";
	String URL="jdbc:mysql://localhost/blogspot";
	//String USER="system";
	String USER="root";
	String PASSWORD="root";
}
