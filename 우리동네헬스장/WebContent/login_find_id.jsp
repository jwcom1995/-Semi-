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
	
	.button{
		position: relative;
		top: 65%;
		left:0;
		text-align: center;
		margin-bottom: 100px;
	}
	.button input{
		width: 170px;
		height: 40px;
		font-size: 15px;
		font-weight:200;
		color: white;
		margin: 5px;
		background-color:rgb(75, 161, 231);
		cursor: pointer;
		border-radius: 5px;
		border: 0;
	}
	.notice{
		position: relative;
		top: 50%;
		left:0;
		text-align: center;
		margin-top: 100px;		
	}
</style>
</head>
<%
	String userid = (String)request.getAttribute("userid");
%>
<body>
	<header><%@ include file="form/login_header.jsp" %></header>
	
	<div class="notice">
		<a>찾으시는 아이디는</a>
		<br><br><br>
		<a><%=userid %> 입니다</a>
	</div>
	<br><br><br><br><br><br>
	<div class="button">
		<input type="button" id="login" value="로그인 하기" onclick="location.href='usercontroller?command=loginform'"><br>
		<input type="button" style="background-color: grey;" onclick="location.href='usercontroller?command=findpwform'" id="find_pw" value="비밀번호 찾기" >
	</div>
	<footer><%@ include file="form/login_footer.jsp" %></footer>
</body>
</html>