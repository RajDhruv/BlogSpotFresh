
<jsp:include page="jqueryCombined.jsp"></jsp:include>

<h4>Login to Your Dashboard to Start BLOGGING!!!!</h4>
<form id="loginForm">
<input type="hidden" name="action" id="action" value="login"></input>
<table>
<tr>
<td>
User-ID :
</td>
<td>
<input type="text" id="user_id" name="user_id"></input>
</td>
</tr>
<tr>
<td>
Password :
</td>
<td>
<input type="password" id="password" name="password"></input>
</td>
</tr>
<tr>
<td></td>
<td>
<input type="button" id="login_button" value="Login" class="submit_form" style="display:none;"></input>
</td>
</tr>
</table>
</form>
<div id="responseMsg"></div>
<script type="text/javascript">
$('#login_button').on("click",function(){
	var dataString = $("#loginForm").serialize();
	 $.ajax({
         type: "POST",
         url: "UserController",
         data: dataString,
         dataType: "json",
       //if received a response from the server
         success: function( data, textStatus, jqXHR) {
        	 //alert(data);
             if(data.status.toLowerCase()=="success")
            	 {
            $('#top_header').html("<h2 style='color:white;'>Blogspot</h2><div id='user_attr' style='margin-top:-45px;float:right;'><h4 style='color:cyan;margin-right:66px;' id='current_user_name'>"+data.user_name+"</h4><img alt='Logout' src='./images/logout_red.png' title='Logout' id='logout_user' height='30' width='32' style='float:right;margin-right:10px;margin-top:-36px;cursor:pointer;'><input type='hidden' id='enter_val' value='"+data.usrid+"'></input></div>")
            $('#sub_header').html("<nav class='navbar navbar-inverse' style='min-height=30px;'><div class='container-fluid'><ul class='nav navbar-nav'><li id='home_link'><a href='#'><label>Home</label></a></li><li id='workspace_link'><a href='#'><label>Workspace</label></a></li><li id='profile'><a href='#'><label>Profile</label></a></li></ul></div></nav>");	
            $('#centercol').load("home_page.jsp");
            $('#modal_close').click();
            $('.modal-backdrop').hide();
            	 }
             else
				{
             alert(data.status);
             }
         }
	 });
	});
</script>
