<%@page import="com.techBlog.entities.Posts"%>
<%@page import="com.techBlog.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.techBlog.entities.User"%>
<%@ page import="com.techBlog.entities.Comments"%>
<%@ page import="com.techBlog.entities.Message"%>
<%@ page import="com.techBlog.entities.RepliesOnComment"%>
<%@ page import="com.techBlog.dao.PostDao"%>
<%@ page import="com.techBlog.dao.CommentDao"%>
<%@ page import="com.techBlog.helper.TimeAgo"%>
<%@ page import="com.techBlog.dao.RepliesDao"%>
<%@ page import="com.techBlog.dao.LikeDao"%>
<%@ page import="com.techBlog.entities.Categories"%>
<%@ page import="com.techBlog.helper.ConnectionProvider"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.sql.Timestamp"%>
<%@page errorPage="error.jsp"%>
<%
User user = (User) session.getAttribute("current_user");
if (user == null) {
	response.sendRedirect("login.jsp");
}
int postId = Integer.parseInt(request.getParameter("postId"));
PostDao postDao = new PostDao();
Posts p = postDao.getPostByPostId(postId);

CommentDao commDao = new CommentDao(ConnectionProvider.getConnection());
List<Comments> commentsList = commDao.getCommentsByPostIdUserId(postId);
%>
<html>
<head>
<title><%=p.getTitle()%>|| TechBlog</title>
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
<style>
.banner-background {
	background-color: #4242eb;
	color: white;
	height: 300px;
	clip-path: polygon(50% 0%, 100% 0, 100% 31%, 100% 100%, 79% 91%, 51% 100%, 21% 91%,
		21% 91%, 0 100%, 0 0);
}

.post-title {
	font-weight: 100;
	font-size: 25px;
}

.post-content {
	font-weight: 100;
	font-size: 18px;
}

.post-code {
	
}

.post-date {
	font-style: italic;
	font-weight: bold;
	font-size: 15px;
}

.post-user {
	font-size: 15px;
	font-style: italic;
	font-weight: bold;
}

.row-user {
	border: 1px solid #e2e2e2;
	padding-top: 13px;
}

.show-all-details {
	background: white;
	padding: 30px 40px;
	border-radius: 12px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
	width: 100%;
	text-align: center;
	position: relative;
	z-index: 1;
}

@media ( max-width : 576px) {
	.banner-background {
		clip-path: none !important;
		background-color: #4242eb;
	}
}
</style>
<link rel="icon" type="image/png" href="image/TechBlog2.png">

