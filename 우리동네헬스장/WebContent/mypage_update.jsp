<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ page import = "com.user.dto.UserDto" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table{
		text-align: center;
		border-collapse: separate;
  		border-spacing: 0 15px;
	}
	td input[type="text"], input[type="password"] {
    	width: 350px; height: 30px;
    	font-size: 0.8rem;
    	border: 1px solid #d1d1d1;
	}
	th {
    	margin: 10px 0 8px;
   		font-size: 1.0rem;
   		font-weight: 400;
    	text-align: left;
	}
	#wrap{
		display: flex;
  		justify-content: center;
	}
	#submit, #reset{
		cursor:pointer;
	}
	#submit{
		width : 80px;
	 	height : 30px;
		background-color:rgb(75, 161, 231);
		border: 1px solid gray;
		border-radius: 5px;
	}
	#reset{
		width : 80px;
	 	height : 30px;
		background-color:#d1d1d1;
		border: 1px solid gray;
		border-radius: 5px;
	}
</style>
</head>
<body>
<header><%@ include file="./form/header.jsp" %></header>	
<h2 align="center">마이 페이지</h2>
<div>
	<hr size="1" width="500%">
</div>
<div id="wrap">
	<form action="MainController" method="post">
	<input type="hidden" name="command" value="update">
	<input type="hidden" name="userno" value="<%=loginUser.getUserno() %>">
		<table>
		<col width="150px"><col width="300px">
			<tr>
				<th>성 명</th>
				<td><input type="text" name="name" autofocus value="<%=loginUser.getUsername()%>"></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id" value="<%=loginUser.getUserid()%>"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pw" value="<%=loginUser.getUserpw()%>"></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="phone" value="<%=loginUser.getUserphone()%>"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" value="<%=loginUser.getUseremail()%>"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="addr" value="<%=loginUser.getUseraddr()%>"></td>
			</tr>
		</table>
		<div align="center">
				<input type="submit" id="submit" value="수정 완료">
				<input type="button" id="reset" value="취 소" onclick="location.href='usedcontroller?command=mypage'">
		</div>		
	</form>
</div>
	<footer><%@ include file = "form/footer.jsp" %></footer>
</body>
</html>