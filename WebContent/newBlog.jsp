<jsp:include page="jqueryCombined.jsp"></jsp:include>
<form id="newBlogForm">
<input type ="hidden" name="action" value="newBlog"></input>
<label>Title:</label></br>
<input type="text" id="blogTitle" name ="blogTitle" placeholder="Enter Title." style="width:90%;border-radius:7px;">
</br>
</br>
</br>
<label>Description:</label></br>
<textarea id="blogDescription" name="blogDescription" placeholder="Enter Description." style="width:90%;border-radius:5px;"></textarea>
<input type="button" class="home_submit_form" name="newBlogSubmit" id="newBlogSubmit" style="display:none;"></input>
</form>
<script>
$('#newBlogSubmit').on('click',function(){
	var dataString=$('#newBlogForm').serialize();
	var usrid=$('#enter_val').val();
	dataString=dataString+"&usrid="+usrid;
	$.ajax({
		type:"POST",
		url:"BlogsController",
		data:dataString,
		dataType:"text",
		success:function(data ,textStatus ,jqXHR)
		{
			if(data.toLowerCase()=="success")
				{
					alert("Blog Created Successfully");
					getUpdatedWorkspace();
					$("#home_modal_close").click();
					
				}
			else
				{
					alert("Error in Blog Creation");
				}
		}
	})
})
</script>
<script>
function getUpdatedWorkspace()
{
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
					$("#home_content").html("No Blogs Created Yet!");
				}
			else
				{
					
					generateBlogListing(data,'workspace');
					
				}
		}
	});
	}
</script>