</head>
<body>
	<div id="fb-root"></div>
	<script async defer crossorigin="anonymous"
		src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v23.0"></script>
	<!-- start of navbar -->

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
					<li class="nav-item"><a class="nav-link" href="profile.jsp"><span
							class="fa fa-user"></span> Profile</a></li>
					<li class="nav-item"><a href="#!" data-bs-toggle="modal"
						data-bs-target="#add-post-modal" class="nav-link"><span
							class="fa fa-edit"></span> Do Post</a></li>
				</ul>
				<ul class="navbar-nav mr-right">
					<li class="nav-item">
					<li class="nav-item">
						<%
						if (user == null) {
						%> <%
 } else {
 %> <a href="#!" class="nav-link" data-bs-toggle="modal"
						data-bs-target="#exampleModal"> <img
							src="pic/<%=user.getProfile()%>" alt="Profile"
							style="height: 25px; width: 25px; border-radius: 50%; margin-right: 0px;">
							<%=user.getName()%>
					</a>
					</li>
					<li class="nav-item"><a href="Logout" class="nav-link"> <span
							class="fa fa-external-link"></span> Logout
					</a></li>
					<%
					}
					%>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- end of navbar -->
	<main class="banner-background"></main>
	<!-- main content of body -->
	<main>
		<div class="container" style="margin-top: -285px;">
			<div class="row my-4 show-all-details">
				<div class="col-md-6 offset-md-3">
					<div class="card">
						<div class="card-header bg-primary text-white">
							<h4 class="post-title"><%=p.getTitle()%></h4>
						</div>
						<div class="card-body">
							<img class="card-img-top my-2"
								style="height: 170px; object-fit: cover;" alt=""
								src="posts_pic/<%=p.getPic()%>">
							<div class="row my-3 row-user">
								<div class="col-md-7">
									<%
									UserDao dao = new UserDao(ConnectionProvider.getConnection());
									User cu = dao.getUserByUserId(p.getUserId());
									%>
									<p class="post-user">
										<a href="#!"><%=cu.getName()%></a> has posted:
									</p>
								</div>
								<div class="col-md-5">
									<p class="post-date"><%=TimeAgo.toTimeAgo(p.getDate().toLocalDateTime())%></p>
								</div>
							</div>
							<p class="post-content"><%=p.getContent()%></p>
							<br> <br>
							<div class="post-code">
								<pre><%=p.getCode()%></pre>
							</div>
						</div>
						<div class="card-footer text-center">
							<%
							LikeDao like = new LikeDao(ConnectionProvider.getConnection());
							%>
							<a href="#!"
								onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>,this)"
								class="btn btn-outline-primary btn-sm"> <i
								class="fa fa-thumbs-o-up"></i> <span class="like-count"><%=like.countLikesOnPosts(p.getPid())%></span>
							</a> <a href="#!" class="btn btn-outline-primary btn-sm"> <i
								class="fa fa-commenting-o"></i> <span><%=commDao.countCommentOnPosts(p.getPid())%></span>
							</a>
						</div>
						<div class="card-footer">
							<div class="container mt-5">
								<!-- Comment Form -->
								<div class="card shadow-sm border-0">
									<div class="card-body">
										<h5 class="card-title mb-2">Leave a Comment</h5>
										<form id="addComment" class="commentForm" action="CommentServlet" method="POST">
											<div class="mb-2">
												<textarea id="commentMessage" name="commentMessage"
													class="form-control" rows="2"
													placeholder="Write your comment here..."></textarea>
												<!-- Hidden fields to send extra data -->
												<input type="hidden" id="postId" name="postId" value="">
												<input type="hidden" id="userId" name="userId" value="">
												<input type="hidden" id="commentId" name="commentId"
													value="">
											</div>
											<button id="submitCommentBtn" type="submit"
												class="btn btn-primary btn-sm">Post Comment</button>
										</form>
									</div>
								</div>

								<!-- Comments List -->
								<div class="mt-4">
									<h6><%=commDao.countCommentOnPosts(p.getPid())%>
										Comments
									</h6>

									<!-- Single Comment -->
									<%
									if (commentsList != null && !commentsList.isEmpty()) {
										for (Comments c : commentsList) {
									%>
									<div class="card border-0 shadow-sm mb-3">
										<div class="card-body">
											<div class="d-flex">
												<div class="flex-grow-1">
													<div
														class="d-flex justify-content-between align-items-center mb-1">
														<!-- Left: Profile + Name -->
														<div class="d-flex align-items-center">
															<img src="pic/<%=user.getProfile()%>" alt="Profile"
																style="height: 25px; width: 25px; border-radius: 50%; margin-right: 6px;">
															<strong><%=user.getName()%></strong>
														</div>

														<!-- Right: Time -->
														<small class="text-muted"> • <%=TimeAgo.toTimeAgo(c.getrDate().toLocalDateTime())%>
														</small>
													</div>

													<!-- Comment message -->
													<p class="mb-1 " style="text-align: left;"><%=c.getCommentMessage()%></p>

													<!-- Reply button -->
													<div
														style="display: flex; align-items: center; justify-content: flex-end;">
														<button class="btn btn-link btn-sm p-0 parentReply3"
															style="margin-right: 10px"
															onclick="deleteParentComment(event,<%=p.getPid()%>,<%=user.getId()%>,<%=c.getCommentId()%>)">Delete</button>
														<button class="btn btn-link btn-sm p-0 parentReply2"
															style="margin-right: 10px"
															onclick="editParentComment(event,<%=p.getPid()%>,<%=user.getId()%>,<%=c.getCommentId()%>,'<%=c.getCommentMessage()%>')">Edit</button>
														<button class="btn btn-link btn-sm p-0 reply-btn">Reply</button>
													</div>
													<!-- Hidden reply form -->
													<div class="reply-form mt-2" style="display: none;">
														<textarea id="replyMessage" name="commentMessage"
															class="form-control mb-2" rows="2"
															placeholder="Write your reply..."></textarea>
														<button id="send-reply"
															data-comment-id="<%=c.getCommentId()%>"
															class="btn btn-primary btn-sm">Send</button>
													</div>

													<!-- Replies Container -->
													<!-- Replies -->
													<div class="card-body pt-0 mt-2">
														<h6 style="text-align: left;">Replies12:</h6>
														<%
														RepliesDao replyDao = new RepliesDao(ConnectionProvider.getConnection());
														List<Map<String, Object>> replyList = replyDao.getReplies(c.getCommentId(), postId);
														%>
														<div class="ms-4 border-start ps-3">
															<%
															if (!replyList.isEmpty()) {
																for (Map<String, Object> repTem : replyList) {
															%>
															<div class="mb-2 " id="parentContainer">
																<div
																	class="d-flex justify-content-between align-items-center mb-1">
																	<h6 class="mb-0 fw-bold">
																		<img src="pic/<%=repTem.get("replyUserProfile")%>"
																			alt="Profile"
																			style="height: 25px; width: 25px; border-radius: 50%; margin-right: 6px;">
																		<%=repTem.get("userName")%></h6>
																	<small class="text-muted"><%=TimeAgo.toTimeAgo(((Timestamp) repTem.get("RDate")).toLocalDateTime())%></small>
																</div>
																<p id="messageForEditBox" class="mb-1" style="text-align: left; width: 100%" data-messageforedit="<%=repTem.get("replyMessage")%>"><%=repTem.get("replyMessage")%></p>
																<div
																	style="display: flex; align-items: center; justify-content: flex-end;">
																	<button class="btn btn-link btn-sm p-0 childReply3"
																		style="margin-right: 10px" onclick="deleteChildReply(event,<%=repTem.get("replyId")%> ,<%=repTem.get("commId") %>,<%=repTem.get("postId")%>,<%=repTem.get("userId") %>)">Delete</button>
																	<button class="btn btn-link btn-sm p-0 childReply2"
																		style="margin-right: 10px">Edit</button>
																	<button class="btn btn-link btn-sm p-0 reply-btn2">Reply</button>
																</div>
																<div class="reply-edit-form3" style="display: none;">
																<p style="text-align:left;font-size:14;font-weight:500;color:red;">Please edit carefully!</p>
																	<textarea name="commentEditMessage"
																		class="form-control mb-2 replyeditMessage" rows="2"
																		placeholder="Write your reply..."></textarea>
																	<button id="send-edit-reply2" class="btn btn-primary btn-sm" 
																	onclick="EditChildReply(event,<%=repTem.get("replyId")%> ,<%=repTem.get("commId") %>,<%=repTem.get("postId")%>,<%=repTem.get("userId") %>)">Update Reply</button>
																</div>
																<div class="reply-form2 mt-2" style="display: none;"
																	data-parent-id="<%=repTem.get("replyId")%>">
																	<p style="text-align:left;font-size:14;font-weight:500;color:red;">Please reply carefully after reply message can't change!</p>
																	<textarea id="replyMessage2" name="commentMessage"
																		class="form-control mb-2" rows="2"
																		placeholder="Write your reply..."></textarea>
																	<button id="send-reply2"
																		data-comment-id="<%=c.getCommentId()%>"
																		class="btn btn-primary btn-sm">Send</button>
																</div>
																<div style="font-size: 12px"
																	id="nested-replies-$<%=(int) repTem.get("replyId")%>"
																	class="card-body ms-5 border-start ps-3">

																	<p
																		style="text-align: left; font-size: 14px; font-weight: 500">Replies:</p>
																	<%
																	RepliesDao replyDao2 = new RepliesDao(ConnectionProvider.getConnection());
																	List<Map<String, Object>> childReplies = replyDao2.getReplies2((int) repTem.get("commId"), (int) repTem.get("replyId"));

																	if (!childReplies.isEmpty()) {
																		for (Map<String, Object> child : childReplies) {
																	%>

																	<div class="card-body pt-0 mt-2">
																		<h6 style="text-align: left">
																			<img src="pic/<%=child.get("replyUserProfile")%>"
																				style="height: 16px; width: 16px; border-radius: 50%; margin-right: 6px; font-size: 10px">
																			<%=child.get("userName")%>
																			<span style="font-size:12px"><%=TimeAgo.toTimeAgo(((Timestamp) child.get("createdAt")).toLocalDateTime()) %></span>
																		</h6>
																		<p style="font-size: 16px; text-align: left;"><%=child.get("replyText")%></p>
																	</div>
																	<%
																	}
																	}
																	%>

																</div>
																<%
																}
																} else {
																%>
																<div class="ms-4 border-start ps-3">
																	<p>No reply yet.</p>
																</div>
																<%
																}
																%>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>

										<%
										}
										} else {
										%>
										<p>No comments yet.</p>
										<%
										}
										%>

									</div>
								</div>

								<!-- for facebook plugin after live-->
								<div class="fb-comments"
									data-href="http://localhost:8080/TechBlog/show_blog_details.jsp?postId=<%=p.getPid()%>"
									data-width="" data-numposts="5"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- end of main content of body -->

	<!-- modal -->

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

	<!-- end modal -->
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
	<%int replypid2 = Integer.parseInt(request.getParameter("postId"));
