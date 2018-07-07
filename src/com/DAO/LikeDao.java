package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import com.Bean.*;
import com.Connection.ConnectionProvider;

public class LikeDao {

	public HashMap<String,String> voteUpDown(Like like)
	{
		HashMap<String,String> data=new HashMap<>();
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps1=con.prepareStatement("Select like_type,id from likes where lock_version<>-1 and node_id="+like.getNode_id()+" and created_by="+like.getCreated_by());
			ResultSet rs1=ps1.executeQuery();
			int like_exist_flag=0;
			int update_like_flag=0;
			String query="";
			String update_id="";
			while(rs1.next())
			{
				like_exist_flag=1;
				if(rs1.getString(1).equals(like.getLike_type()))
				{
					data.put("status", "Failure");
					data.put("reason", "You have already marked this vote");
				}
				else
				{
					update_like_flag=1;
					update_id=rs1.getString(2);
				}
			}
			if(like_exist_flag==0)
			{
				query="Insert into likes(like_type,node_id,created_by,created_at,lock_version) Values("+like.getLike_type()+","+like.getNode_id()+","+like.getCreated_by()+","+"now(),1)";
			}
			else
			{
				if(update_like_flag==1)
				{
					query="Update likes set like_type="+like.getLike_type()+" where id="+update_id;
				}
			}
			int status2=0;
			if(like_exist_flag==0 || update_like_flag==1)
			{
				PreparedStatement ps2=con.prepareStatement(query);
				status2=ps2.executeUpdate();
			}
			if(status2!=0)
			{
				data.put("status", "Success");
				PreparedStatement ps3=con.prepareStatement("Select count(*) as count from likes where lock_version<>-1 and like_type=1 and node_id="+like.getNode_id());
				ResultSet rs3=ps3.executeQuery();
				while(rs3.next())
				{
					data.put("likes_count", rs3.getString(1));
				}
				PreparedStatement ps4=con.prepareStatement("Select count(*) as count from likes where lock_version<>-1 and like_type=-1 and node_id="+like.getNode_id());
				ResultSet rs4=ps4.executeQuery();
				while(rs4.next())
				{
					data.put("dislikes_count", rs4.getString(1));
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return data;
	}
	public HashMap<String,ArrayList> getVoteList(Like like)
	{
		HashMap<String,ArrayList> data=new HashMap<>();
		ArrayList<Like> like_data=new ArrayList<>();
		ArrayList<HashMap<String,User>> users=new ArrayList<>();
		HashMap<String,User> comment_user=new HashMap<>();
		StringBuilder user_ids=new StringBuilder();
		
		//ArrayList<Blog> data_arr=new ArrayList<>();
		try{
			Connection con=ConnectionProvider.getCon();
			PreparedStatement ps=con.prepareStatement("Select id,like_type,node_id,created_by,created_at from likes where lock_version<>-1 and node_id="+like.getNode_id()+" and like_type="+like.getLike_type());
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				Like obj=new Like();
				obj.setId(rs.getString(1));
				obj.setLike_type(rs.getString(2));
				obj.setNode_id(rs.getString(3));
				obj.setCreated_by(rs.getString(4));
				obj.setCreated_at(rs.getString(5));
				like_data.add(obj);
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
			data.put("likes", like_data);
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
