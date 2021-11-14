<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div{
		width: 100%;
	}
	div a{
		color:black;
		font-weight: bold;
		padding: 2px;
		text-decoration: none;
	}
	.fd:hover{
		color:skyblue;
	}
</style>
</head>
<body>
	<div>
		<br><br>
		<h2><a href="">&nbsp;아이디 비밀번호 찾기</a></h2>
		<br><br>
		<a href="usercontroller?command=findidform" class="fd">&nbsp; 아이디 찾기</a>&nbsp;
		<a href="usercontroller?command=findpwform" class="fd"> 비밀번호 찾기</a>
		<hr>
	</div>
</body>
</html>