int replyuid2 = user.getId();%>
$(document).ready(function(){

    // Show/hide reply form
    $(document).on("click", ".reply-btn2", function(){
        $(this).closest('div').next(".reply-form2").toggle();
    });

    // Submit reply via AJAX
    $(document).on("click", "#send-reply2", function(){
    	event.preventDefault();
        let commentId2 = $(this).data("comment-id")
        let replyMessage2 = $("#replyMessage2").val()
        let postId2=<%=replypid2%>;
        let parent_reply_id = $(this).closest(".reply-form2").attr("data-parent-id");
        let userId2=<%=replyuid2%>;
		console.log("Id:"+commentId2+" message:"+replyMessage2+" postId:"+postId2+" userId:"+userId2+" parent_reply_id:"+parent_reply_id);
        if(replyMessage2.trim() === ""){
            Swal.fire({
				title : "Reply cannot be empty!",
				icon : "error",
				draggable : true
			});
            return;
        }
        doReply2(commentId2,replyMessage2,postId2,userId2,parent_reply_id);
    });

});
</script>
	<script>
	<%int replypid = Integer.parseInt(request.getParameter("postId"));
int replyuid = user.getId();%>
  $(document).ready(function(){

    // Show/hide reply form
    $(document).on("click", ".reply-btn", function(){
        $(this).closest("div").next('.reply-form').toggle();
    });

    // Submit reply via AJAX
    $(document).on("click", "#send-reply", function(){
    	event.preventDefault();
        let commentId = $(this).data("comment-id")
        let replyMessage = $("#replyMessage").val()
        let postId=<%=replypid%>;
        let userId=<%=replyuid%>;
		console.log("Id:"+commentId+" message:"+replyMessage+" postId:"+postId+" userId:"+userId);
        if(replyMessage.trim() === ""){
            Swal.fire({
				title : "Reply cannot be empty!",
				icon : "error",
				draggable : true
			});
            return;
        }
        doReply(commentId,replyMessage,postId,userId);
    });

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

			})
		})
	</script>
	<!-- add-post script -->
	<%
	int pid = Integer.parseInt(request.getParameter("postId"));
	int uid = user.getId();
	%>
	<script>
	$(document).ready(function () {
	    $(document).on("submit", ".commentForm", function (event) {
	        event.preventDefault();
	        const pidEdit = $("#postId").val();
	        const uidEdit = $("#userId").val();
	        const cidEdit = $("#commentId").val();
	        let commentMessage = $("#commentMessage").val();

	        if (commentMessage.trim() === "") {
	            Swal.fire({
	                title: "Please add a comment!",
	                icon: "error",
	                draggable: true
	            });
	            return;
	        }

	        let action = $(this).attr("action");

	        if (action == "EditComment") {
	            doEditComment(pidEdit, uidEdit, cidEdit, commentMessage);
	        } else {
	            doComment(<%=pid%>, <%=uid%>, commentMessage);
	        }
	    });
	});

	</script>
	<script type="text/javascript">
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
						if (data.trim() == "done") {
							Swal.fire({
								title : "Post saved successfully!",
								icon : "success",
								draggable : true
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

	<script type="text/javascript">
		function getPosts(cId, temp) {
			$('#loaderPost').show();
			$('#post-container').hide();
			$('.c-link').removeClass('active');

			$.ajax({
				url : 'load-posts.jsp',
				data : {
					catId : cId
				},
				success : function(data, textStatus, jqXHR) {
					$('#loaderPost').hide();
					$('#post-container').show();
					$('#post-container').html(data);
					$(temp).addClass('active');
				}
			})
		}
		$(document).ready(function() {
			let allPostRef = $('.c-link')[0];
			getPosts(0, allPostRef);
		})
	</script>
	<!-- delete the comments -->
	<script>
	function editParentComment(event,postId,userId,commentId,message){
		$('#commentMessage').text(message);
		$('#submitCommentBtn').text("Update Comment");
		$('#addComment').attr("action", "EditComment");

		$('#postId').val(postId);
	    $('#userId').val(userId);
	    $('#commentId').val(commentId); 
   }
	function deleteParentComment(event,postId,userId,commentId){
		event.preventDefault();
		const d={
			postId:postId,
			userId:userId,
			commentId:commentId,
			operation:'commentDelete',
		};
		console.log(postId,userId,commentId);
		$.ajax({
			url:'Delete',
			data:d,
			type:'POST',
			success:function(data){
				if(data.trim()=="true"){
					Swal.fire({
						title: "Post deleted successfully!",
						icon: "success",
						draggable: true
					}).then(() => {
						location.reload();
					});
				}else{
					Swal.fire({
						title:"Comment not deleted!",
						icon:"success",
						draggable:true
				    });
				}
			},
			error: function(xhr, status, error) {
		        console.error(error);
		    },
		});
	}
	</script>
</body>
</html>