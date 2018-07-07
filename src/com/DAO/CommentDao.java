package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import com.Bean.*;
import com.Connection.ConnectionProvider;

public class CommentDao {
	public HashMap<String,String> createComment(Comment comment)
	{
		HashMap<String,String> data=new HashMap<>();
		int status=0;
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps=con.prepareStatement("INSERT INTO comments(description,blog_id,created_by,lock_version,created_at) VALUES(?,?,?,?,now())");
			ps.setString(1, comment.getDescription());
			ps.setString(2, comment.getBlog_id());
			ps.setString(3, comment.getCreated_by());
			ps.setString(4, "1");
			status=ps.executeUpdate();
			if(status==0)
			{
				data.put("status", "Failure");
			}
			else
			{
				data.put("status", "Success");
				PreparedStatement ps2=con.prepareStatement("Select count(*) as count from comments where lock_version<>-1 and blog_id="+comment.getBlog_id()); 
				ResultSet rs=ps2.executeQuery();
				while(rs.next())
				{
					data.put("comment_count", rs.getString(1));
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return data;
	}
	public HashMap<String,ArrayList> getComments(String id)
	{
		HashMap<String,ArrayList> data=new HashMap<>();
		ArrayList<Comment> comment_data=new ArrayList<>();
		ArrayList<HashMap<String,User>> users=new ArrayList<>();
		HashMap<String,User> comment_user=new HashMap<>();
		StringBuilder user_ids=new StringBuilder();
		
		//ArrayList<Blog> data_arr=new ArrayList<>();
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps=con.prepareStatement("Select id,description,blog_id,created_by,created_at from comments where lock_version<>-1 and blog_id="+id);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				Comment obj=new Comment();
				obj.setId(rs.getString(1));
				obj.setDescription(rs.getString(2));
				obj.setBlog_id(rs.getString(3));
				obj.setCreated_by(rs.getString(4));
				obj.setCreated_at(rs.getString(5));
				comment_data.add(obj);
				user_ids.append(rs.getString(4)+",");
				//System.out.println("Here1"+rs.getString(1)+rs.getString(2)+rs.getString(3)+rs.getString(4));
			}
			int comma_index=user_ids.length() ;
			user_ids.setCharAt(comma_index-1,' ');
			PreparedStatement ps2=con.prepareStatement("Select usrid,first_name,last_name,user_id,password,email_id,phoneNo,address from users where usrid in("+user_ids.toString()+")");
			ResultSet rs2=ps2.executeQuery();
			while(rs2.next())
			{
				User user=new User();
				user.setUsrid(rs2.getString(1));
				user.setFirst_name(rs2.getString(2));
				user.setLast_name(rs2.getString(3));
				user.setUser_id(rs2.getString(4));
				user.setPassword(rs2.getString(5));
				user.setEmail_id(rs2.getString(6));
				user.setPhone_no(rs2.getString(7));
				user.setAddress(rs2.getString(8));
				comment_user.put(rs2.getString(1), user);
			}
			users.add(comment_user);
			data.put("Comment", comment_data);
			data.put("Users", users);
		}
		catch(Exception e)
		{
			System.out.println("Here2"+e);
			e.printStackTrace();
		}
		return data;
	}
	
}
