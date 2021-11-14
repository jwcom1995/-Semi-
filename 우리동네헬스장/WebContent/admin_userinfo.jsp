<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저페이지(관리자)</title>
<style type="text/css">
#wrap{
	width: 80%;
	margin: 0 auto;
}
hr{
	height:3px;
	background-color:#036;
}
.information{
	text-align:center;
}
.mylist{
	margin-left : auto;
	margin-right : auto;
	border-spacing : 40px;
}
#list{
	vertical-align:top; 
}
.function{
	text-align:center;
	letter-spacing : 15px;
}
td input[type="text"], input[type="email"], input[type="tel"] {
	width: 450px; height: 30px;
    font-size: 0.8rem;
    border: 1px solid #d1d1d1;
}
#writed_list table{
	border-collapse: collapse;
}
#writed_list table th{
	border-bottom: 3px solid #036;
}
#writed_list a{
	text-decoration:none;
	color:black;
	font-weight:bold;
}
.ip_button{
	margin-top:10px;
	margin-left:10px;
	background: rgb(00,68,137);
	font-weight:bold;
	color : white;
	width:80px;
	height:30px;
	border-radius: 5px;
	cursor:pointer;
	outline:none;
	box-shadow:none;
	border:none;
}
</style>
</head>
<body>
<header><%@ include file="./form/header.jsp" %></header>
<div id="wrap">
<br><br>
<h2 class="information">사용자 정보</h2>
	<hr>
	<table class="mylist">
		<col width="150px"><col width="300px">
		<tr>
			<th>성명</th>
			<td><input type="text" value="${userDto.username}" readonly></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td><input type="text" value="${userDto.userid}" readonly></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><input type="tel" value="${userDto.userphone}" readonly></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="email" value="${userDto.useremail}" readonly></td>
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" value="${userDto.useraddr}" readonly></td>
		</tr>
		<tr>
			<th id="list">작성한 글 목록</th>
			<td>
				<div id="writed_list">
				<table border="1" width="100%" height="100px">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
						<c:when test="${!empty usedlist }">
						<c:forEach items="${usedlist}" var = "used">
							<tr>
								<td align="center">${used.usedno }</td>
								<td><a href="usedcontroller?command=useddetail&usedno=${used.usedno}">${used.usedtitle }</a></td>
								<td align="center">${used.usedreg }</td>
							</tr>
						</c:forEach>
						</c:when>
						</c:choose>
					</tbody>
				</table>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="function">
			<input class="ip_button" type="button" value="수정" onclick="location.href='MainController?command=updatestart&userno=${userDto.userno}'">
			<input class="ip_button" type="button" value="탈퇴" onclick="location.href='MainController?command=deleteinfo&userno=${userDto.userno}'">
			<input class="ip_button" type="button" value="목록" onclick="location.href='MainController?command=adminpage&act=user'">
			</td>
		</tr>
	</table>
</div>
<footer><%@ include file="./form/footer.jsp" %></footer>
</body>
</html>