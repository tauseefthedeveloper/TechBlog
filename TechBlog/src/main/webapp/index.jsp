<%@page import="java.sql.*" %>
<%@page import="com.techBlog.helper.ConnectionProvider" %>
<%@ page import="com.techBlog.dao.PostDao"%>
<%@ page import="com.techBlog.entities.User"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.techBlog.entities.Categories"%>


<html>
<head>
<meta charset="UTF-8">
<title>TechBlog Home</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Bootstrap 5 Bundle JS (includes Popper and modal logic) -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" href="image/TechBlog2.png">

<link rel="icon" type="image/png" href="image/TechBlog2.png">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<style>
		.banner-background{
			background-color:#4242eb;
			color:white;
			clip-path: polygon(50% 0%, 100% 0, 100% 31%, 100% 100%, 79% 91%, 51% 100%, 21% 91%, 21% 91%, 0 100%, 0 0);
		}
	</style>
</head>
<body>
<div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v23.0"></script>
 	<%@include file="navbar.jsp" %>	
 	<div class="container-fluid p-0 m-0 banner-background">
 		<div class="jumbotron p-4">
 			<div class="container p-2">
 				<h3 class="display-4">Welcome to TechBlog</h3>
 				<p>Welcome to technical blog, World of technology!</p>
 				<p>A programming language is a formal constructed language designed to communicate instructions to a machine, particularly a computer. These languages are used to write computer programs, which are sets of instructions that a computer can execute to perform specific tasks.</p>
 				<% 
 				User user1 = (User) session.getAttribute("current_user");
                if (user1 == null) {
 				%>
 				<a href="register.jsp" class="btn btn-outline-dark text-white"><span class="fa fa-user-plus"></span> Start !it's free</a>
 				<a href="login.jsp" class="btn btn-outline-dark text-white"><span class="fa fa-user-circle fa-spin"></span> Login!</a>
 				<%
 				}
 				%>
 			</div>
 		</div>
 	</div>
 	<br>
 	<main>
 	    
		<div class="container">
			<h1 style="color:red;font-style:italic;text-align:center;">All Posts</h1>
			<div class="row mt-4">
				<div class="col-md-12">
					<div class="container text-center" id="loaderPost">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading!</h3>
					</div>
					<div class="container-fluid row" id="post-container"></div>
				</div>
			</div>
		</div>
	</main>
	<!--	<h1>Comment s</h1>
	 	<div class="fb-comments" data-href="http://127.0.0.1:8080/TechBlog/index.jsp" data-width="100%" data-numposts="5"></div>
	  -->
	<div>
		<%@include file="footer.jsp" %>
	</div>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
	<script src="js/script.js" type="text/javascript"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
   <script src="js/script.js" type="text/javascript"></script>
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   
	<script>
	   function getPosts(cId){
			$('#loaderPost').show();
			$('#post-container').hide();
	
			$.ajax({
				url : 'load-post-on-index.jsp',
				data:{catId:cId},
				success : function(data, textStatus, jqXHR) {
					$('#loaderPost').hide();
					$('#post-container').show();
					$('#post-container').html(data);
				},
				error:function(){
					console.log("error")
				}
			})
	   }
	   $(document).ready(function() {
			getPosts(0);
	    })
	function loginThenLike(){
		   Swal.fire("Please login before like this post...");
	}
	function loginThenComment(){
		Swal.fire("Please login before comment this post...");
	}
	function loginThenRead(){
		Swal.fire("Please login before read this post...");
	}


   </script>
</body>
</html>