<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.techBlog.entities.Message"%>
<!DOCTYPE html>
<html>
<head>
<title>Reset Password</title>
<link rel="icon" type="image/png" href="image/TechBlog2.png">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	background-color: #4242eb;
	clip-path: polygon(50% 0%, 100% 0, 100% 31%, 100% 100%, 79% 91%, 51% 100%, 21% 91%,
		21% 91%, 0 100%, 0 0);
}

@media ( max-width : 576px) {
	.banner-background {
		clip-path: none !important;
		background-color: #4242eb;
	}
}
</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
</head>
<body>
	<main class="banner-background">
		<div class="container banner-background py-5">
			<div class="row justify-content-center">
				<div class="col-md-6">
					<%
					Message msg = (Message) session.getAttribute("message");
					if (msg != null) {
					%>
					<div class="alert <%=msg.getCssType()%>" role="alert">
						<%=msg.getContent()%>
					</div>
					<%
					session.removeAttribute("message");
					}
					%>
					<div class="card shadow-sm">
						<div class="card-body">
							<h4 class="text-center mb-3">Reset Password</h4>
							<form id="resetForm" method="post">
								<div class="mb-3">
									<input type="password" class="form-control" id="newPassword" name="newPassword"
										placeholder="Enter new password" required>
										<div id="passwordHelp" class="form-text text-danger"></div>
								</div>
								<button type="submit" id="submitBtn" class="btn btn-success">Reset
									Password</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	$(document).ready(function(){
		$('#resetForm').on('submit',function(event){
			event.preventDefault();
			$('#submitBtn').html("<span class='fa fa-spinner fa-spin'></span>")
			let password=$('#newPassword').val();
			$.ajax({
				url:'resetpassword',
				data:{password:password},
				type:'POST',
				success:function(response){
					if(response.trim()==="passwordReset"){
						Swal.fire({
							title:"Password reset successfully!",
							icon:"success",
							draggable:true,
						}).then(()=>{
							window.location.href = "login.jsp";
						})	
					}else if(response.trim()==="notReset"){
						Swal.fire({
							title:"Password not reset",
							icon:"success",
							draggable:true,
						}).then(()=>{
							window.location.href = "passwordreset.jsp";
						})
					}
				},error: function(xhr, status, error) {
			        $('#submitBtn').html("Reset Password");
			        console.error("AJAX error:", error);
			    }
			})
		})
	})
	$(document).ready(function(){
		$('#newPassword').on('keyup',function(event){
			let password = $(this).val();
	        let message = '';
	        if (password.length < 8) {
	            message = 'Password must be at least 8 characters.';
	        } else if (!/[A-Z]/.test(password)) {
	            message = 'Password must contain at least one uppercase letter.';
	        } else if (!/[a-z]/.test(password)) {
	            message = 'Password must contain at least one lowercase letter.';
	        } else if (!/[0-9]/.test(password)) {
	            message = 'Password must contain at least one number.';
	        } else if (!/[!@#$%^&*]/.test(password)) {
	            message = 'Password must contain at least one special character (!@#$%^&*).';
	        }

	        $('#passwordHelp').text(message);
	        event.preventDefault();
	    });
	});
	</script>
</body>
</html>
