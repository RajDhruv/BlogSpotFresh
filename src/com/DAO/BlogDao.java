package com.DAO;
import java.io.*;
import java.sql.*;
import java.util.*;
import com.Bean.*;
import com.Connection.ConnectionProvider;

public class BlogDao {

	public HashMap<String,ArrayList> myBlogs(User user)
	{
		HashMap<String,ArrayList> data=new HashMap<>();
		ArrayList<Blog> blog_data=new ArrayList<>();
		ArrayList<HashMap<String,User>> users=new ArrayList<>();
		HashMap<String,User> blog_user=new HashMap<>();
		
		//ArrayList<Blog> data_arr=new ArrayList<>();
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps=con.prepareStatement("Select id,title,description,created_by,created_at from blogs where lock_version<>-1 and created_by='"+user.getUsrid()+"'");
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				Blog obj=new Blog();
				obj.setId(rs.getString(1));
				obj.setTitle(rs.getString(2));
				obj.setDescription(rs.getString(3));
				obj.setCreated_by(rs.getString(4));
				obj.setCreated_at(rs.getString(5));
				blog_data.add(obj);
				System.out.println("Here1"+rs.getString(1)+rs.getString(2)+rs.getString(3)+rs.getString(4));
			}
			PreparedStatement ps2=con.prepareStatement("Select usrid,first_name,last_name,user_id,password,email_id,phoneNo,address from users where usrid="+user.getUsrid());
			ResultSet rs2=ps2.executeQuery();
			while(rs2.next())
			{
				user.setUsrid(rs2.getString(1));
				user.setFirst_name(rs2.getString(2));
				user.setLast_name(rs2.getString(3));
				user.setUser_id(rs2.getString(4));
				user.setPassword(rs2.getString(5));
				user.setEmail_id(rs2.getString(6));
				user.setPhone_no(rs2.getString(7));
				user.setAddress(rs2.getString(8));
			}
			blog_user.put(user.getUsrid(), user);
			users.add(blog_user);
			data.put("Blog", blog_data);
			data.put("Users", users);
		}
		catch(Exception e)
		{
			System.out.println("Here2"+e);
			e.printStackTrace();
		}
		return data;
	}
	public int newBlog(Blog blog)
	{
		int status=0;
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps=con.prepareStatement("INSERT INTO blogs(title,description,created_by,created_at) VALUES(?,?,?,now())");
			ps.setString(1, blog.getTitle());
			ps.setString(2, blog.getDescription());
			ps.setString(3, blog.getCreated_by());
			status=ps.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	public HashMap<String,ArrayList> getAllBlogs()
	{	
		HashMap<String,ArrayList> data=new HashMap<>();
		ArrayList<Blog> blog_data=new ArrayList<>();
		ArrayList<HashMap<String,User>> users=new ArrayList<>();
		HashMap<String,User> blog_user=new HashMap<>();
		StringBuilder user_ids=new StringBuilder();
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps=con.prepareStatement("SELECT id,title,description,created_by,created_at from blogs where lock_version<>-1");
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
			Blog obj=new Blog();
			obj.setId(rs.getString(1));
			obj.setTitle(rs.getString(2));
			obj.setDescription(rs.getString(3));
			obj.setCreated_by(rs.getString(4));
			obj.setCreated_at(rs.getString(5));
			blog_data.add(obj);
			user_ids.append(rs.getString(4)+",");
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
				blog_user.put(rs2.getString(1), user);
			}
			users.add(blog_user);
			data.put("Blog", blog_data);
			data.put("Users", users);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return data;
	}
	public int editBlog(Blog blog)
	{
		int status=0;
		try{
			Connection con=ConnectionProvider.getCon();
			StringBuilder query=new StringBuilder();
			query.append("Update blogs Set ");
			StringBuilder query_cond=new StringBuilder();
			query_cond.append("updated_at=now(),");
			if(!(blog.getTitle().isEmpty()))
			{
				query_cond.append("title='"+blog.getTitle()+"',");
			}
			if(!(blog.getDescription().isEmpty()))
			{
				query_cond.append("description='"+blog.getDescription()+"',");
			}
			int length=query_cond.length();
			query_cond.setCharAt(length-1, ' ');
			query.append(query_cond);
			query.append(" where id="+blog.getId());
			PreparedStatement ps=con.prepareStatement(query.toString());
			status=ps.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	public int deleteBlog(String id)
	{
		int status=0;
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps=con.prepareStatement("Update blogs set lock_version=-1 where id="+id);
			System.out.println(ps.toString());
			status=ps.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	public HashMap<String,String> getBlogPopularityData(String id)
	{
		HashMap<String,String> data=new HashMap<>();
		try
		{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps1=con.prepareStatement("Select count(*) as count from comments where lock_version<>-1 and blog_id="+id);
			ResultSet rs1=ps1.executeQuery();
			while(rs1.next())
			{
				data.put("comment_count", rs1.getString(1));
			}
			PreparedStatement ps2=con.prepareStatement("Select count(*)as count from likes where lock_version<>-1 and like_type=1 and node_id="+id);
			ResultSet rs2=ps2.executeQuery();
			while(rs2.next())
			{
				data.put("likes_count", rs2.getString(1));
			}
			PreparedStatement ps3=con.prepareStatement("Select count(*)as count from likes where lock_version<>-1 and like_type=-1 and node_id="+id);
			ResultSet rs3=ps3.executeQuery();
			while(rs3.next())
			{
				data.put("dislikes_count", rs3.getString(1));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return data;
	}
}
