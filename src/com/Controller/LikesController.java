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
 * Servlet implementation class LikesController
 */
@WebServlet("/LikesController")
public class LikesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikesController() {
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
		if("voteUpDown".equalsIgnoreCase(request.getParameter("action")))
		{
			Like like=new Like();
			like.setCreated_by(request.getParameter("user_id"));
			like.setNode_id(request.getParameter("blog_id"));
			like.setLike_type(request.getParameter("like_type"));
			HashMap<String,String> data=new HashMap<>();
			LikeService ob=new LikeService();
			data=ob.voteUpDown(like);
			String json=new Gson().toJson(data);
			System.out.println("Like Json is="+json);
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
		if("getVoteList".equalsIgnoreCase(request.getParameter("action")))
		{
			Like like=new Like();
			
			like.setNode_id(request.getParameter("blog_id"));
			like.setLike_type(request.getParameter("like_type"));
			HashMap<String,ArrayList> data=new HashMap<>();
			LikeService ob=new LikeService();
			data=ob.getVoteList(like);
			String json=new Gson().toJson(data);
			System.out.println("Like Json is="+json);
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
	}

}
