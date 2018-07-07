<jsp:include page="jqueryCombined.jsp"></jsp:include>
<label>Successfully Logged Out</label>
<br/>
<label id="login_form" data-toggle="modal" data-target="#myModal-logout" style="color:blue;font-style:italic;">Login Again!</label>
<div class="modal fade" id="myModal-logout" tabindex="-1" role="dialog">
<div class="modal-dialog">
 <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
		<div class="modal-body" id="modalContainer">
		</div>
		<div class="modal-footer">
		<label class="btn btn-default" id="modal_submit" onclick="$('.submit_form').click();">Submit</label>
          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        </div>
</div>
</div>
</div>
<script type="text/javascript">
$('#login_form').on("click",function(){
	 $('#modalContainer').load('LoginForm.jsp');
	 $('.modal-title').html("<h2>Login!</h2>");
	 $('modal_submit').html("Login");
	});
	</script>