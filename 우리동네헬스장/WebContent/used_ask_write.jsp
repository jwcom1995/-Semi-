<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 구매문의 작성하기</title>
<style type="text/css">
	body{background-color:#036;}
	.used_ask{
		text-align: center;
	}
	#title{
		width:400px;
		color:white;
	}
	.text_area{
		box-sizing: border-box;
		border: 1px solid black;
		border-radius: 10px;	
		box-sizing: border-box;
		display:inline-block;
		width: 400px;
		padding:10px;
		background-color:white;
	}
	.text_area input{
		position: relative;
	}
	.text_area a{
		position: relative;
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
	input[name=title]{
		width:280px;
	}
	th{
		font-size:13px;
	}
</style>

<script type="text/javascript">
	
	function reload(){
		window.opener.location.reload();
		window.close();
	}
</script>

</head>
<body>
	<div class="used_ask">
		<div id="title" style="text-align: left; margin-left: 15px;">
				<h2>1:1 구매문의</h2>
		</div>
		<div class="text_area">
			
			<form action="usedcontroller?command=askwrite" method="post">
			<input type="hidden" name="writer" value="${writer}">
			<input type="hidden" name="usedno" value="${usedno}">
			<table width="100%">
				<col width="80px">
				<tr>
					<th>제목</th>
					<td align="left"><input type="text" name="title" required></td>
				</tr>
				<tr>
					<th>질문유형</th>
					<td align="left"><select name="usk_type">
						<option value="priceask">가격문의</option>
						<option value="centerask">센터문의</option>
						<option value="mthodask">거래방법문의</option>
						<option value="serviceask">서비스문의</option>
					</select></td>
				</tr>
				<tr>
					<td> </td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea name="content" required rows="15" cols="50" placeholder="문의 내용을 입력해주세요" style="resize:none;"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="등록" class="ip_button">&nbsp;&nbsp;<input type="button" value="취소" onclick="reload()" class="ip_button">
					</td>
				</tr>
			</table>			
			</form>			
		</div>
	</div>
</body>
</html>