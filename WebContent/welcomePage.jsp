<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bloggers Spot</title>
</head>
<jsp:include page="jqueryCombined.jsp"></jsp:include>
<link rel="stylesheet" href="./css/bootstrap.min.css"></link>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>
<style>
.nav_link{
color:blue;
cursor:pointer;
}
.modal-body{
opacity: 1;
color:white;
font-style:oblique;
}
.modal-header{
opacity:1;
color:white;
}
.modal-content{
background-color: black;
opacity:0.85;
}
.close{
opacity:1;
color:white;
}
.modal-submit{
background-color:cadetblue;
color:white;
opacity:1;
}
.modal-cancel{
background-color:grey;
color:white;
opacity:1;
}
.userid_unique{
font-style: normal;
color: darkturquoise;
}
input{
color:black;
}
textarea{
color:black;
}
</style>

<body background="./images/main_background.jpg" style="overflow:auto;">
<div id="top_header" style="background:black;">
<center>
<h1 style="color:white;font-family:fantasy;">
	Welcome User to a Completely New Blogging Experience.
</h1>
</center>
</div>
<div id="sub_header">
<center>
<h3 style="font-family:serif;"><i>
	The tool is designed in a way so as to make you feel completely free to share your views and ideas.
	Kindly proceed and make your self a happy and independent Blogger.
	</i>
</h3>
</center>
</div>
<div id="centercol">
<center>
<table >
<tr>
<td>
<img src="./images/add_user.png" height="300" title="New User" alt="New User Signup">
</td>
<td><label>&nbsp;&nbsp;&nbsp;&nbsp;</label></td>
<td>
<img src="./images/login.png" height="300" title="Login User" alt="Existing User Login">
</td>
</tr>
<tr>
<td>
<center>
<h5>
	New to Blogging!!! then <label id="register_form" data-toggle="modal" data-target="#myModal-1" style="color:blue;font-style:italic;cursor:pointer;">Sign-up</label>
</h5>
</center>
</td>
<td><label>&nbsp;&nbsp;&nbsp;&nbsp;</label></td>
<td>
<center>
<h5>
	Already a Blogger!!! then <label id="login_form" data-toggle="modal" data-target="#myModal-1" style="color:blue;font-style:italic;cursor:pointer;">Login</label>
</h5>
</center>
</td>
</tr>
</table>
</center>
</div>
<div class="modal fade" id="myModal-1" tabindex="-1" role="dialog">
<div class="modal-dialog">
 <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
		<div class="modal-body" id="modalContainer">
		</div>
		<div class="modal-footer">
		<label class="btn btn-default modal-submit" id="modal_submit" onclick="$('.submit_form').click();">Submit</label>
          <button type="button" id="modal_close" class="btn btn-default modal-cancel" data-dismiss="modal">Cancel</button>
        </div>
</div>
</div>
</div>
</body>
<script type="text/javascript">
$('#login_form').on("click",function(){
	 $('#modalContainer').load('LoginForm.jsp');
	 $('.modal-title').html("<h2>Login!</h2>");
	 $('#modal_submit').html("Login");
	});
$('#register_form').on("click",function(){
	 $('#modalContainer').load('SignUp.jsp');
	 $('.modal-title').html("<h2>Sign Up!</h2>");
	 $('#modal_submit').html("Sign Up");
	});
</script>
</html>