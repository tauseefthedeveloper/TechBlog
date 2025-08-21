<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techBlog.dao.PostDao"%>
<%@page import="com.techBlog.dao.CommentDao"%>
<%@page import="com.techBlog.dao.LikeDao"%>
<%@page import="com.techBlog.helper.ConnectionProvider"%>
<%@page import="com.techBlog.entities.Posts"%>
<%@page import="com.techBlog.entities.User"%>


<%
Thread.sleep(500);
CommentDao commDao = new CommentDao(ConnectionProvider.getConnection());
PostDao postDao = new PostDao();
List<Posts> post = null;
int cId = Integer.parseInt(request.getParameter("catId"));
if (cId == 0) {
	post = postDao.getAllPost();
} else {
	post = postDao.getPostByCatId(cId);
}
if (post.size() == 0) {
	out.println("<h3 class='text-danger'" + ">No posts are available.<h3>");
	return;
}
for (Posts p : post) {
%>
<div class="col-md-6 mb-2 border-rounded">
	<div class="card">
		<div class="card-body">
			<img class="card-img-top" style="height: 170px; object-fit: cover;"
				alt="" src="posts_pic/<%=p.getPic()%>"> <b><%=p.getTitle()%></b>
			<p><%=p.getContent()%></p>
		</div>
		<div class="card-footer text-center">
			<%
			LikeDao like = new LikeDao(ConnectionProvider.getConnection());
			User user = (User) session.getAttribute("current_user");
			if (user == null) {
			%>
			<a href="#!" onclick="loginThenLike()"
				class="btn btn-outline-primary btn-sm"> <i
				class="fa fa-thumbs-o-up"></i> <span class="like-count"><%=like.countLikesOnPosts(p.getPid())%></span>
			</a> <a href="#!" onclick="loginThenRead()"
				class="btn btn-outline-primary btn-sm">Read More...</a> <a href="#!"
				onclick="loginThenComment()" class="btn btn-outline-primary btn-sm">
				<i class="fa fa-commenting-o"></i> <span>20</span>
			</a>
			<%
			} else {
			%>
			<a href="#!"
				onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>,this)"
				class="btn btn-outline-primary btn-sm"> <i
				class="fa fa-thumbs-o-up"></i> <span class="like-count"><%=like.countLikesOnPosts(p.getPid())%></span>
			</a> <a href="show_blog_details.jsp?postId=<%=p.getPid()%>"
				class="btn btn-outline-primary btn-sm">Read More...</a> <a
				href="show_blog_details.jsp?postId=<%=p.getPid()%>"
				class="btn btn-outline-primary btn-sm"> <i
				class="fa fa-commenting-o"></i> <span><%=commDao.countCommentOnPosts(p.getPid())%></span>
			</a>
			<%
			if (p.getUserId() == user.getId()) {
			%>
			<a href="#!" style="font-size:20px;" onclick="pleaseGoToPostPage()" class="btn btn-outline-primary btn-sm">
				<i class="fa fa-edit"></i>
			</a> <a href="#!" id="delete-btn" style="font-size:20px;"
				onclick="doDeletePost(<%=p.getPid()%>,<%=user.getId()%>,event)"
				class="btn btn-outline-primary btn-sm"> <i class="fa fa-trash"></i> </a>
			<%
			}
			%>
			<%
			}
			%>
		</div>
	</div>
</div>
<%
}
%>