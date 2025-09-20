<%@ page import="com.techBlog.entities.User"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark primary-background">
    <div class="container-fluid">
        <a class="navbar-brand" href="/TechBlog">
            <span class="fa fa-file-code-o"></span>&nbsp;TechBlog
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <!-- Left Side Menu -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/TechBlog">
                        <span class="fa fa-home"></span> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="profile.jsp">
                        <span class="fa fa-pencil"></span> Posts
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="contact.jsp">
                        <span class="fa fa-phone"></span> Contact
                    </a>
                </li>
                <%
                    User user = (User) session.getAttribute("current_user");
                    if (user == null) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">
                        <span class="fa fa-user-circle"></span> Login
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">
                        <span class="fa fa-user-plus"></span> Register
                    </a>
                </li>
                <% } %>
            </ul>

            <!-- Right Side Menu -->
            <ul class="navbar-nav ms-auto">
                <%
                    if (user != null) {
                %>
                <li class="nav-item">
                    <a href="#!" class="nav-link" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        Welcome, <%= user.getName() %>
                        <img src="<%= user.getProfile() != null && !user.getProfile().isEmpty() ? user.getProfile() : "pic/default.png" %>" 
     						alt="Profile" style="height:25px; width:25px; border-radius:50%; margin-left:5px;">
		
                    </a>
                </li>
                <li class="nav-item">
                    <a href="Logout" class="nav-link">
                        <span class="fa fa-external-link"></span> Logout
                    </a>
                </li>
                <%
                    } else {
                %>
                <li class="nav-item">
                    <a href="#!" class="nav-link" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        Welcome, User
                        <img src="pic/default.png" alt="Profile"
                             style="height: 25px; width: 25px; border-radius: 50%; margin-left: 5px;">
                    </a>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
