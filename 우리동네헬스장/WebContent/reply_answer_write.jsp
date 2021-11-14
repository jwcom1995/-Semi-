<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import = "com.qna.dao.QnaDao" %>
<%@ page import = "com.qna.dto.QnaDto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>

<% 
	
	int qano = Integer.parseInt(request.getParameter("qano"));
	String qatitle = request.getParameter("qatitle");
	String qacontent = request.getParameter("qacontent");
	
	QnaDao dao = new QnaDao();
	QnaDto dto = dao.selectOne(qano);
	
%>

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
<script>
var uid = "${loginUser.userid}";
var qid = "<%=dto.getUserid()%>";
console.log(uid);
console.log(qid);


if(uid==""){
	alert("로그인 후 이용가능합니다."); location.href="login.jsp";
	
	exit;
}	



</script>
</head>
<header><%@ include file="form/header.jsp" %></header>
<body>
<h2 align="center">1 : 1 문의 답변</h2>

<div id="wrap">	
	<form action="MainController" method="post">
		<input type="hidden" name="command" value="answerwrite" >
		<input type="hidden" name="qano" value="<%=dto.getQano() %>">
		<input type="hidden" name="titletab" value="<%=dto.getTitletab() %>">
		
		<table>
			<tr id="title">
				<th>제 목</th>
				<td><input type="text" name="title" value="[답변] <%=dto.getQatitle()%>" readonly></td>
			</tr>
			<tr id="content">
				<th>내 용</th>
				<td><textarea rows="10" cols="60" name="content" required></textarea></td>
			</tr>
			<tr>
				<td colspan="3">
					<input type="submit" id="submit" value="작 성" >&nbsp;&nbsp;
					<input type="button" id="reset" value="취 소" onclick="history.back()">
				</td>
			</tr>
		</table>
	</form>
	</div>
	<div>
		<footer><%@ include file = "form/footer.jsp" %></footer>
</div>	
</body>
</html>