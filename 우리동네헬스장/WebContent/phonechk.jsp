<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<script type="text/javascript">
	window.onload=function(){
		
		var doc = document.getElementsByName("ran")[0];
		
		if(doc.value.trim()!=""&&doc.value.trim()!=null){
			opener.document.getElementsByName("rannum")[0].value=doc.value;
		}else{
			self.close();
		}
		self.close();
	}
</script>
<%
	String ran = request.getParameter("ran");
%>
<body>
	<input type="hidden" name="ran" value=<%= ran %>> 
</body>
</html>