<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Something went wrong.</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<style>
		.banner-background{
			background-color:#4242eb;
						clip-path: polygon(50% 0%, 100% 0, 100% 31%, 100% 100%, 79% 91%, 51% 100%, 21% 91%, 21% 91%, 0 100%, 0 0);
			
		}
	</style>
</head>
<body>
	<div class="container text-center">
		<img alt="image not found" src="image/error2.png" class="img-fluid">
		<h3 class="dispaly-3">Sorry something went wrong...</h3>
		<%= exception %>
		<br>
		<a href="/TechBlog" class="btn btn-primary text-white mt-2">Home</a>
	</div>
</body>
</html>