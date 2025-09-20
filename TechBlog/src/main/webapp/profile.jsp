<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.techBlog.entities.User"%>
<%@ page import="com.techBlog.entities.Message"%>
<%@ page import="com.techBlog.dao.PostDao"%>
<%@ page import="com.techBlog.dao.CommentDao"%>
<%@ page import="com.techBlog.entities.Categories"%>
<%@ page import="com.techBlog.helper.ConnectionProvider"%>
<%@ page import="com.techBlog.helper.TimeAgo"%>
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
<title>Profile Page</title>
<!-- Bootstrap 5 CSS -->
<style >
.img-fixed {
  height: 120px;       /* 👈 fix height */
  width: auto;         /* maintain ratio */
  object-fit: contain; /* no stretch */
  border: 1px solid #ddd;
  border-radius: 6px;
  background: #f8f9fa;
  padding: 3px;
}
</style>
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

<style>
.banner-background {
	background-color: #4242eb;
	clip-path: polygon(50% 0%, 100% 0, 100% 31%, 100% 100%, 79% 91%, 51% 100%, 21% 91%,
		21% 91%, 0 100%, 0 0);
	height: 300px; /* Taller banner */
	display: flex;
	align-items: center;
}

.All-detaile-of-the-content {
	margin-top: -300px;
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
	<nav
		class="navbar navbar-expand-lg navbar-dark bg-dark primary-background">
		<div class="container-fluid">
			<a class="navbar-brand" href="https://techblog-5e81.onrender.com/"><span
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
						aria-current="page" href="https://techblog-5e81.onrender.com/"><span class="fa fa-home"></span>
							Home</a></li>
					<li class="nav-item"><a class="nav-link" href="contact.jsp"><span
							class="fa fa-phone"></span> Contact</a></li>
					<li class="nav-item"><a href="#!" data-bs-toggle="modal"
						data-bs-target="#add-post-modal" class="nav-link"><span
							class="fa fa-edit"></span> Do Post</a></li>
				</ul>
				<ul class="navbar-nav mr-right">
					<li class="nav-item">
						<%
						if (user == null) {
						%> <%
 } else {
 %> <a href="#!" class="nav-link" data-bs-toggle="modal"
						data-bs-target="#exampleModal">Welcome, <%=user.getName()%> 
						<img src="<%= user.getProfile() != null && !user.getProfile().isEmpty() ? user.getProfile() : "pic/default.png" %>" 
     						alt="Profile" style="height:25px; width:25px; border-radius:50%; margin-left:5px;">
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
	<div class="container-fluid p-0 m-0 banner-background"></div>
	<!-- end of navbar -->
	<div class="All-detaile-of-the-content container">
		<div class="container text-center">
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
		</div>

		<!-- start of main -->
		<main>
			<div class="container">
				<div class="row mt-4">
					<div class="col-md-3">
						<div class="list-group">
							<a onclick="getPosts(0,this)" href="#"
								class="list-group-item list-group-item-action c-link active"
								aria-current="true"> All Posts </a>

							<%
							PostDao postDao = new PostDao();
							ArrayList<Categories> list1 = postDao.getAllCategory();
							for (Categories c : list1) {
							%>
							<a href="#" onclick="getPosts(<%=c.getId()%>,this)"
								class="list-group-item list-group-item-action c-link"><%=c.getName()%></a>
							<%
							}
							%>

						</div>
					</div>
					<div class="col-md-9">
						<div class="container text-center" id="loaderPost">
							<i class="fa fa-refresh fa-4x fa-spin"></i>
							<h3 class="mt-2">Loading!</h3>
						</div>

						<div class="container-fluid row" id="post-container"></div>
					</div>
				</div>
			</div>
		</main>
		<!-- end of main -->


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
							<img src="<%= user.getProfile() != null && !user.getProfile().isEmpty() ? user.getProfile() : "pic/default.png" %>" 
     						alt="Profile" style="border-radius: 50%; width: 110px; height: 110px; object-fit: cover;">
								
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
											<td><%=TimeAgo.toTimeAgo(user.getDateTime().toLocalDateTime())%></td>
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
									<label>Current Picture:</label>
									<div id="current-post-pic" class="mb-2" style="display: none;">
										<img id="current-post-pic-img" src="" alt="Post Image"
											style="max-width: 100%; height: auto; border: 1px solid #ccc; border-radius: 4px;">
									</div>
									<label>Choose the picture</label> <input type="file"
										name="post_pic" required>
								</div>
								<br>
								<div class="container text-center">
									<button type="submit" class="btn btn-success">Save
										post</button>
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

		<!-- Edit the post -->
		<!-- Modal -->
		<div class="modal fade" id="edit-post-modal" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<form id="edited-form" action="Edit" method="post" enctype="multipart/form-data">
						<div class="modal-header">
							<h5 class="modal-title text-danger">Edit the Post</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>

						<div class="modal-body">
							<!-- Hidden Post Id -->
							<input type="hidden" name="postId" id="edit-post-id">
							<input type="hidden" name="old_pic" id="edit_old_pic">

							<div class="mb-3">
								<label>Title</label> <input type="text" name="title"
									id="edit-post-title" class="form-control">
							</div>

							<div class="mb-3">
								<label>Content</label>
								<textarea name="content" id="edit-post-content"
									class="form-control"></textarea>
							</div>

							<div class="mb-3">
								<label>Code</label>
								<textarea name="code" id="edit-post-code" class="form-control"></textarea>
							</div>

							<div class="mb-3">
								<label>Upload New Picture</label> <input type="file"
									id="edit_new_pic" name="new_pic" accept="image/*"
									class="form-control">
							</div>

							<!-- Old picture -->
							<div
								class="d-flex justify-content-between align-items-start" style="width:100%;">

								<!-- Old Picture -->
								<div class="text-center" style="width:50%;">
									<p class="mt-2">Old Picture:</p>
									<img id="current-pic" src="posts_pic/default.png"
										class=" img-fixed">
								</div>

								<!-- Preview New Picture -->
								<div class="text-center" style="width:50%;">
									<p class="mt-2">Preview New Picture:</p>
									<img id="preview_edit_pic" src="" 
									alt="Please select an image"
										class=" img-fixed">
								</div>

							</div>

						</div>

						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">Update
								Post</button>
						</div>
					</form>
				</div>
			</div>
		</div>

	</div>

    <div>
		<%@include file="footer.jsp" %>
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
	<!-- Edit post   -->
	<script>
	$(document).on("click", "#edit-btnonpost", function (e) {
	    e.preventDefault();
	    
	    let postId  = $(this).data("id");
	    let title   = $(this).data("title");
	    let content = $(this).data("content");
	    let code    = $(this).data("code");
	    let pic     = $(this).data("pic");

	    console.log($("#edit-post-id").val());

	    $("#edit-post-id").val(postId);
	    $("#edit-post-title").val(title);
	    $("#edit-post-content").val(content);
	    $("#edit-post-code").val(code);
	    $("#edit_old_pic").val(pic);
	    if (pic) {
	        $("#current-pic").attr("src", "posts_pic/" + pic);
	        //$("#preview_edit_pic").attr("src", "posts_pic/" + pic);
	    } else {
	        //$("#current-pic").attr("src", "images/default.png");
	        $("#preview_edit_pic").attr("src", "posts_pic/default.png");
	    }

	   
	});
	//after editing the post send the data to db;
	$(document).ready(function(){
		$('#edited-form').on('submit',function(e){
			e.preventDefault();
		let form=new FormData(this);
		$.ajax({
			url:'Edit',
			data:form,
			type:'POST',
			processData: false,
	        contentType: false,
			success:function(data){
				if(data.trim()=="true"){
					Swal.fire({
						title : "Post updated successfully!",
						icon : "success",
						draggable : true
					});
		            location.reload();
				}else{
					Swal.fire({
						title:'Something went wrong!',
						icon:'error',
						draggable:true
					})		
				}
			}
		})	
	})	
	});
	$(document).on("change", "#edit_new_pic", function () {
	    const file = this.files[0];
	    if (file) {
	        let reader = new FileReader();
	        reader.onload = function (e) {
	            $("#preview_edit_pic").attr("src", e.target.result);
	        };
	        reader.readAsDataURL(file);
	    } else {
	        $("#preview_edit_pic").attr("src", "posts_pic/default.png");
	    }
	});

	</script>
	<script>
	$(document).ready(function() {
		let editStatus = false;
		$('#edit-button').click(function() {
			if (editStatus == false) {
				$('#profile-details').hide();
				$('#profile-edit').show();
				$(this).text('Back');
				editStatus = true;
			} else {
				$('#profile-details').show();
				$('#profile-edit').hide();
				$(this).text('Edit');
				editStatus = false;
			}

		});
	});
	</script>
	<!-- add-post script -->
	<script>
	$(document).ready(function() {
		$('#add-post').on('submit', function() {
			event.preventDefault();
			let form = new FormData(this);
			$.ajax({
				url : 'AddPostServlet',
				type : 'POST',
				data : form,
				processData : false,
				contentType : false,
				success : function(data, textStatus, jqXHR) {
					if (data.trim() === "done") {
						Swal.fire({
							title : "Post saved successfully!",
							icon : "success",
							draggable : true
						}).then(()=>{
							location.reload();
						});
					} else {
						Swal.fire({
							title : "Something went wrong!",
							icon : "error",
							draggable : true
						});
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					Swal.fire({
						title : "Something went wrong!",
						icon : 'error',
						draggable : true
					})
				},
				processData : false,
				contentType : false,
			})
		})
	})
	</script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<!-- Loading posts... -->
	<script>
		function getPosts(cId,temp){
			$('#loaderPost').show();
			$('#post-container').hide();
			$('.c-link').removeClass('active');

			$.ajax({
				url : 'load-posts.jsp',
				data:{catId:cId},
				success : function(data, textStatus, jqXHR) {
					$('#loaderPost').hide();
					$('#post-container').show();
					$('#post-container').html(data);
					$(temp).addClass('active');
				}
			})
		}
		$(document).ready(function() {
			let allPostRef=$('.c-link')[0];
			getPosts(0,allPostRef);
		})
	</script>

</body>
</html>
