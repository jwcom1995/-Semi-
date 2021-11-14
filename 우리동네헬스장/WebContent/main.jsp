<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<style type="text/css">
	html, body{
		margin:0;
		width:100%;
		height:100%;
	}
	#search{	
		opacity: 1;
		display:flex;
		align-items:center;
		justify-content:center;
	}
	#body{
		z-index:1;
		width:100%;
		height: 70%;
	}
	#white_space{
		width:100%;
		height: 10%;
		background-color:white;
	}
	#body::after{
		background-image:url('img/background_main.jpg');
		background-size:cover;
		background-repeat:no-repeat;
		content:"";
		position:absolute;
		top:30%;
		opacity: 0.5;
		z-index:-1;
		width:100%;
		height:65%;
	}
	input[type=text]{
		width:55%;
		height:60px;
		font-size:18px;
	}
	#icon_nav{
		display:flex;
		height:160px;
		opacity: 1;
		justify-content:center;
		flex-direction: row;
		text-align:center;
	}
	.icon_subnav{
		margin-left:3%;
		margin-right:3%;
		width:160px;
		background-color:rgb(00,68,137);
		border-radius: 50px;
	}
	.icon_subnav img{
		border-radius: 30%;
		width:120px; height:120px;
	}
	.icon_subnav a{
		text-decoration: none;
		font-weight:bold;
		color:white;
	}
</style>
<script type="text/javascript">
	 function enrollment(){
       if(${loginUser==null}){
        	if(confirm("로그인이 필요한 페이지입니다.\n 로그인 하시겠습니까?")){
        		location.href="login.jsp";
        	}else{
        	}
       } else{	
    	   location.href="usercontroller?command=business&user_no=${ loginUser.userno }";
        		}
       }
</script>
</head>
<body>
	<header>
		<%@ include file="./form/header.jsp" %>
	</header>
	<div id="white_space">
	</div>
	<div id="body">
		<br><br><br><br><br><br>
        <div id="search">
            <img src="img/icon_search.png" width ="60px" height="60px" href ="main.jsp">
            <input type="text" placeholder="     ex)서울시 성북구">
        </div>
        <br><br><br>
        <div id="icon_nav">
        	<div class="icon_subnav">
            	<a href="CenterController?command=centerlist"><img src="img/icon_center.png" ><br>스포츠 센터 목록</p></a>
            </div>
            <div class="icon_subnav">
            	<a href="#" onclick="javascript:enrollment();"><img src="img/icon_business.png"><br>사업자 등록</a>
            </div>
            <div class="icon_subnav">
            	<a href="usedcontroller?command=usedlist"><img src="img/icon_used.png"><br>중고거래</a>
            </div>
            <div class="icon_subnav">
            	<a href="qna.jsp?seid=${loginUser.userid}"><img src="img/icon_qna.png"><br>Q&A</a>
            </div>
        </div>
        <br><br><br>
    </div>
    </div>
    <footer>
		<%@ include file="./form/footer.jsp" %>
	</footer>
</body>
</html>