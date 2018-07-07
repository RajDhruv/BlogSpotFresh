
<h3>Go on!!!</h3>
<h4>Fill up the form and submit it to enhance your Blogging Experience.</h4>
<form id="signup_form">
<input type="hidden" value="register" name="action"></input>
<table>
	<tr>
		<td>
			Name:
		</td>
		<td>
			<input type="text" id="first_name" name="first_name" placeholder="Enter First Name"></input>
		</td>
		<td>
			<input type="text" id="last_name" name="last_name" placeholder="Enter Last Name."></input>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>
			UserID:
		</td>
		<td colspan="2">
			<input type="text" id="user_id" name="user_id" style='width:98%;' placeholder="Enter Unique Id to use while Loggin."></input>
			<input type="hidden" id="unique_Id_check" value="0"></input>
		</td>
		<td><label id="userid_unique" class="userid_unique">Check for Availability.</label>
		</td>
		
	</tr>
	<tr>
		<td>
			Email Address:
		</td>
		<td colspan="2">
			<input type="text" id="email_id" name="email_id" style='width:98%;' placeholder="Enter Email Address"></input>
		</td>
		<td></td>
	</tr>	
	<tr>
		<td>
			Password:
		</td>
		<td colspan="2">
			<input type="password" id="password" name="password" style='width:98%;' placeholder="Enter Password"></input>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>
			Confirm Password:
		</td>
		<td colspan="2">
			<input type="password" id="confirm_password" name="confirm_password" style='width:98%;' placeholder="Re-enter Password"></input>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>
			Phone Number:
		</td>
		<td colspan="2">
			<input type="number" id="phoneNo" name="phoneNo" style='width:98%;' placeholder="Enter Contact Number"></input>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>
			Address:
		</td>
		<td colspan="2">
			<input type="text" id="address" name="address" style='width:98%;' placeholder="Enter Address"></input>
		</td>
		<td></td>
	</tr>
	<tr>
		<td colspan="2">
		<input type="button" value="Sign-Up" id="signup_button" class="submit_form" style="display:none;"></input>
		</td>
		<td></td>
	</tr>
</table>
</form>
<script type="text/javascript">
$('#signup_button').on("click",function(){
	if(validateSignup())
		{
	var dataString=$('#signup_form').serialize();
	$.ajax({
		type: "POST",
		url: "UserController",
		data: dataString,
		dataType: "json",
		success: function( data, textStatus, jqXHR) {
			if(data.status.toLowerCase()=="success")
				{
					$('#modal_close').click();
					$('.modal-backdrop').hide();
					alert("User Successfully Registered.");
				}
			else
				{
					alert("Registration Failed");
				}
		}
		
	});
		}
})
</script>
<script>
function validateSignup()
{
	var first_name=document.getElementById("first_name").value;
	var user_id=document.getElementById("user_id").value;
	var password=document.getElementById("password").value;
	var conf_pass=document.getElementById("confirm_password").value;
	var unique_check=document.getElementById("unique_Id_check").value;
	if (first_name=="")
		{
		alert("Please enter first name");
		return false;
		}
	else if(user_id=="")
		{
		alert("Please enter User Id");
		return false;
		}
	else if(password=="")
		{
		alert("Please Enter a valid user password");
		return false;
		}
	else if(password!=conf_pass)
		{
		alert("Pasword Confirmation Does Not Match");
		return false;
		}
	else if(unique_check=='0')
		{
			alert("Please Check For User-ID Uniqueness First");
			return false;
		}
	else
		{
		return true;
		}
}
</script>
<script type="text/javascript">
$('#userid_unique').on('click',function(){
	var user_id_get=$('#user_id').val();
	var dataString="action=unique_userID&user_id="+user_id_get;
	$.ajax({
		type:"POST",
		url:"UserController",
		data:dataString,
		dataType:'text',
		success: function(data,textStatus, jqXHR){
			if(data.toLowerCase()=="success")
			{
				$('#userid_unique').html("<img alt='OK' src='./images/tick-mark.png' height='20' width='20' title='User Id Available'>");	
				$('#unique_Id_check').val('1');
			}
			else
			{
				alert("User ID Entered Is Not Available. Please Try Another ID.");
				$('#user_id').val("");
				$('#unique_Id_check').val('0');
			}
		}
	})
})
</script>
<script>
$("#user_id").keyup( function() {
	$('#userid_unique').html("Check for Availability.");
	$('#unique_Id_check').val(0);
});
</script>