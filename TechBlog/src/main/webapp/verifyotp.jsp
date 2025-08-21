<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.techBlog.entities.Message"%>
<!DOCTYPE html>
<html>
<head>
<title>Verify OTP</title>
<link rel="icon" type="image/png" href="image/TechBlog2.png">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
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
</head>
<body>
	<main class="banner-background">
		<div class="container py-5 ">
			<div class="row justify-content-center">
				<div class="col-md-6">
					<%
					Message msg = (Message) session.getAttribute("message");
					if (msg != null) {
					%>
					<%
					session.removeAttribute("message");
					}
					%>
					<div class="card shadow-sm">
						<div class="card-body">
							<h4 class="text-center mb-3">Enter OTP</h4>
							<form method="post" id="optform">
								<div class="mb-3">
									<input type="text" class="form-control" id="otp" name="otp"
										placeholder="Enter OTP" required>
								</div>
								<button type="submit" id="submitBtn" class="btn btn-primary">Verify</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<%
	String opt = (String) session.getAttribute("otp");
	String email = (String) session.getAttribute("email");
	%>
	<script>
		$(document).ready(function() {
			let count = 0;
			$('#optform').on('submit', function() {
				event.preventDefault();
				$('#submitBtn').html("<span class='fa fa-spinner fa-spin'></span>")
				let otpIn ="<%=opt%>";
				let enteredOtp = $('#otp').val();
				if (otpIn == enteredOtp) {
					Swal.fire({
						title :"OTP verify successfully!",
						icon : "success",
						draggable : true,
					}).then(()=>{
						window.location.href = "resetpassword.jsp";
					})	
				} else if (count == 2) {
					Swal.fire({
						title : "You are entered OTP wrong two times!",
						icon : "error",
						draggable : true,
					}).then(()=>{
						window.location.href = "forgotpassword.jsp";
					})
				} else {
					Swal.fire({
						title : "You are entered wrong OTP!",
						icon : "error",
						draggable : true,
					})
					count++;
					$('#submitBtn').html("Verify");
				}
			})
		})
	</script>
</body>
</html>
