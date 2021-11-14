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
	#content{
		resize:none;
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
<script type="text/javascript"	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"> 
var gfv_count = 1;

$(function(){
    $(document).on("change","#file",function(){
        fn_addFile(); //input태그 추가
    });
  
  
  $("a[name='delete']").on("click", function(e){ //삭제 버튼 
     e.preventDefault(); 
     fn_deleteFile($(this)); 
  });

});
	

function fn_addFile(){ 
	var str = "<tr><th></th><td><input type='file' id=file name='file_"+(gfv_count++)+"'><a href='#this' class='btn' name='delete'>삭제</a></td></tr>"; 
	$("#fileDiv").append(str); 
	$("a[name='delete']").on("click", function(e){ //삭제 버튼 
		e.preventDefault(); 
	fn_deleteFile($(this)); 
	}); 
	} 

function fn_deleteFile(obj){ obj.parent().remove(); }


</script>
</head>
<body>
<header><%@ include file="form/header.jsp" %></header>
<h2 align="center">1 : 1 문의</h2>
<div id="wrap">
	<form action="MainController" method="post">
		<input type="hidden" name="command" value="boardwrite">
		<input type="hidden" name="qa_gpsq" value="1">
		<input type="hidden" name="user_id" value="${loginUser.userid}"> <!-- 사용자 아이디와 번호는 로그인 기능 완료 후 세션값 적용 -->
		<input type="hidden" name="user_no" value="${loginUser.userno}">
		<input type="hidden" name="qa_faq" value="N">
		<input type="hidden" name="qa_status" value="N"> 

		<table>
			<tr id="title">
				<th>제 목</th>
				<td>
					<select id="qa_type" name="qa_type" style="width:50px;height:30px;">
							<option value="가격">가격</option>
							<option value="거래">거래</option>
							<option value="시설">시설</option>
							<option value="기타">기타</option>
					</select>
					<input type="text" placeholder="제목을 입력하세요" name="title" maxlength="30" value="${dto.qatitle }" required>
				</td>
			</tr>
			
			<tr id="content">
				<th>내 용</th>
				<td><textarea rows="15" cols="50" name="content" placeholder="문의내용을 입력해주세요" resize="none" required>${dto.qacontent }</textarea></td>
			</tr>
			
			<tr id="photo">
				<th>사진 첨부</th>
				<td align="left">
					<input type="file" value="파일 선택" id="file" name="file_0" accept=".jpg,.jpeg,.png,.gif" multiple="multiple">
					<a href="#this" class="btn" id="delete" name="delete">삭제</a>
				</td>
			</tr>
		</table>
		<br>
		<div align="center">
			<input type="submit" id="submit" value="완 료" >&nbsp;&nbsp;
			<button type="button" id="reset" onclick="location.href='MainController?command=qna'">취 소</button>
		</div>		
	</form>
</div>
		<footer><%@ include file = "form/footer.jsp" %></footer>
</body>
</html>