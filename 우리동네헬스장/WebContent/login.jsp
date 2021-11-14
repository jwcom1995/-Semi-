<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>


<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<style type="text/css">
*{
	margin: 0px;
	padding: 0px;
}

a{
	text-decoration: none;
	color: black;
	font-weight: bold;
}

.wrap{
	width: 100%;
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
}

.login{
	width: 400px;
	height: 530px;
	display: flex;
	position: absolute;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	border: 1px solid grey;
	border-radius: 30px;
	text-align: center;
	margin-bottom: 20px;

}

.logo{
	align-items: center;
}

.login_id{
	margin-top: 30px;
	align-items: center;

}

.login_id input{
	width: 270px;
	height: 40px;
	padding: 0px 15px;
	border-radius: 5px;
	border: 1px solid lightgrey;
}

.login_pw{
	margin-top: 20px;
	align-items: center;
}

.login_pw input{
	width: 270px;
	height: 40px;
	padding: 0px 15px;
	border-radius: 5px;
	border: 1px solid lightgrey;
}

.register{
	margin-top: 15px;
	align-items: center;
	font-size: 0.8em;
}

.submit{
	margin-top: 20px;
}

.submit button{
	width: 250px;
	height: 40px;
	border: 0;
	background-color:rgb(75, 161, 231);
	color: white;
	border-radius: 7px;
}
.cancel button{
	width: 250px;
	height: 40px;
	border: 0;
	background-color: gray;
	color: white;
	border-radius: 7px;
}

.sns_login{
	margin-top: 20px;	
	text-align : center;

}

.sns_login img{ 
	margin-top: 10px;
}
footer{
		position:absolute;
		left: 0;
		bottom:0;
		width: 100%;
}
button{
	cursor:pointer;
}

</style>
<script src="./js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>

	<header></header>
	
	<form action="usercontroller?command=login" method="post">
	<div class="wrap">
		<div class="login">
		
			<div class="logo">
				<a href="main.jsp"><img src="./img/logo.png" width="239" height="114"></a>
			</div>
			<div class="login_id">
				<input type="text" name="user_id" placeholder="아이디">
				
			</div>
			<div class="login_pw">
				<input type="password" name="user_pw" placeholder="비밀번호">
			</div>
			
			<div class="register">
				<a href="usercontroller?command=registform">회원가입</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="usercontroller?command=findidform">아이디 찾기</a>
				&nbsp;&nbsp;
				<a href="usercontroller?command=findpwform">비밀번호 찾기</a>
			</div>
			<br>
			<div class="submit">
			<button type="submit">
				<span>로그인</span>
			</button>
			</div>
			<div class="cancel">
			<br>
			<button type="button" onclick="location.href='main.jsp'">
				<span>취소</span>
			</button>
			</div>
			
		</div>
		
		<div class="push">
		
		</div>
	</div>
	</div>
	</form>
	
	<footer><%@ include file="form\login_footer.jsp" %></footer>	
	
</body>
</html>