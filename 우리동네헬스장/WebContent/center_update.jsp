<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>센터 정보 수정</title>

<script type="text/javascript"	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	
</script>

<style type ="text/css">
header, section, article, aside, main, nav, footer{
    display: block;
}
h1, p{
    margin: 0;
}
#title hr{
	height:3px;
	background-color:#036;
}
.information a{
    text-decoration: none;
    color:black;
    font-weight:bold;
}
#main{
    width: 80%;
    height: auto;
    margin: 0 auto;
}
.main_title{
	text-align : center;
}
#main .wrap .top_cont{
    font-size: 0;
}
#main .wrap .top_cont .img_part{
    display: inline-block;
    vertical-align: middle;
}
#main .wrap .top_cont .img_part img{
    margin: 10px;
    width: 200px;
    height: 200px;
}
#main .wrap .top_cont .txt_part{
    display: inline-block;
    vertical-align: middle;
    padding-left: 50px;
}
#main .wrap .top_cont .txt_part p{
    display: block;
    font-size: 20px;
    padding-bottom: 20px;
}
.information{
	text-align : center;
    word-spacing : 60px;
}
#main .information a{
    margin: 0 15px;
}

.cont{
	display:flex;
	width:90%;
	margin-left:5%;
	justify-content:center;
	align-items: center;
	margin-bottom:25px;
}
.cont_head{
	min-width:200px;
	height:50px;
	width:20%;
	border-right: 3px solid #036;
}
.cont_head2{
	min-width:200px;
	height:50px;
	width:20%;
}
.cont_info{
	width:80%;
	padding:8px;
}

.cont_info2{
	width:80%;
	padding:8px;
	border-left: 3px solid #036;
}
.cont_button{
	align-self: center;
}
#zip_chk{
	display:block;
	margin-bottom:18px;
}
.img_cont, .review_cont{
	width:90%;
	margin-left:5%;
	height: auto;
}
.cont_images img{
	width:300px;
	height:200px;
}

.txt_part{
	font-size:18px;
}
input[type=text]{
	width:100%;
	height:30px;
}
textarea{
	width:100%;
	resize:none;
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

table{
	border-collapse: separate;
	border-spacing: 0 20px;
}
table th{
	border-right: 3px solid #036;
}

</style>
</head>
<body>
<header><%@ include file = "./form/header.jsp" %></header>
	<div id="main">
		<div id="title">
		<br><br>
		<h1 align="left">센터 정보 수정</h1><br><hr>
		</div>
		<br>
		<form action="CenterController?command=centerupdate" method="post">    
			<input type="hidden" name="centerno" value="${centerDto.centerno}">
	            <div class="text_cont">
	            	<div class="cont">
	                    <div class="cont_head">
	                        <h3 id="a">센터이름</h3>
	                    </div>
	                    <div class="cont_info">
	                    	<input type="text" name="centernm" readonly value="${centerDto.centername}">
	                    </div>
	                </div>
	                <div class="cont">
	                    <div class="cont_head">
	                        <h3 id="a">센터위치</h3>
	                    </div>
	                    <div class="cont_info">	                    	
	                    	<input type="text" name="centeraddr" id="sample4_roadAddress" readonly value="${centerDto.centeraddr}">
	                    </div>
	                </div>
	                <div class="cont">
	                    <div class="cont_head">
	                        <h3 id="a">가격</h3>
	                    </div>
	                    <div class="cont_info">
	                    	<input type="text" name="centerprice" value="${centerDto.centerprice}">
	                    </div>
	                </div>
	                <div class="cont">
	                    <div class="cont_head">
	                        <h3 id="a">센터종류</h3>
	                    </div>
	                    <div class="cont_info">
	                    	<input type="checkbox" name="health" value="헬스">헬스
							<input type="checkbox" name="pilates" value="필라테스">필라테스
							<input type="checkbox" name="yoga" value="요가">요가
							<input type="checkbox" name="crossfit" value="크로스핏">크로스핏
							<input type="checkbox" name="etc" value="기타">기타
	                    </div>
	                </div>
	                <div class="cont">
	                    <div class="cont_head2">
	                        <h3 id="a">센터소개</h3>
	                    </div>
	                    <div class="cont_info2">
	                    	<textarea rows="10" name="centerintro" >${centerDto.centerintro}</textarea>
	                    </div>
	                </div>
	                <div class="cont">
	                	<div class="cont_head2">
	                		<h3 id="b">이용정보</h3>
	                	</div>
	                    <div class="cont_info2">
	                    	<textarea rows="10" name="centercontent">${centerDto.centercontent}</textarea>
	                    </div>
	                </div>
	                <div class="cont">
	                	<div class="cont_head2">
	                		<h3 id="c">운영시간</h3>
	                	</div>
	                    <div class="cont_info2">
	                    	<textarea rows="10" name="centerophour">${centerDto.centerophour}</textarea>
	                    </div>
	                </div>
	                <div class="cont">
	                	<div class="cont_head2">
	                		<h3 id="d">프로그램</h3>
	                	</div>
	                    <div class="cont_info2">
	                    	<textarea rows="10" name="centerpro">${centerDto.centerpro}</textarea>
	                    </div>
	                </div>
	            </div>
	            <div class="submit_btn" align="center">
	            	<input class="ip_button" type="submit" value="수정">	
					<input class="ip_button" type="button" value="취소" onclick="location.href='CenterController?command=centerdetail&centerno=${centerDto.centerno}'">
	       		</div>
      	</form>
	</div>
<header><%@ include file = "./form/footer.jsp" %></header>
</body>
</html>