package com.Service;

import java.util.*;

import com.Bean.*;
import com.DAO.*;

public class LikeService {

	public HashMap<String,String> voteUpDown(Like like)
	{
		LikeDao ob=new LikeDao();
		return ob.voteUpDown(like);
	}
	public HashMap<String,ArrayList> getVoteList(Like like)
	{
		LikeDao ob=new LikeDao();
		return ob.getVoteList(like);
	}
}
