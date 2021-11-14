<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="com.qna.dao.QnaDao" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int qano = Integer.parseInt(request.getParameter("qano"));
	
	QnaDao dao = new QnaDao();
	int res = dao.delete(qano);
			
	if(res>0){
%>
	<script type="text/javascript">
		alert("삭제되었습니다.");
		location.href="qna.jsp";
	</script>
<%
	}else{
%>
	<script type="text/javascript">
		alert("삭제를 실패하였습니다.");
		location.href="question_board_selectone.jsp?qano="+qano;
	</script>
<%
	}
%>
</body>
</html>