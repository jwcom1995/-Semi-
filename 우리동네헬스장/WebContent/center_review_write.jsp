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
*{
	margin: 0px;
	padding: 0px;
}
	
.wrap{
	width: 100%;
	height: 650px;
	display: flex;
	align-items: center;
	justify-content: center;
}



.review_title h1{
	text-align: center;
	width: 750px;
}	

.review{
	display: flex;
	position: absolute;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

.review_contents{
	width:80%;
}
.grade{
	margin: 25px 340px 0px 0px;
}

.grade a{
	font-size: 14px;
	font-weight: bold;
	padding: 0px 10px 0px 0px;
}

.content{
	display:block;
	margin-top: 5px;
}

.content textarea{
	padding: 10px 10px;
	resize: none; 
	overflow:auto; 
	overflow-x:hidden; 
} 

.regist{
	margin-top: 10px;
}

.regist input{
	width: 75px;
	height: 35px;
	border-radius: 5px;
	border: none;
	font-weight: bold;

}

#submit{
	background: rgb(75, 161, 231);
	color: white;
	cursor:pointer;
}

#close{
	background: grey;
	color: white;
	cursor:pointer;
}

#textarea_review{
	width:100%;
}
.star-rating{
	width:128px;
	margin-left:5px;
}
.star-rating,.star-rating span{
	display:inline-block;
	height:24px;
	overflow:hidden;
	background:url("img/stars_empty.png") no-repeat;
}
.star-rating span{
	background:url("img/stars_filled.png") no-repeat;
	background-position:left bottom;
	line-height:0;
	vertical-align:top;
	width:100%;
}
input[name=star_range]{
	margin-left:50px;
}
</style>

<script type="text/javascript"	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	function star_change(){
		var range_value=$('input[name=star_range]').val();
		document.getElementById("star_fill").style.width = (range_value*20)+"%";
		$('#grade_score').empty();
		$('#grade_score').append("("+range_value+"점)");
	}
</script>
</head>
<body>

	<header><%@ include file="form\header.jsp" %></header>
	
	<form action="CenterController?command=review_write" method="post">
	<input type="hidden" name="centerno" value="${centerno}">
	<input type="hidden" name="userid" value="${loginUser.userid}">
	<div class="wrap">
	<div class="review">
	<div class="review_title">
		<h1>이용후기 작성</h1>
		<br>
		<hr>
	</div>
	<div class="review_contents">
	<div class="grade">
		<a>별점:</a>
		<span class="star-rating">
                    	<span id="star_fill"></span>
        </span><span id="grade_score"></span>
		<input name="star_range" type="range" min="0" max="5" value="5" step="0.5" onchange="star_change()">
	</div>
	
	<div class="content">
		<textarea id ="textarea_review" rows="17" name="reviewcontent" placeholder="후기를 작성해주세요."></textarea>
	</div>
	</div>	
	<div class="regist">
		<input type="submit" value="등 록" id="submit" >&nbsp;&nbsp;
		<input type="button" value="닫 기" id="close" onclick="location.href='CenterController?command=centerdetail&centerno=${centerno}'">
	</div>

	</div>
	</div>
	</form>
	
	<footer><%@ include file="form\footer.jsp" %></footer>	
</body>
</html>