package com.Controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Bean.*;
import com.Service.*;
import com.google.gson.Gson;

/**
 * Servlet implementation class BlogsController
 */
@WebServlet("/BlogsController")
public class BlogsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BlogsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if("my_workspace".equalsIgnoreCase(request.getParameter("action")))
		{
			String usrId=request.getParameter("usrid");
			User user=new User();
			user.setUsrid(usrId);
			HashMap<String,ArrayList> data_arr=new HashMap<>();
			BlogService ob=new BlogService();
			data_arr=ob.myBlogs(user);
			System.out.println("Here3 "+data_arr.toString());
			String json= new Gson().toJson(data_arr);
			System.out.println("Json is "+json);
			System.out.println("My Json is="+json);
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			
		}
		if("newBlog".equalsIgnoreCase(request.getParameter("action")))
		{
			Blog blog=new Blog();
			String title=request.getParameter("blogTitle");
			String desc=request.getParameter("blogDescription");
			String usrid=request.getParameter("usrid");
			blog.setTitle(title);
			blog.setDescription(desc);
			blog.setCreated_by(usrid);
			int status=0;
			BlogService ob=new BlogService();
			status=ob.newBlog(blog);
			String data="";
			if(status==0)
			{
				data="Failure";
			}
			else
			{
				data="Success";
			}
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(data);
		}
		if("home_page".equalsIgnoreCase(request.getParameter("action")))
		{
			HashMap<String,ArrayList> data=new HashMap<>();
			BlogService ob=new BlogService();
			data=ob.getAllBlogs();
			String json= new Gson().toJson(data);
			System.out.println("Home Json is="+json);
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
		if("editBlog".equalsIgnoreCase(request.getParameter("action")))
		{
			Blog blog=new Blog();
			blog.setId(request.getParameter("blogId"));
			blog.setTitle(request.getParameter("blogTitle"));
			blog.setDescription(request.getParameter("blogDescription"));
			BlogService ob=new BlogService();
			int status=0;
			status=ob.editBlog(blog);
			String data="";
			if(status==0)
			{
				data="Failure";
			}
			else
			{
				data="Success";
			}
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(data);
		}
		if("deleteBlog".equalsIgnoreCase(request.getParameter("action")))
		{
			String id=request.getParameter("blogId");
			int status=0;
			BlogService ob=new BlogService();
			status=ob.deleteBlog(id);
			String data="";
			System.out.println("Its Here");
			if(status==0)
			{
				data="Failure";
			}
			else
			{
				data="Success";
			}
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(data);
		}
		if("blogPopularityCount".equalsIgnoreCase(request.getParameter("action")))
		{
			String id=request.getParameter("id");
			HashMap<String,String> data=new HashMap<>();
			BlogService ob=new BlogService();
			data=ob.getBlogPopularityData(id);
			String json=new Gson().toJson(data);
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/plain");
			response.getWriter().write(json);
		}
	}

}
