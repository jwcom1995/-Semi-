<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.qna.dao.QnaDao" %>
<%@ page import="com.qna.dto.QnaDto" %>
<%@ page import="com.reply.dao.ReplyDao" %>
<%@ page import="com.reply.dto.ReplyDto" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">	
	h1{
		background-color:#9EB9CE;
		border-radius: 10px;
	}
	.tabs li a:hover{
    color: #9EB9CE;
    }
    .qna td a:hover{
     color: #9EB9CE;
    }
	.tabs{
		list-style-type:none;
		height : 30px;
		padding : 0;
		margin :0;
	}
	.tabs li{
		float : left;
		position: relative;
		padding : 0;
		line-height:30px;
	}
	.tabs li a {
		font-weight : bold;
		padding: 5px 25px;
	}
	ul{ list-style : none;}
	.category>ul>li>a{
		display : block;
		width : 100%;
		height : 100%;
		font-size : 13px;
		text-align : center;
	}
	.qna{
		text-align: center;
		position: relative;
		width:100%;
	}
	.faq{
		display: inline-block;
		width : 500px;
		height : 300px;
		margin: 10px;
	}
	.faq_type{
		display: inline-block;
		width : 100px;
		margin: 5px;
		text-align: center;
		float: left;
	}
	.faq_type tbody{
		display: inline-block;
	}
	.faq_list{
		display: inline-block;
		width : 300px;
		margin: 5px;
	}
	.faq_list tbody{
		display: inline-block;
	}
	.faq_table{
		margin: 10px 10px 0px;
		width:480px;
	}
	td, a, a:hover{
		color:#000000;
		text-decoration:none;
	}
	.qna_list{
		width : 500px;
		height : 200px;
		display: inline-block;
		margin :100px 10px 0px;
	}
	.qna_table{
		margin: 20px 10px 0px;
		width:480px;
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function login_chk(){
	if(${loginUser==null}){
		if(confirm("로그인이 필요한 작업입니다.\n 로그인 하시겠습니까?")){
			location.href="login.jsp"
		}else{
			
		}
	} else{
		location.href="MainController?command=writeform";
	}
}
	
</script>
</head>
<% 
	String qatype = request.getParameter("qatype");
	QnaDao dao = new QnaDao(); 
	ReplyDao rdao = new ReplyDao();
	
	List<QnaDto> list = dao.selectAll();
	List<QnaDto> faqlist = dao.selectFaq();
	
	
%>
<body>
<header><%@ include file="form/header.jsp" %></header>
<br>
<input type="hidden" id="session_id" value="${loginUser.userid}">
	<div class="qna">
		<div class="faq">
		<h1 align="center">F A Q</h1>
			<div name="qna_category" id="tab_container" style="width:97%; padding:5px 5px 5px 5px;">
				<ul class="tabs">
				<!-- 탭 메뉴 영역 -->
					<li><a href="MainController?command=qna">전체</a></li>
					<li><a href="MainController?command=getlist&qatype=1">가격</a></li>
					<li><a href="MainController?command=getlist&qatype=2">거래</a></li>
					<li><a href="MainController?command=getlist&qatype=3">시설</a></li>
					<li><a href="MainController?command=getlist&qatype=4">기타</a></li>
				</ul>	
				
				<!-- 탭 콘텐츠 영역 -->
					<div class="tab_container">
						<div id="price" class="tab_container""></div>	
					</div>	
					<div class="tab_container">
						<div id="deal" class="tab_container"></div>	
					</div>
					<div class="tab_container">
						<div id="center" class="tab_container"></div>	
					</div>
					<div class="tab_container">
						<div id="etc" class="tab_container"></div>	
					</div>
			</div>

			<table class="faq_table" border="1">
				<tr>
					<th style="width:80px;">유형</th>	
					<th style="width:400px;">자주하는 질문</th>
				</tr>	
				<tr>
				<%
					for(int i = 0; i<faqlist.size(); i++){
				%>				
				<tr>
						<td><%=faqlist.get(i).getQatype()%></td>
						<td align="left"><a href="question_board_selectone.jsp?qano=<%=faqlist.get(i).getQano()%>" onclick="user_Chk();"><%=faqlist.get(i).getQatitle() %></a></td>
				</tr>
				<%
					List<ReplyDto> relist = rdao.reList(list.get(i).getQano());
					for(int j = 0; j<relist.size(); j++){
						System.out.print(relist.get(j).getRetitle());
				%>
								<tr>
									<td>└</td>
									<td align="left"><a href="question_board_answerwrite.jsp?qareno=<%=relist.get(j).getQareno()%>&qano=<%=list.get(i).getQano()%>&userid=<%=list.get(i).getUserid() %>&seid=${loginUser.userid}"><%=relist.get(j).getRetitle() %></a></td>
								</tr>
				<%
					}
				%>

				<%
					}
				%>
			</table>
		</div>
		
		
		
		<br><br><br><br>
		
			
	<div class="qna_list">
		<h1 align="center">Q & A</h1>
			<table class="qna_table" border="1">
				<tr>
					<th style="width:50px;">NO.</th>
					<th>제 목</th>
					<th style="width:80px;">답변 여부</th>
				</tr>
<%
	for(int i = 0; i<list.size(); i++){
%>				
				<tr>
					<td><%=list.get(i).getQano() %></td>
					<td align="left"><a href="question_board_selectone.jsp?qano=<%=list.get(i).getQano()%>&userid=<%=list.get(i).getUserid() %>&seid=${loginUser.userid}"><%=list.get(i).getQatitle() %></a></td>
					<td><%=list.get(i).getQastatus() %></td>
				</tr>
<%
	List<ReplyDto> relist = rdao.reList(list.get(i).getQano());
	for(int j = 0; j<relist.size(); j++){
		System.out.print(relist.get(j).getRetitle());
%>
				<tr>
					<td>└</td>
					<td align="left"><a href="question_board_answerwrite.jsp?qareno=<%=relist.get(j).getQareno()%>&qano=<%=list.get(i).getQano()%>&userid=<%=list.get(i).getUserid() %>&seid=${loginUser.userid}"><%=relist.get(j).getRetitle() %></a></td>
					<td>-</td>
				</tr>
<%
	}
%>
<%
	} 
%>	
			</table>
			<div style="text-align: right; width: 500px; display: inline-block;">
				<input type="button" value="1 : 1 문의" class="qna_button" onclick="login_chk();">
			</div>
			<br>
	</div>
</div>
<br><br><br><br><br><br><br>
<footer><%@ include file="form/footer.jsp" %></footer>
</body>
</html>