<jsp:include page="jqueryCombined.jsp"></jsp:include>
<style>
.button {
    background-color: #555555; /* Green */
    border: none;
    color: white;
    padding: 12px;
    height:60px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border-radius: 12px;
}
.button:hover{
   box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);transition-duration: 0.4s; 
}
#blogListTable{
    margin-left: 0%;
    margin-top: 30px;
    height: 450px;
    overflow-y: scroll;
    display: inline-block;
    width: 55%;
}

#blogListTable::-webkit-scrollbar {
    width: 20px;
    background-color:black;
    border-radius:10px;
}

/* Track */
#blogListTable::-webkit-scrollbar-track {
    box-shadow: inset 0 0 5px grey; 
    border-radius: 10px;
}
 
/* Handle */
#blogListTable::-webkit-scrollbar-thumb {
    background: grey; 
    border-radius: 10px;
}

/* Handle on hover */
#blogListTable::-webkit-scrollbar-thumb:hover {
    background: #b30000; 
}

.comment_list::-webkit-scrollbar {
    width: 20px;
    background-color:black;
    border-radius:10px;
}

/* Track */
.comment_list::-webkit-scrollbar-track {
    box-shadow: inset 0 0 5px grey; 
    border-radius: 10px;
}
 
/* Handle */
.comment_list::-webkit-scrollbar-thumb {
    background: grey; 
    border-radius: 10px;
}

/* Handle on hover */
.comment_list::-webkit-scrollbar-thumb:hover {
    background: #b30000; 
}
#controlPanel img{
height:22px;
padding-right:6.5px;
padding-left:6.5px;
cursor:pointer;
}
</style>
<%String current_user_id=(String) session.getAttribute("current_user_id");
String current_user_name=(String) session.getAttribute("current_user_name");%>


<div id="home_content" style="background:url(./images/background_wall.png);background-repeat: no-repeat;background-size: 100% 140%;width:100%;height:550px;margin-top:0px;background-position:0px -100px;"></div>


<div class="modal fade" id="myModal-home" tabindex="-1" role="dialog">
<div class="modal-dialog">
 <div class="modal-content" id="home-modal-content">
        <div class="modal-header" id="home-modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" id="home-modal-title">Modal Header</h4>
        </div>
		<div class="modal-body" id="home-modalContainer">
		</div>
		<div class="modal-footer" id="home-modal-footer">
		<label class="btn btn-default  modal-submit" id="home-modal_submit" onclick="$('.home_submit_form').click();">Submit</label>
          <button type="button" id="home_modal_close" class="btn btn-default modal-cancel" data-dismiss="modal" >Cancel</button>
        </div>
</div>
</div>
</div>

<div class="modal fade" id="myModal-view" tabindex="-1" role="dialog">
<div class="modal-dialog">
 <div class="modal-content" id="view-modal-content">
        <div class="modal-header" id="view-modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" id="view-modal-title">Modal Header</h4>
        </div>
		<div class="modal-body" id="view-modalContainer">
		</div>
		<div class="modal-footer" id="view-modal-footer">
          <button type="button" id="view_modal_close" class="btn btn-default modal-cancel" data-dismiss="modal" >Close</button>
        </div>
</div>
</div>
</div>

<script type="text/javascript">
$('#logout_user').on('click',function(){
	$.ajax({
		type:"POST",
		url:"UserController",
		data:"action=logout",
		dataType:"text",
		success: function( data, textStatus, jqXHR) {
       	 //alert(data);
            if(data.toLowerCase()=="success")
           	 {
           $('#centercol').load("success_logout.jsp");
           $('#sub_header').html("");
           $('#user_attr').html("");
           	 }
            else
				{
            alert("Error Occured");
            }
		}
	});
})
</script>
<script>
$('#workspace_link').on('click',function(){
	var current_usrid=$('#enter_val').val();
	var dataString="action=my_workspace&usrid="+current_usrid;
	$.ajax({
		type:"POST",
		url:"BlogsController",
		data:dataString,
		dataType:"json",
		success: function(data, textStatus, jqXHR){
			$("#home_content").html("<center><div id='newBlog'><button class='button' id='new_blog' data-toggle='modal' data-target='#myModal-home' onclick='setModal();' style='margin-left:-45%;margin-top:42px;margin-bottom:-25px;'><img src='./images/inkpot.png' height='40'> New Blog</button></div></center>");
			if(data=="")
				{
					$("#home_content").append("No Blogs Created Yet!");
				}
			else
				{
					generateBlogListing(data,'workspace');
				}
		}
	})
});
</script>
<script>
$("#home_link").on('click',function(){
	var dataString="action=home_page";
	$.ajax({
	type:"POST",
	url:"BlogsController",
	data:dataString,
	dataType:"json",
	success:function(data, textStatus, jqXHR)
	{
		if(data=="")
			{
				$('#home_content').html("No Blogs Available to Display!");
			}
		else
			{
			$('#home_content').html(''); 	
			generateBlogListing(data,'home');
			}
	}
	})
})
</script>

