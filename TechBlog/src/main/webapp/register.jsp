<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Here</title>
	<link rel="icon" type="image/png" href="image/TechBlog2.png">
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<style>
		.banner-background1{
			background-color:#4242eb;
			height:300px;	
			clip-path: polygon(50% 0%, 100% 0, 100% 31%, 100% 100%, 79% 91%, 51% 100%, 21% 91%, 21% 91%, 0 100%, 0 0);
			
		}
		@media (max-width: 576px) {
		  .banner-background1 {
		    clip-path: none !important;
		    background-color: #4242eb;
		  }
		  .main-register{
		  	margin-top: -275px;
		  }
}
		
	</style>
</head>
<body>
	<%@include file="navbar.jsp" %>
	<main class="banner-background1 py-5">
	</main>
	<main>
		<div class="container">
			    <div class="row justify-content-center main-register" style="margin-top: -275px;">
			      <div class="col-lg-4 col-md-6 col-sm-10">
			        <div class="card shadow">
			          <div class="card-header banner-background text-white text-center bg-primary">
			            <h5 class="mb-0"><span class="fa fa-user-plus"></span> Register</h5>
			          </div>
			          <div class="card-body">
			            <form id="registerForm" action="Register" method="POST">
			              <div class="mb-3">
			                <label for="name" class="form-label">User name</label>
			                <input name="userName" type="text" class="form-control" id="name" placeholder="Enter name" required>
			              </div>
			              <div class="mb-3">
			                <label for="email" class="form-label">Email address</label>
			                <input name="userEmail" type="email" class="form-control" id="email" placeholder="Enter email" required>
			              </div>
			              <div class="mb-3">
			                <label for="password" class="form-label">Password</label>
			                <input name="userPassword" type="password" class="form-control" id="password" placeholder="Enter password" required>
			              	<div id="passwordHelp" class="form-text text-danger"></div>
			              </div>
			              <div class="mb-3">
			                <label for="userAbout" class="form-label">About you</label>
			                <textarea name="userAbout" class="form-control" id="userAbout" placeholder="Enter something about you" rows="3" required></textarea>
			              </div>
			              <div class="mb-3">
			                <label class="form-label">Select Gender</label><br>
			                <div class="form-check form-check-inline">
			                  <input class="form-check-input" type="radio" name="userGender" id="male" value="Male" required>
			                  <label class="form-check-label" for="male">Male</label>
			                </div>
			                <div class="form-check form-check-inline">
			                  <input class="form-check-input" type="radio" name="userGender" id="female" value="Female" required>
			                  <label class="form-check-label" for="female">Female</label>
			                </div>
			              </div>
			              <div class="form-check mb-3">
			                <input name="userCheck" type="checkbox" class="form-check-input" id="exampleCheck1">
			                <label class="form-check-label" for="exampleCheck1">Agree to terms and conditions</label>
			              </div>
			              <div class="text-center mb-3" id="loader" style="display:none;">
			                <span class="fa fa-refresh fa-spin fa-2x"></span>
			              </div>
			              <button id="submitBtn" type="submit" class="btn btn-primary w-100">Submit</button>
			            </form>
			          </div>
			        </div>
			      </div>
			    </div>
			  </div>
	</main>
	<!-- JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
   <script src="js/script.js" type="text/javascript"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
   <script>
   $(document).ready(function(){
		$('#password').on('keyup',function(event){
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
$(document).ready(function(){
	console.log("loaded");
	$('#registerForm').on('submit', function(event){
		event.preventDefault();
		let form = new FormData(this);

		$('#submitBtn').hide();
		$('#loader').show();

		$.ajax({
			url: 'Register',
			type: 'POST',
			data: form,
			success: function(data, textStatus, jqXHR){
				console.log(data);
				$('#submitBtn').show();
				$('#loader').hide();
				if(data.trim() === 'done'){
					swal("Register Successfully. Redirecting to login page...")
					.then((value) => {
						window.location = "login.jsp";
					});
				} else {
					swal(data);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				$('#submitBtn').show();
				$('#loader').hide();
				swal("Something went wrong. Try again...");
			},
			processData: false,
			contentType: false
		});
	});
});
</script>
   
</body>
</html>