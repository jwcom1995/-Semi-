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
	div{
		text-align: center;
	}
	body{
		background-color:#036;
		
	}
	
	td{
		color: black;
	}
	table{
		display:inline-block;
		border: 1px solid black;
		border-radius: 10px;
		padding:10px;
		background-color:white;
	}
	#id{
		width: 100px; 
		height: 20px; 
		text-align: center; 
		border:0 solid black;
	}
	input{
		margin: 5px;
	}
</style>
<script type="text/javascript">
	window.onload=function(){
		var id = opener.document.getElementsByName("myid")[0].value;
		
		document.getElementsByName("id")[0].value=id;
	}
	
	function confirm(bool){
		if(bool){
			opener.document.getElementsByName("mypw")[0].focus();
			opener.document.getElementsByName("myid")[0].title="y";
		}else{
			opener.document.getElementsByName("myid")[0].focus();			
		}
		self.close();
	}
</script>
</head>
<%
	String idnotused = request.getParameter("idnotused");
%>
<body>
<div>
	<table>
		<tr>
			<td><input type="text" id="id" name="id"></td>
		</tr>
		<tr>
			<td><%= idnotused.equals("true")?"아이디 생성 가능":"중복아이디 존재" %></td>
		</tr>
		<tr>
			<td>
				<input type="button" value="확인" onclick="confirm(<%=idnotused%>);">
			</td>
		</tr>
	</table>
	</div>
</body>
</html>