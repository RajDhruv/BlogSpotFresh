package com.DAO;

import java.sql.*;
import java.util.*;

import com.Bean.User;
import com.Connection.ConnectionProvider;

public class UserDao {
	public int register(User user)
	{
		int status=0;
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps=con.prepareStatement("Insert into users(first_name,last_name,user_id,password,email_id,phoneNo,address) values(?,?,?,?,?,?,?)");
			ps.setString(1, user.getFirst_name());
			ps.setString(2, user.getLast_name());
			ps.setString(3, user.getUser_id());
			ps.setString(4, user.getPassword());
			ps.setString(5, user.getEmail_id());
			ps.setString(6, user.getPhone_no());
			ps.setString(7, user.getAddress());
			status=ps.executeUpdate();
			//System.out.println("Here1"+status);
		}
		catch(Exception e)
		{
			//System.out.println("Here2"+e);
			e.printStackTrace();
		}
		return status;
	}
	public HashMap loginuser(User user)
	{
		String user_id=user.getUser_id();
		String password=user.getPassword();
		HashMap<String,String> data=new HashMap<>();
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps=con.prepareStatement("Select password,first_name,last_name,usrid from users where user_id='"+user_id+"'");
			ResultSet rs=ps.executeQuery();
			if(rs.isBeforeFirst()){
			 while(rs.next())
			{
				String pwd=rs.getString(1);
				System.out.println(pwd+"  "+password);
				if(password.equals(pwd))
				{
					String first_name=rs.getString(2);
					String last_name=rs.getString(3);
					String name=first_name+" "+last_name;
					data.put("status","Success");
					data.put("user_name", name);
					data.put("usrid", rs.getString(4));
				}
				else
				{
					data.put("status","Incorrect Password");
				}
			}
			}
			else
			{
				data.put("status","User Not Found");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return data;
	}
	public int unique_user(User user)
	{
		int status=0;
		try{
			Connection con=ConnectionProvider.getCon();
			System.out.println(user.getUser_id());
			PreparedStatement ps=con.prepareStatement("Select * from users where user_id='"+user.getUser_id()+"'");
			//String query="Select * from users where user_id='"+user.getUser_id()+"'";
			//Statement stmt=con.createStatement();
			//ResultSet rs=stmt.executeQuery(query);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				System.out.println("Its here");
				status=1;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	public User getProfile(String usrid)
	{
		User user=new User();
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps=con.prepareStatement("Select usrid,first_name,last_name,user_id,password,email_id,phoneNo,address from users where usrid="+usrid);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				user.setUsrid(rs.getString(1));
				user.setFirst_name(rs.getString(2));
				user.setLast_name(rs.getString(3));
				user.setUser_id(rs.getString(4));
				user.setPassword(rs.getString(5));
				user.setEmail_id(rs.getString(6));
				user.setPhone_no(rs.getString(7));
				user.setAddress(rs.getString(8));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return user;
	}
	public int update(User user)
	{
		int status=0;
		try{
			Connection con=ConnectionProvider.getCon();
			StringBuilder query=new StringBuilder();
			if(!(user.getFirst_name().isEmpty()))
			{
				query.append("first_name='"+user.getFirst_name()+"'");
			}
			if(!(user.getLast_name().isEmpty()))
			{
				query.append(",last_name='"+user.getLast_name()+"'");
			}
			if(!(user.getUser_id().isEmpty()))
			{
				query.append(",user_id='"+user.getUser_id()+"'");
			}
			if(!(user.getPassword().isEmpty()))
			{
				query.append(",password='"+user.getPassword()+"'");
			}
			if(!(user.getEmail_id().isEmpty()))
			{
				query.append(",email_id='"+user.getEmail_id()+"'");
			}
			if(!(user.getPhone_no().isEmpty()))
			{
				query.append(",phoneNo='"+user.getPhone_no()+"'");
			}
			if(!(user.getAddress().isEmpty()))
			{
				query.append(",address='"+user.getAddress()+"'");
			}
			if(query.charAt(0)==',')
			{
				query.deleteCharAt(0);
			}
			StringBuilder final_query=new StringBuilder();
			final_query.append("Update users set ");
			final_query.append(query);
			final_query.append("where usrid="+user.getUsrid());
			System.out.println(final_query);
			PreparedStatement ps=con.prepareStatement(final_query.toString());
			status=ps.executeUpdate();
			//System.out.println("Here1"+status);
		}
		catch(Exception e)
		{
			//System.out.println("Here2"+e);
			e.printStackTrace();
		}
		System.out.println(status);
		return status;
	}
}
