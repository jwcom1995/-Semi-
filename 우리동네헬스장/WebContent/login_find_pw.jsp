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
	.notice{
		left: 0;
		top: 30%;
		width:100%;
		text-align: center;
		margin-top: 70px;
		margin-bottom: 50px;
	}
	.text{
		left: 0;
		top: 50%;
		width:100%;
		text-align: center;
	}
	.button{
		left: 0;
		top: 70%;
		width:100%;
		text-align: center;
		margin-bottom: 70px;
	}
	.text input{
		width:200px;
		height:40px;
	}
	.button input{
		width: 200px;
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
	input{
		margin: 5px;
	}
</style>
<script type="text/javascript" src="js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	function pwchk(){
		var pw1 = document.getElementsByName("userpw")[0].value;
		var pw2 = document.getElementsByName("userpw")[1].value;
		
		if(pw1!=pw2){
			alert("비밀번호 입력 오류");
			return false;
		}
			
		return true;
	}
</script>
<%
	int userno = (int)request.getAttribute("userno");
%>
</head>
<body>
	<header><%@ include file="form/login_header.jsp" %></header>
	<div class="notice">
		<a>새로운 비밀번호를 작성해 주세요.</a>
		<br><br>
		<a style="font-weight:200;">영문,숫자,특수문자를 함께 사용하시면(8자이상 16자 이하)보다 안전합니다.</a>
	</div>
	<form action="usercontroller?command=changepw" method="post" onsubmit="return pwchk()">
	<div class="text">
		<input type="hidden" name="userno" value=<%=userno %>>
		<input type="text" placeholder="새 비밀번호" name="userpw"><br>
		<input type="text" placeholder="새 비밀번호 확인" name="userpw">
	</div>
	
	<div class="button">
	<br>
		<input type="submit" value="확인">
		<br>
		<input type="button" value="취소" style="background-color: gray;" onclick="location.href='usercontroller?command=loginform'">
	</div>
	</form>
	<footer><%@ include file="form/login_footer.jsp" %></footer>
</body>
</html>