package com.Service;

import java.util.*;

import com.Bean.*;
import com.DAO.*;

public class CommentService {

	public HashMap<String,String> createComment(Comment comment)
	{
		CommentDao ob=new CommentDao();
		return ob.createComment(comment);
	}
	public HashMap<String,ArrayList> getComments(String id)
	{
		CommentDao ob=new CommentDao();
		return ob.getComments(id);
	}
}
