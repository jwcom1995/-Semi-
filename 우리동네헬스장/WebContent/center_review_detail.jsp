<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세보기</title>
<style type="text/css">
*{
	margin: 0px;
	padding: 0px;
}
#title{
	width:465px;
	padding:25px;
	box-sizing: border-box;
}
.wrap{
	width:510px;
	height: 475px;
	display: flex;
	align-items: center;
	justify-content: center;

}
.review_detail{
	border: 2px solid rgb(93, 93, 93);
	padding: 20px;
	border-radius: 10px;
	box-sizing: border-box;
}
.headline a{
	align-items: left;
	font-weight: bold;
	color: rgb(93, 93, 93);
}
.content{
	margin-top: 15px;
}
.ip_button{
	margin-top:10px;
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
#cont_text{
	width:400px;
	height:300px;
	margin-top:15px;
	padding:10px;
	resize:none;
	border-radius: 10px;
	border:1px solid black;
}
/*별점 구현*/
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
}
</style>
<script type="text/javascript"	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		//접근한 유저와 작성자가 같은지 판단
		if("${loginid}" == "${reviewDto.reviewwriter}"){
			$("#review_button").prepend(
			'<input class="ip_button" type="button" value="삭제" onclick=delete_chk()>'		
			);
		}
	});
	
	function reload(){
		window.opener.location.reload();
		window.close();
	}
	
	function delete_chk(){
		if(confirm("해당 리뷰를 삭제하시겠습니까?")){
			location.href="CenterController?command=review_delete&reviewno=${reviewDto.reviewno}";
		}
	}

</script>
</head>
<body>
	<div id="title">
	<h2>리뷰 상세보기</h2>
	</div>
	<div class="wrap">
		<div class="review_detail">
		<div class="headline">
			<a>${reviewDto.reviewwriter}</a> &nbsp;
			<a>${reviewDto.reviewreg}</a>
			<br>
			<a>평점 : <span class='star-rating'><span style='width:${reviewDto.reviewgrade*20}%'></span>
                </span>&nbsp;(${reviewDto.reviewgrade}점)</span><br></a>
		</div>				
		<div class="review_content">
			<div id="cont_text">${reviewDto.reviewcontent}</div>
		</div>
		<div id="review_button" align="right">
			<input class="ip_button" type="button" value="닫기" onclick="reload()">
		</div>
	</div>

</body>
</html>