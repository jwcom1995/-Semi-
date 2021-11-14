<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("UTF-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업장 등록 요청</title>
<style type="text/css">
#body{
	display:flex;
}
#wrap{
	width:80%;
	text-align:center;
	align-items: center;
    justify-content: center;
}
#title hr{
	height:3px;
	background-color:#036;
}
.empty_space{
	width:10%;
}
.biz_info{
	display:flex;
	margin-bottom:50px;
	margin-top:50px;
}
.cont_head{
	display: flex;
    align-items: center;
    justify-content: center;
	width:200px;
	height:100px;
	border-right: 2px solid #036;
}
.cont_info{
	width:100%;
	display: flex;
	align-items: center;
    justify-content: left;
    padding-left:50px;
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
.status_active{
	width:100px;
	display:inline-block;
	background:rgb(15, 82, 186);
	color:white;
	font-weight:bold;
	font-size:20px;
	border-radius:10px;
}
.status_dis{
	width:100px;
	display:inline-block;
	background:gray;
	color:white;
	font-weight:bold;
	font-size:20px;
	border-radius:10px;
}
.cont_info img{
	width:280px;
	height:425px;
}
.cont_info img{
		transition:all 02.x linear;
	}
.cont_info img:hover{
		transform:scale(2);
}
</style>
<script type="text/javascript">
 
 function status_change(act){
	//act==1 이면 사업자 승인 ,act == 2 이면 사업자 거절
	if(act == 1){
		if(confirm("사업자 승인요청을 수락하시겠습니까?")){
			location.href="usercontroller?command=change_status&bizno="+${bizDto.bizno}+"&status=Y&userno="+${bizDto.userno};
		}
	}
	else if(act == 2){
		if(confirm("사업자 승인요청을 거절하시겠습니까?")){
			location.href="usercontroller?command=change_status&bizno="+${bizDto.bizno}+"&status=D&userno="+${bizDto.userno};
		}
	}
 }
 
</script>
</head>
<body>
	<header><%@ include file="./form/header.jsp"%></header>
	<div id="body">
	<div class="empty_space"></div>
	<div id="wrap">
		<div id="title">
			<br><br>
			<h1>사업장 등록 요청</h1><hr>
		</div>
		<div id="contents">
			<div class="biz_info">
                <div class="cont_head">
                    <h3>사업자 이름</h3>
                </div>
                <div class="cont_info">                	
                	${bizDto.usernm}
            	</div>
        	</div>
        	<div class="biz_info">
                <div class="cont_head">
                    <h3>사업장 이름</h3>
                </div>
                <div class="cont_info">
                	${bizDto.biznm}
            	</div>
        	</div>
        	<div class="biz_info">
                <div class="cont_head">
                    <h3>사업장 종류</h3>
                </div>
                <div class="cont_info">
            		${bizDto.bizcategory}
            	</div>
        	</div>
        	<div class="biz_info">
                <div class="cont_head">
                    <h3>사업장 주소</h3>
                </div>
                <div class="cont_info">
                	${bizDto.bizaddr}
            	</div>
        	</div>
        	<div class="biz_info">
                <div class="cont_head">
                    <h3>기타</h3>
                </div>
                <div class="cont_info">
                	${bizDto.bizcontent}
            	</div>
        	</div>
        	<div class="biz_info">
                <div class="cont_head">
                    <h3>사업자 등록증 사진</h3>
                </div>
                <div class="cont_info">
                <c:choose>
                	<c:when test="${!empty bizDto.bizpic}">
                		<img src="/download/${bizDto.bizpic}">
                	</c:when>
                	<c:otherwise>
                		<img src="./img/no_photo.png">
                	</c:otherwise>
                </c:choose>
            	</div>
        	</div>
        	<div class="biz_info">
                <div class="cont_head">
                    <h3>승인여부</h3>
                </div>
                <div class="cont_info">
                	<c:choose>
                		<c:when test="${bizDto.bizstatus eq 'Y'}">
                			<span class="status_dis">승인수락</span>
                		</c:when>
                		<c:when test="${bizDto.bizstatus eq 'N'}">
                			<span class="status_active">승인대기</span>
                		</c:when>
                		<c:when test="${bizDto.bizstatus eq 'D'}">
                			<span class="status_ids">승인거절</span>
                		</c:when>
                	</c:choose>
                	
            	</div>
        	</div>
        	<div class="">
        		<input class="ip_button" type="button" value="승 인" onclick="status_change(1)">
        		<input class="ip_button" type="button" value="거 절" onclick="status_change(2)">
        		<input class="ip_button" type="button" value="목 록" onclick="location.href='MainController?command=adminpage&act=biz'">
        	</div>
		</div>
	</div>
	<div class="empty_space"></div>
	</div>
	<footer><%@ include file="./form/footer.jsp"%></footer>
</body>
</html>