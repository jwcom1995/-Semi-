<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고거래 게시글 수정</title>
<style type="text/css">
h1{text-align:left;
}
#title hr{
	height:3px;
	background-color:#036;
}
#wrap{
	width:80%;
	margin: 0 auto;
	text-align:center;
}
#wrap textarea{
	width:100%;
	height:60%;
	resize:none;
}
#wrap th{
	font-size:16px;
	height:50px;
}
#wrap td{
	text-align:left;
}
#wrap td input[type="text"]{
	width:100%;
	font-size:16px;
}
select {
	font-size:20px;
	width: 100px;
	height: 25px;
}
input[type=button], input[type=submit]{
	cursor:pointer;
	width:100px;
	height:30px;
	font-size:16px;
	font-weight:bold;
}
input[type=text]{
	height:30px;
}
table{
	border-collapse: separate;
	border-spacing: 0 20px;
}
table th{
	border-right: 3px solid #036;
}
table td{
	padding-left:20px;
}
</style>
</head>
<body>
	<header><%@ include file="./form/header.jsp" %></header>
	
	<div id="wrap">
	<div id="title">
	<br><br>
	<h1>중고거래 게시글 수정</h1>
	<hr></div>
	<br>
	<form action="usedcontroller?command=usedupdate" method="post">
		<input type="hidden" name="usedno" value="${useddto.usedno }">
		<table width="100%">
			<colgroup>
				<col width="20%">
				<col width="80%">
			</colgroup>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="${useddto.usedtitle}" required></td>
			</tr>
			<tr>
				<th>판매 가격</th>
				<td><input type="text" name="price" value="${useddto.usedprice}" required></td>
			</tr>
			<tr>
				<th>글 머리</th>
				<td>
					<select name="category">
						<option value="헬스장">헬스장</option>
						<option value="요가">요가</option>
						<option value="필라테스">필라테스</option>
						<option value="크로스핏">크로스핏</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>센터 주소</th>
				<td><input type="text" name="addr" value="${useddto.usedaddr}" readonly></td>
			</tr>
			<tr>
				<th>센터명</th>
				<td><input type="text" name="centernm" value="${useddto.usedcenternm}" readonly required></td>
			</tr>
			<tr>
				<th>상세설명</th>
				<td><textarea name="content" rows="15" required>${useddto.usedcontent}</textarea></td>
			</tr>
			<tr>
				<th>사진첨부</th>
				<td>
					<input type="file" name="images" accept="image/png,image/jpeg">
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center;"><br><br>
					<input type="submit" value="수정">
					<input type="button" value="취소" onclick="location.href='usedcontroller?command=useddetail&usedno=${useddto.usedno}'">
				</td>
			</tr>
		</table>
	</form>
	</div>
	<footer><%@ include file="./form/footer.jsp" %></footer>
</body>
</html>