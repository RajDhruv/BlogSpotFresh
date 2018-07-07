<jsp:include page="jqueryCombined.jsp"></jsp:include>
<script>
$("#user_id").keyup( function() {
	$('#userid_unique').html("Check for Availability.");
	$('#unique_Id_check').val(0);
});
$('#password').keyup(function(){
	$('#confirm_password_row').show();
})
</script>
<form id="update_user_form">
<input type="hidden" value="updateUser" name="action"></input>
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
			<input type="hidden" id="unique_Id_check" value="1"></input>
		</td>
		<td><label id="userid_unique" class="userid_unique"></label>
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
	<tr id="confirm_password_row" style="display:none;">
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
		<input type="button" value="Update-User" id="update_button" class="home_submit_form" style="display:none;"></input>
		</td>
		<td></td>
	</tr>
</table>
</form>
<script>
function autoFillForm()
{
	var current_usrid=$('#enter_val').val();
	var dataString="action=getProfile&usrid="+current_usrid;
	$.ajax({
		type:"POST",
		url:"UserController",
		data:dataString,
		dataType:"json",
		success: function(data, textStatus, jqXHR)
		{
			
			$('#first_name').val(data.first_name);
			$('#last_name').val(data.last_name);
			$('#user_id').val(data.user_id);
			$('#email_id').val(data.email_id);
			$('#password').val(data.password);
			$('#phoneNo').val(data.phone_no);
			$('#address').val(data.address);
			
		}
	});
	
	
}
</script>

<script>
$('#update_button').on('click',function(){
	if(validateUpdate())
	{
	dataString=$('#update_user_form').serialize();
	var current_usrid=$('#enter_val').val();
	dataString=dataString+"&usrid="+current_usrid;
	$.ajax({
		type:"POST",
		url:"UserController",
		data:dataString,
		dataType:'json',
		success:function(data, textStatus, jqXHR)
		{ 
			if(data.status.toLowerCase()=="success")
				{
					alert("Details Updated Successfully");
					$('#home_modal_close').click();
					$('#profile').click();
				}
			else
				{
					alert("Error!!! Details not Updated.");
				}
		}
	})
	}
})
</script>
<script>
$(document).ready(function(){
	autoFillForm();
})
</script>
<script>
function validateUpdate()
{
	var first_name=document.getElementById("first_name").value;
	var user_id=document.getElementById("user_id").value;
	var password=document.getElementById("password").value;
	var unique_check=document.getElementById("unique_Id_check").value;
	
	if($("#confirm_password").is(':visible'))
	{
	var conf_pass=document.getElementById("confirm_password").value;
	if(password!=conf_pass)
		{
			alert("Pasword Confirmation Does Not Match");
			return false;
		}
	}
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
