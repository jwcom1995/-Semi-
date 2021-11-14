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
</head>
<body>
<header><%@ include file="form/header.jsp" %></header>
<h2 align="center">1 : 1 문의</h2>

<div id="wrap">
	<form action="MainController" method="post">
		<input type="hidden" name="command" value="boardupdate">
		<!-- input type="hidden" name="qa_gpno" value="<%=dto.getQagpno() %>">
		<input type="hidden" name="qa_gpsq" value="<%=dto.getQagpsq() %>"> 
		<input type="hidden" name="user_id" value="<%=dto.getUserid() %>"> 
		<input type="hidden" name="user_no" value="<%=dto.getUserno() %>">
		<input type="hidden" name="qa_faq" value="<%=dto.getQafaq() %>"> 
		<input type="hidden" name="qa_status" value="<%=dto.getQastatus() %>"> --> 
		
		<input type="hidden" name="qano" value="<%=dto.getQano() %>"> 
		<input type="hidden" name="qa_type" value="<%=dto.getQatype() %>"> 
		
		<table>
			<tr id="title">
				<th>제 목</th>
				<td>
					<select id="category" name="qa_type" style="width:50px;height:30px;" disabled>
							<option value="price">가격</option>
							<option value="deal">거래</option>
							<option value="center">시설</option>
							<option value="etc">기타</option>
					</select>	
					<input type="text" name="qatitle" maxlength="30" value="<%=dto.getQatitle()%>">
				</td>
			</tr>
			<tr id="content">
				<th>내 용</th>
				<td><textarea rows="10" cols="60" name="qacontent"><%=dto.getQacontent() %></textarea></td>
			</tr>
			<tr id="photo">
				<th>사진 첨부</th>
				<td align="left"><input type="file" value="파일 선택" accept=".jpg,.jpeg,.png,.gif" multiple="multiple"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" id="submit" value="수정 완료">
					<input type="button" id="reset" value="취 소" onclick="location.href='MainController?command=qna&qano=<%=dto.getQano()%>'">
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