<script>
function generateBlogListing(data,from)
{	months=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
	var blog_data=data.Blog;
	var user_data=data.Users[0];
	var listingStruct="<center><div><br><table id='blogListTable' >";
	for(i=0;i<blog_data.length;i++)
		{	
			date=new Date(blog_data[i].created_at);
			var minutes_show=date.getMinutes();
			if(minutes_show/10<1)
				{
				minutes_show="0"+minutes_show;
				}
			else if(minutes_show/10==0)
				{
				minutes_show="00";
				}
			blog_created_at=months[date.getMonth()]+" "+date.getDate()+", "+date.getFullYear()+" @ "+date.getHours()+":"+minutes_show;
			listingStruct=listingStruct+"<tr id='"+blog_data[i].id+"'>";
			listingStruct=listingStruct+"<td id='blogTitle' style='float:left;width:50%;' data-toggle='modal' data-target='#myModal-view' onclick='viewFullBlog("+'"'+blog_data[i].id+'","'+blog_data[i].title+'","'+blog_data[i].description+'","'+blog_created_at+'","'+user_data[blog_data[i].created_by].first_name+'","'+blog_data[i].created_by+'"'+");' ><h4 style='cursor:pointer;color:black;text-shadow: 2px 2px grey;'><b>"+blog_data[i].title+"</b></h4></td>";
			if(from=='workspace')
			{
				listingStruct=listingStruct+"<td id='controlPanel' style='float:left;width:50%;padding-top:10px;'><img src='./images/edit_icon.png' title='Edit Blog' onclick='editBlog("+'"'+blog_data[i].id+'","'+blog_data[i].title+'","'+blog_data[i].description+'"'+");' alt='Edit Blog' data-toggle='modal' data-target='#myModal-home'><img src='./images/delete_button.png' onclick='getDeleteBlogModal("+'"'+blog_data[i].id+'","'+blog_data[i].title+'"'+");' title='Delete Blog' alt='Delete Blog' data-toggle='modal' data-target='#myModal-home'></td>";
			}
			listingStruct=listingStruct+"<td id='blogCreatedBy' style='float:left;width:100%;'><lable style='color:black;'> <i>by&nbsp;&nbsp;</i> <b data-toggle='modal' data-target='#myModal-view' onclick='viewModalSetUp();getUserProfile("+blog_data[i].created_by+");' style='cursor:pointer;color:cyan;text-shadow: 2px 2px chocolate;'>"+user_data[blog_data[i].created_by].first_name+"</b></label></td>";
			listingStruct=listingStruct+"<td id='blogCreatedAt' style='float:left;width:100%;'><lable style='color:grey;'><b>"+blog_created_at+"</b></label></td>";
			listingStruct=listingStruct+"<td id='blogDescription' style='float:left;width:100%;padding-bottom:1em;'><span style='color:beige;'><i>'"+blog_data[i].description+"'</i></span></td>";
			listingStruct=listingStruct+"</tr>";
		}
	listingStruct=listingStruct+"</table></div></center>";
	$("#home_content").append(listingStruct);
	if(from=='workspace')
		{
		$('#blogListTable').css('height','370px');
		}
	else
		{
		$('#blogListTable').css('height','450px');
		}

}
</script>
<script>
function setModal(){
	
	$('#home-modal-title').html("<h2>Create New Blog</h2>");
	$('#home-modalContainer').load("newBlog.jsp");
	$('#home-modal_submit').html("Create");
}
function viewModalSetUp()
{
	$('#view-modal-title').html('<h2>User Details</h2>');
}
</script>
<script>
function editBlog(id,title,description)
{	$('#home-modal-title').html("Edit <span style='color:cyan;'><b><i>"+title+"</i></b></span>");
	$("#home-modalContainer").html("");
	$('#home-modal_submit').html("Update");
	var editForm="<form id='editBlogForm'>";
	editForm=editForm+"<input type='hidden' name='action' value='editBlog'></input>";
	editForm=editForm+"<input type='hidden' name='blogId' value='"+id+"'></input>";
	editForm=editForm+"<label>Title:</label></br><input type='text' id='blogTitle' name ='blogTitle' placeholder='Enter Title.' value='"+title+"' style='width:90%;border-radius:7px;'></br></br></br>";
	editForm=editForm+"<label>Description:</label></br><textarea id='blogDescription' name='blogDescription' placeholder='Enter Description.' style='width:90%;border-radius:5px;'>"+description+"</textarea>";
	editForm=editForm+"<input type='button' class='home_submit_form' name='editBlogSubmit' id='editBlogSubmit' onclick='editBlogFunc();' style='display:none;'></input>";
	editForm=editForm+"</form>";
	$("#home-modalContainer").append(editForm);
}
</script>
<script>
$('#profile').on('click',function(){
	var current_usrid=$('#enter_val').val();
	var dataString="action=getProfile&usrid="+current_usrid;
	$.ajax({
		type:"POST",
		url:"UserController",
		data:dataString,
		dataType:"json",
		success: function(data, textStatus, jqXHR)
		{
			getProfilePage(data,'home_content');
			var update_button="<center><button class='button' id='change_profile_data' data-toggle='modal' data-target='#myModal-home' onclick='generateProfileModal();' style='margin-left:-45%;margin-top:10px;'>Update Details</button></center>";
			$("#home_content").append(update_button);
		}
	})
})
</script>
<script>
function getUserProfile(user_id){
	var dataString="action=getProfile&usrid="+user_id;
	var current_usrid=$('#enter_val').val();
	$.ajax({
		type:"POST",
		url:"UserController",
		data:dataString,
		dataType:"json",
		success: function(data, textStatus, jqXHR)
		{
			getProfilePage(data,'view-modalContainer');
		}
	})
}
</script>
<script>
function getProfilePage(data,from)
{	
	style='';
	if(from=='home_content')
		{
			style='margin-top:45px;margin-left:24%;';
		}
	var listingData="<center><div><br><table id='UserProfileData' style='display:block;"+style+"'>";
	listingData=listingData+"<tr><td><b>First Name</b></td><td style='color:#29807c;'><b>&nbsp; :~> &nbsp;</b></td><td style='text-shadow:grey 2px 2px;'>"+data.first_name+"</td></tr>";
	listingData=listingData+"<tr><td><b>Last Name</b></td><td style='color:#29807c;'><b>&nbsp; :~> &nbsp;</b></td><td style='text-shadow:grey 2px 2px;'>"+data.last_name+"</td></tr>";
	listingData=listingData+"<tr><td><b>User ID</b></td><td style='color:#29807c;'><b>&nbsp; :~> &nbsp;</b></td><td style='text-shadow:grey 2px 2px;'>"+data.user_id+"</td></tr>";
	listingData=listingData+"<tr><td><b>Password</b></td><td style='color:#29807c;'><b>&nbsp; :~> &nbsp;</b></td><td style='text-shadow:grey 2px 2px;'>"+"******"+"</td></tr>";
	listingData=listingData+"<tr><td><b>Email ID</b></td><td style='color:#29807c;'><b>&nbsp; :~> &nbsp;</b></td><td style='text-shadow:grey 2px 2px;'>"+data.email_id+"</td></tr>";
	listingData=listingData+"<tr><td><b>Phone No'</b></td><td style='color:#29807c;'><b>&nbsp; :~> &nbsp;</b></td><td style='text-shadow:grey 2px 2px;'>"+data.phone_no+"</td></tr>";
	listingData=listingData+"<tr><td><b>Address</b></td><td style='color:#29807c;'><b>&nbsp; :~> &nbsp;</b></td><td style='text-shadow:grey 2px 2px;'>"+data.address+"</td></tr>";
	listingData=listingData+"</table></div</center>";
	$("#"+from).html(listingData);	
}
</script>
<script>
function generateProfileModal()
{	
	$('#home-modal-title').html("<h2>Update Your Profile</h2>");
	$('#home-modalContainer').load("updateProfile.jsp");
	$('#home-modal_submit').html("Update");
}
</script>
<script>
function editBlogFunc(){
	var dataString=$('#editBlogForm').serialize();
	$.ajax({
		type:"POST",
		url:"BlogsController",
		data:dataString,
		dataType:"text",
		success:function(data, textStatus, jqXHR){
			if(data.toLowerCase()=="success")
				{
					alert("Blog Updated Successfully");
					$('#home_modal_close').click();
					$('#workspace_link').click();
					
				}
			else{
					alert("Error in Blog Updation");
				}
		}
	})
}
</script>
<script>
function getDeleteBlogModal(id,title)
{
	$("#home-modalContainer").html("");
	$('#home-modal-title').html("<h2>Delete <span style='color:cyan;'>"+title+"</span></h2>");
	$('#home-modal_submit').html("Delete");
	var deleteForm="";
	deleteForm=deleteForm+"<form id='deleteBlogForm'>";
	deleteForm=deleteForm+"<input type='hidden' name='action' value='deleteBlog'></input>"
	deleteForm=deleteForm+"<h4>Are You Sure You Want To <span style='color:red;'>Delete</span> <span style='color:cyan;'>"+title+"</span> Blog?</h4>";
	deleteForm=deleteForm+"<input type='hidden' name='blogId' id='blogId' value='"+id+"'></input>";
	deleteForm=deleteForm+"<input type='button' class='home_submit_form' name='deleteBlogSubmit' id='deleteBlogSubmit' onclick='deleteBlogFunc();' style='display:none;'></input>";
	deleteForm=deleteForm+"</form>";
	$("#home-modalContainer").append(deleteForm);
}
function deleteBlogFunc()
{
 	var dataString=$('#deleteBlogForm').serialize();

 	$.ajax({
 		type:"POST",
 		url:"BlogsController",
 		data:dataString,
 		dataType:'text',
 		success:function(data, textStatus, jqXHR)
 		{
 			if(data.toLowerCase()=="success")
 				{
 					alert("Blog Deleted Successfully");
 					$('#home_modal_close').click();
					$('#workspace_link').click();
 				}
 			else
 				{
 					alert("Error in Blog Deletion");
 				}
 		}
 	})
}
</script>
<script>
function viewFullBlog(id,title,description,created_at,created_by)
{
	$('#view-modal-title').html('<h3 style="color:white">'+title+'</h3>');
	$("#view-modalContainer").html("");
	var listingStruct="<div><br><table id='blogListTable_Modal' >";
	listingStruct=listingStruct+"<tr id='"+id+"'>";
	listingStruct=listingStruct+"<td id='blogTitle' style='float:left;width:50%;' ><h4 style='color:beige;text-shadow: 2px 2px grey;'><b>"+title+"</b></h4></td>";
	listingStruct=listingStruct+"<td id='blogCreatedBy' style='float:left;width:100%;'><lable style='color:white;'> <i>by&nbsp;&nbsp;</i> <b style='color:cyan;text-shadow: 2px 2px chocolate;'>"+created_by+"</b></label></td>";
	listingStruct=listingStruct+"<td id='blogCreatedAt' style='float:left;width:100%;'><lable style='color:grey;'><b>"+created_at+"</b></label></td>";
	listingStruct=listingStruct+"<td id='blogDescription' style='float:left;width:100%;padding-bottom:1em;'><span style='color:beige;'><i>'"+description+"'</i></span></td>";
	listingStruct=listingStruct+"</tr>";
	listingStruct=listingStruct+"</table></div>";
	listingStruct=listingStruct+"<div id='blog_actions_"+id+"'><span id='like_count_"+id+"' style='color:skyblue;cursor:pointer;' onclick='getVoteList("+id+",1"+")'>0</span>&nbsp;<img src='./images/like.png' height='25' width='25' title='Like' alt='Like' style='cursor:pointer;' onclick='voteUpDown("+"1,"+id+");'>&nbsp;&nbsp;&nbsp;<span id='dislike_count_"+id+"' style='color:skyblue;cursor:pointer;' onclick='getVoteList("+id+",-1"+")'>0</span>&nbsp;<img src='./images/dislike.png' height='25' width='25'  title='Dislike' alt='Dislike' style='cursor:pointer;' onclick='voteUpDown("+"-1,"+id+");'>&nbsp;&nbsp;&nbsp;<span id='comment_count_"+id+"' style='color:skyblue;cursor:pointer' title='Show Comments' onclick='getCommentList("+id+","+'"showComments"'+")'>0</span>&nbsp;<img src='./images/comments.png' height='25' width='25'  title='Comment' alt='Comment' style='cursor:pointer;'  onclick='generateCommentBox("+id+");'></div>";
	listingStruct=listingStruct+"<div id='vote_list_area_"+id+"' style='display:none;'></div>";
	listingStruct=listingStruct+"<div id='comment_box_area_"+id+"' style='display:none;'></div>";
	listingStruct=listingStruct+"<div class='comment_list' id='comment_list_"+id+"' style='display:none;max-height:250px;overflow-y:scroll;'></div>";
	$("#view-modalContainer").append(listingStruct);
	getBlogPopularityData(id);
}
</script>
<script>
function voteUpDown(like_type,blog_id)
{
	var current_user=$('#enter_val').val();
	var dataString="action=voteUpDown&like_type="+like_type+"&blog_id="+blog_id+"&user_id="+current_user;
	$.ajax({
		type:"POST",
		url:"LikesController",
		data:dataString,
		dataType:"json",
		success:function(data, textStatus, jqXHR)
		{
			if(data.status.toLowerCase()=="failure")
				{
				alert(data.reason);
				}
			else
				{
				$("#like_count_"+blog_id).html(data.likes_count);
				$("#dislike_count_"+blog_id).html(data.dislikes_count);
				}
		}
	})
}
</script>
<script>
function getBlogPopularityData(id){
	var dataString="action=blogPopularityCount&id="+id;
	$.ajax({
		type:"POST",
		url:"BlogsController",
		data:dataString,
		dataType:"json",
		success:function(data, textStatus, jqXHR)
		{
			if(data.comment_count!="")
				{
					$("#comment_count_"+id).html(data.comment_count);
					$("#like_count_"+id).html(data.likes_count);
					$("#dislike_count_"+id).html(data.dislikes_count);
				}
		}
	})
}
</script>
<script>
function generateCommentBox(blog_id)
{	
	$('#vote_list_area_'+blog_id).hide();
	var comment_area_content=$('#comment_box_area_'+blog_id).html();
	if(comment_area_content=="")
	{
		var current_user=$("#enter_val").val();
		var current_user_name=$("#current_user_name").html();
		var commentform="";
		commentform=commentform+"<br><div id='commenting_user' style='float:left;font-family: serif;font-size: 16px;background-color: cadetblue;border-radius: 50%;text-shadow: black 2px 2px;'>"+current_user_name+"</div>";
		commentform=commentform+"<div style='float:left;'><form id='comment_box'>";
		commentform=commentform+"<input type='hidden' name='action' value='submit_comment'></input>";
		commentform=commentform+"<input type='hidden' name='blog_id' value='"+blog_id+"'></input>";
		commentform=commentform+"<input type='hidden' name='user_id' value='"+current_user+"'></input>";
		commentform=commentform+"<textarea name='description' id='comment_description_"+blog_id+"' style='width: 160%;background: bisque;border-radius: 15px;font-family: cursive;'></textarea>";
		commentform=commentform+"</form><button id='comment_submit' style='background-color:blue;color:white;border-radius:5px;margin-left: 11px;' onclick='commentSubmit("+blog_id+");'>Comment</button>";
		commentform=commentform+"</div><br><br><br><br>";
		$('#comment_box_area_'+blog_id).append(commentform);
		$('#comment_box_area_'+blog_id).show();
	}
	else
	{
		$('#comment_box_area_'+blog_id).toggle();
	}
	
}
</script>
<script>
function commentSubmit(blog_id){
	
	var dataString=$('#comment_box').serialize();
	

	$.ajax({
		type:"POST",
		url:"CommentsController",
		data:dataString,
		dataType:'json',
		success:function(data, textStatus, jqXHR)
		{
			if(data.status.toLowerCase()=="success")
				{
					$('#comment_description_'+blog_id).val('');
					$('#comment_count_'+blog_id).html(data.comment_count);
					getCommentList(blog_id,"recentComment");
					//alert("Commented Successfully");
				}
			else
				{
					alert("Error in Comment Submition");
				}
		}
	})
}
</script>
<script>
function getCommentList(blog_id,from)
{	$('#vote_list_area_'+blog_id).hide();
	var dataString="action=getCommentList&id="+blog_id;
	$.ajax({
		type:"POST",
		url:"CommentsController",
		data:dataString,
		dataType:"json",
		success:function(data, textStatus, jqXHR)
		{
			getCommentListing(data,blog_id,from);
		}
	})
}
function getCommentListing(data,blog_id,from)
{
	if($('#comment_list_'+blog_id).is(':visible')==true && from!="recentComment")
		{
			$('#comment_list_'+blog_id).hide();
		}
	else
		{
			$("#comment_list_"+blog_id).html("");
			$('#comment_list_'+blog_id).show();
			months=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
			var comment_data=data.Comment;
			var user_data=data.Users[0];
			var listingStruct="<center><div><br><table id='commentListTable' style='display:block;'>";
			for(i=0;i<comment_data.length;i++)
				{	
					date=new Date(comment_data[i].created_at);
					var minutes_show=date.getMinutes();
					if(minutes_show/10<1)
						{
						minutes_show="0"+minutes_show;
						}
					else if(minutes_show/10==0)
						{
						minutes_show="00";
						}
					comment_created_at=months[date.getMonth()]+" "+date.getDate()+", "+date.getFullYear()+" @ "+date.getHours()+":"+minutes_show;
					listingStruct=listingStruct+"<tr id='"+comment_data[i].id+"'>";
					listingStruct=listingStruct+"<td style='width:99%;'><div id='commentCreatedBy' style='float:left;width:20%;'><div style='background:darkolivegreen;border-radius:50%;'><center><b onclick='viewModalSetUp();getUserProfile("+comment_data[i].created_by+");' style='cursor:pointer;color:cyan;text-shadow: 2px 2px chocolate;'>"+user_data[comment_data[i].created_by].first_name+" "+user_data[comment_data[i].created_by].last_name+"</b></center></div></div>";
					listingStruct=listingStruct+"&nbsp;<div style='float:right;width:75%'><div id='commentDescription' style='float:left;width:100%'><span style='color:beige;'><i>'"+comment_data[i].description+"'</i></span></div>";
					listingStruct=listingStruct+"<div id='commentCreatedAt' style='float:left;width:100%;'><lable style='color:grey;'><b>"+comment_created_at+"</b></label></div></div></td><td style='padding-bottom:4em;width:1%;'></td>";
					listingStruct=listingStruct+"</tr>";
				}
			listingStruct=listingStruct+"</table></div></center>";
			$("#comment_list_"+blog_id).append(listingStruct);
		}
}
</script>
<script>
function getVoteList(blog_id,from)
{	$('#comment_list_'+blog_id).hide();
	$('#comment_box_area_'+blog_id).hide();
	if($("#vote_list_area_"+blog_id).is(':visible')==true)
		{
			$("#vote_list_area_"+blog_id).hide();
		}
	else
		{
	var dataString="action=getVoteList&blog_id="+blog_id+"&like_type="+from;
	$.ajax({
		type:"POST",
		url:"LikesController",
		data:dataString,
		dataType:"json",
		success:function(data, textStatus, jqXHR)
		{
			getVoteListing(data,blog_id,from);
		}
	})
}
}
function getVoteListing(data,blog_id,from)
{
	
			$("#vote_list_area_"+blog_id).html("");
			$('#vote_list_area_'+blog_id).show();
			months=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
			var like_data=data.likes;
			var user_data=data.Users[0];
			var listingStruct="<center><div><br><table id='likeListTable' style='display:block;'>";
			for(i=0;i<like_data.length;i++)
				{	
					date=new Date(like_data[i].created_at);
					var minutes_show=date.getMinutes();
					if(minutes_show/10<1)
						{
						minutes_show="0"+minutes_show;
						}
					else if(minutes_show/10==0)
						{
						minutes_show="00";
						}
					like_created_at=months[date.getMonth()]+" "+date.getDate()+", "+date.getFullYear()+" @ "+date.getHours()+":"+minutes_show;
					listingStruct=listingStruct+"<tr id='"+like_data[i].id+"'>";
					listingStruct=listingStruct+"<td style='width:99%;'><div id='likeCreatedBy' style='float:left;width:100%;'><div style='background:darkolivegreen;border-radius:50%;'><center><b onclick='viewModalSetUp();getUserProfile("+like_data[i].created_by+");' style='cursor:pointer;color:cyan;text-shadow: 2px 2px chocolate;'>"+user_data[like_data[i].created_by].first_name+" "+user_data[like_data[i].created_by].last_name+"</b></center></div></div>";
					listingStruct=listingStruct+"<div id='likeCreatedAt' style='float:left;width:100%;'><lable style='color:grey;'><b>"+like_created_at+"</b></label></div></div></td><td style='padding-bottom:4em;width:1%;'></td>";
					listingStruct=listingStruct+"</tr>";
				}
			listingStruct=listingStruct+"</table></div></center>";
			$("#vote_list_area_"+blog_id).append(listingStruct);
		
}
</script>