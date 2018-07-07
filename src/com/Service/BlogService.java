package com.Service;

import java.util.*;

import com.Bean.*;
import com.DAO.*;

public class BlogService {

	public HashMap<String,ArrayList> myBlogs(User user)
	{
		BlogDao ob=new BlogDao();
		return ob.myBlogs(user);
	}
	public int newBlog(Blog blog)
	{
		BlogDao ob=new BlogDao();
		return ob.newBlog(blog);
	}
	public HashMap<String,ArrayList> getAllBlogs()
	{
		BlogDao ob=new BlogDao();
		return ob.getAllBlogs();
	}
	public int editBlog(Blog blog)
	{
		BlogDao ob=new BlogDao();
		return ob.editBlog(blog);
	}
	public int deleteBlog(String id)
	{
		BlogDao ob=new BlogDao();
		return ob.deleteBlog(id);
	}
	public HashMap<String,String> getBlogPopularityData(String id)
	{
		BlogDao ob=new BlogDao();
		return ob.getBlogPopularityData(id);
	}
}
