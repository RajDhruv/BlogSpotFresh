package com.Controller;

import java.io.*;
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
 * Servlet implementation class CommentsController
 */
@WebServlet("/CommentsController")
public class CommentsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentsController() {
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
		if("submit_comment".equalsIgnoreCase(request.getParameter("action")))
		{
			
			Comment comment=new Comment();
			comment.setBlog_id(request.getParameter("blog_id"));
			comment.setCreated_by(request.getParameter("user_id"));
			comment.setDescription(request.getParameter("description"));
			CommentService ob=new CommentService();
			//String data="";
			HashMap<String,String> data=new HashMap<>();
			data=ob.createComment(comment);
			String json=new Gson().toJson(data);
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
		if("getCommentList".equalsIgnoreCase(request.getParameter("action")))
		{
			String id=request.getParameter("id");
			HashMap<String,ArrayList> data_arr=new HashMap<>();
			CommentService ob=new CommentService();
			data_arr=ob.getComments(id);
			String json= new Gson().toJson(data_arr);
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
	}

}
