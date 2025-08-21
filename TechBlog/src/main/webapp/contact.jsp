<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.techBlog.entities.User"%>
<%@ page import="com.techBlog.entities.User"%>
<%@ page import="com.techBlog.entities.Message"%>
<%@ page import="com.techBlog.dao.PostDao"%>
<%@ page import="com.techBlog.entities.Categories"%>
<%@ page import="com.techBlog.helper.ConnectionProvider"%>
<%@ page import="java.util.ArrayList"%>
<%@page errorPage="error.jsp"%>
<%
User user = (User) session.getAttribute("current_user");
if (user == null) {
	response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact us</title>
<link rel="icon" type="image/png" href="image/TechBlog2.png">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css">
<style>
.banner-background {
	background-color: #4242eb;
	color: white;
	height:300px;
	clip-path: polygon(50% 0%, 100% 0, 100% 31%, 100% 100%, 79% 91%, 51% 100%, 21% 91%,
		21% 91%, 0 100%, 0 0);
}

.contact-box {
    background: white;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
    width: 100%;
    text-align: center;
    margin-top: -275px; /* Overlap upward */
    position: relative;
    z-index: 1;
}

.contact-box h2 {
	margin-bottom: 20px;
	color: #0d6efd;
}

.contact-info p {
	margin: 10px 0;
	font-size: 1.1rem;
	color: #333;
}

.contact-info a {
	color: #0d6efd;
	text-decoration: none;
}

.contact-info a:hover {
	text-decoration: underline;
}
.container{
	padding:14px 0px 40px 0px;
}
</style>
</head>
<body>
	<nav
		class="navbar navbar-expand-lg navbar-dark bg-dark primary-background">
		<div class="container-fluid">
			<a class="navbar-brand" href="/TechBlog"><span
				class="fa fa-file-code-o"></span>&nbsp;TechBlog</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="/TechBlog"><span class="fa fa-home"></span>
							Home</a></li>
					<li class="nav-item"><a class="nav-link" href="contact.jsp"><span class="fa fa-phone"></span> Contact</a>
					</li>
					<li class="nav-item"><a href="#!" data-bs-toggle="modal"
						data-bs-target="#add-post-modal" class="nav-link"><span class="fa fa-edit"></span> Do Post</a></li>
				</ul>
				<ul class="navbar-nav mr-right">
					<li class="nav-item">
						<%
						if (user == null) {
						%>
						<%
 							} else {
 						%> <a href="#!" class="nav-link" data-bs-toggle="modal"
						data-bs-target="#exampleModal">Welcome,  
							<%=user.getName()%> <img src="pic/<%=user.getProfile()%>" alt="Profile"
							style="height: 25px; width: 25px; border-radius: 50%; margin-right: 0px;">
					</a>
					</li>
					<li class="nav-item"><a href="Logout" class="nav-link"> <span
							class="fa fa-external-link"></span> Logout
					</a></li>
					<%
					}
					%>

				</ul>
			</div>
		</div>
	</nav>
	
	<main class="banner-background">
		
	</main>
	<main>
		<div class="container">
			<div class="contact-box">
				<div>
					<h2>Contact Us</h2>
				</div>
				<div class="contact-info">
					<p>
						<strong>Name:</strong> Tauseef Khan
					</p>
					<p>
						<strong>Address:</strong> 123 TechStreet, Silicon Valley, CA
					</p>
					<p>
						<strong>Phone:</strong> +1 (555) 123-4567
					</p>
					<p>
						<strong>Email:</strong> <a href="mailto:tauseefthedeveloper@gmail.com">tauseefthedeveloper@gmail.com</a>
					</p>
					<p>
						<strong>Website:</strong> <a href="https://github.com/tauseefthedeveloper"
							target="_blank" rel="noopener">tauseefthedeveloper</a>
					</p>
				</div>
			</div>
		</div>
	</main>
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-primary text-white">
					<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img alt="image not found" src="pic/<%=user.getProfile()%>"
							class="img-fluid"
							style="border-radius: 50%; width: 110px; height: 110px; object-fit: cover;">
						<h5 class="modal-title " id="exampleModalLabel"><%=user.getName()%></h5>
						<div id="profile-details">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">ID</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">Status</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered On</th>
										<td><%=user.getDateTime().toLocalDateTime()%></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- Edit profile details -->
						<div id="profile-edit" style="display: none">
							<h5 class="mt-2 text-danger text-left">Please edit
								carefully!</h5>
							<form action="EditedUserData" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td scope="row">ID:</td>
										<td><input class="form-control" type="number"
											name="user_id" value="<%=user.getId()%>" disabled></td>
									</tr>
									<tr>
										<td scope="row">Name:</td>
										<td><input class="form-control" type="text"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<td scope="row">Email:</td>
										<td><input class="form-control" type="email"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<td scope="row">Password:</td>
										<td><input class="form-control" type="password"
											name="user_password" value="<%=user.getPassword()%>"></td>
									</tr>
									<tr>
										<td scope="row">About:</td>
										<td><textarea rows="2" class="form-control"
												name="user_about"><%=user.getAbout()%></textarea></td>
									</tr>
									<tr>
										<td scope="row">New profile:</td>
										<td><input type="file" class="form-control"
											name="user_pic"></td>
									</tr>
								</table>
								<div class="container">
									<button type="submit" class="btn btn-success">Save</button>
								</div>
							</form>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" id="edit-button" class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Add post modal -->

	<div class="modal add-modal fade" id="add-post-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Fill the
						details</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<div class="modal-body">
					<div class="container">
						<form id="add-post" class="form" action="AddPostServlet"
							method="post" enctype="multipart/form-data">
							<div class="form-group">
								<select name="CId" class="form-control" required>
									<option selected disabled>---Select Category---</option>
									<%
									PostDao postD = new PostDao();
									ArrayList<Categories> list = postD.getAllCategory();
									for (Categories c : list) {
									%>
									<option value="<%=c.getId()%>"><%=c.getName()%></option>
									<%
									}
									%>
								</select>
							</div>
							<br>
							<div class="form-group">
								<input name="title" type="text" class="form-control"
									placeholder="Enter the title" required>
							</div>
							<br>
							<div class="form-group">
								<textarea name="content" class="form-control"
									placeholder="Enter the content" required></textarea>
							</div>
							<br>
							<div class="form-group">
								<textarea name="code" class="form-control"
									placeholder="Enter the program If any?" required></textarea>
							</div>
							<br>
							<div>
								<label>Choose the picture</label> <input type="file"
									name="post_pic" required>
							</div>
							<br>
							<div class="container text-center">
								<button type="submit" class="btn btn-success">Save post</button>
							</div>
						</form>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
		
	</div>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
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
	<script>
		
	</script>
</body>
</html>