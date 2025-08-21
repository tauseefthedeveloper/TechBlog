<%@page import="com.techBlog.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password || TechBlog</title>
<link rel="icon" type="image/png" href="image/TechBlog2.png">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
	<main class="banner-background py-5">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6">
					<div class="card shadow-sm">
						<div class="card-body">
							<h4 class="card-title mb-4 text-center">Please enter the
								details</h4>
							<form id="userForm" method="post">
								<!-- Name -->
								<div class="mb-3">
									<label for="name" class="form-label">Name</label> <input
										type="text" class="form-control" id="name" name="name"
										placeholder="Enter your full name" required>
								</div>

								<!-- Email -->
								<div class="mb-3">
									<label for="email" class="form-label">Email address</label> <input
										type="email" class="form-control" id="email" name="email"
										placeholder="Enter your email" required>
								</div>

								<button id="submitBtn" type="submit"
									class="btn btn-primary text-center">Submit</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

	</main>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	$(document).ready(function(){
		$('#userForm').on('submit',function(){
			event.preventDefault();
			$('#submitBtn').html("<span class='fa fa-spinner fa-spin'></span>");
			let name=$("#name").val();
			let email=$("#email").val();
			$.ajax({
				url:'forgot',
				data:{name:name,email:email},
				type:'POST',
				success:function(response){
					if(response==="otpSent"){
						Swal.fire({
		                    title: "OTP sent successfully!",
		                    icon: "success"
		                }).then(() => {
		                    window.location.href = "verifyotp.jsp";
		                });
					}else if (response === "invalidUser") {
	                    Swal.fire({
	                        title: "Invalid details!",
	                        icon: "error"
	                    });

	                } else if (response === "emailFail") {
	                    Swal.fire({
	                        title: "Could not send email!",
	                        icon: "error"
	                    });

	                } else {
	                    Swal.fire({
	                        title: "Something went wrong!",
	                        icon: "error"
	                    });
	                }
	                $('#submitBtn').html("Submit");
				}
			})
		})
	})
	</script>
</body>
</html>