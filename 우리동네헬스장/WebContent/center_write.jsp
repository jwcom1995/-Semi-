<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>센터 등록</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function zipChk() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("address1").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
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
		var str = "<p><input type='file' id='file' name='file_"+(gfv_count++)+"'><a href='#this' class='btn' name='delete' accept='.jpg,.jpeg,.png,.gif'>삭제</a></p>"; 
		$("#fileDiv").append(str); 
		$("a[name='delete']").on("click", function(e){ //삭제 버튼 
			e.preventDefault(); 
		fn_deleteFile($(this)); 
		}); 
		} 
	
	function fn_deleteFile(obj){ obj.parent().remove(); }


		
</script>

<style type ="text/css">
header, section, article, aside, main, nav, footer{
    display: block;
}
#title hr{
	height:3px;
	background-color:#036;
}
h1, p{
    margin: 0;
}
.information a{
    text-decoration: none;
    color:black;
    font-weight:bold;
}
#main{
    width: 80%;
    height: auto;
    margin: 0 auto;
}
.main_title{
	text-align : center;
}
#main .wrap .top_cont{
    font-size: 0;
}
#main .wrap .top_cont .img_part{
    display: inline-block;
    vertical-align: middle;
}
#main .wrap .top_cont .img_part img{
    margin: 10px;
    width: 200px;
    height: 200px;
}
#main .wrap .top_cont .txt_part{
    display: inline-block;
    vertical-align: middle;
    padding-left: 50px;
}
#main .wrap .top_cont .txt_part p{
    display: block;
    font-size: 20px;
    padding-bottom: 20px;
}
.information{
	text-align : center;
    word-spacing : 60px;
}
#main .information a{
    margin: 0 15px;
}

.cont{
	display:flex;
	width:90%;
	margin-left:5%;
	justify-content:center;
	align-items: center;
	margin-bottom:25px;
}
.cont_head{
	min-width:200px;
	height:50px;
	width:20%;
	border-right: 3px solid #036;
}
.cont_head2{
	min-width:200px;
	height:50px;
	width:20%;
}
.cont_info{
	width:80%;
	padding:8px;
}

.cont_info2{
	width:80%;
	padding:8px;
	border-left: 3px solid #036;
}
.cont_button{
	align-self: center;
}
#zip_chk{
	display:block;
	margin-bottom:18px;
}
.img_cont, .review_cont{
	width:90%;
	margin-left:5%;
	height: auto;
}
.cont_images img{
	width:300px;
	height:200px;
}

.txt_part{
	font-size:18px;
}
input[type=text]{
	width:100%;
	height:20px;
}
textarea{
	width:100%;
	resize:none;
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
</style>
</head>
<body>
<header><%@ include file = "./form/header.jsp" %></header>
	<div id="main">
		<div id="title"><br><br>
		<h1 align="left">센터 등록</h1><br><hr>
		</div><br>
		<form action="CenterController?command=centerdetail_writer" method="post" enctype="multipart/form-data"> 
			<input type="hidden" name="userid" value="${loginUser.userid}">     
	            <div class="text_cont">
	            	<div class="cont">
	                    <div class="cont_head">
	                        <h3 id="a">센터이름</h3>
	                    </div>
	                    <div class="cont_info">
	                    	<input type="text" name="centernm">
	                    </div>
	                </div>
	                <div class="cont">
	                    <div class="cont_head">
	                        <h3 id="a">센터위치</h3>
	                    </div>
	   
	                    <div class="cont_info">
	                    	<input type="hidden" id="address1" name="myaddr1" placeholder="주소를 입력하세요" readonly>
							<span id="guide" style="color:#999;display:none"></span>
							<input type="hidden" id="address2" name="myaddr2" size="45" placeholder="상세 주소를 입력하세요">
	                    	<input type="text" name="centeraddr" id="sample4_roadAddress" readonly onclick="zipChk()">
	                    	<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
	                    </div>
	                    <div class="cont_button">
							<input type="hidden" id="zipcode" name="myzipcode" size="7" placeholder="우편번호" readonly>&nbsp;&nbsp;
							<input type="button" id="zip_chk" value="주소 검색" onclick="zipChk()">
						</div>
	                </div>
	                <div class="cont">
	                    <div class="cont_head">
	                        <h3 id="a">가격</h3>
	                    </div>
	                    <div class="cont_info">
	                    	<input type="text" name="centerprice">
	                    </div>
	                </div>
	                <div class="cont">
	                    <div class="cont_head">
	                        <h3 id="a">센터종류</h3>
	                    </div>
	                    <div class="cont_info">
	                    	<input type="checkbox" name="health" value="헬스">헬스
							<input type="checkbox" name="pilates" value="필라테스">필라테스
							<input type="checkbox" name="yoga" value="요가">요가
							<input type="checkbox" name="crossfit" value="크로스핏">크로스핏
							<input type="checkbox" name="etc" value="기타">기타
	                    </div>
	                </div>
	                <div class="cont">
	                    <div class="cont_head2">
	                        <h3 id="a">센터소개</h3>
	                    </div>
	                    <div class="cont_info2">
	                    	<textarea rows="10" name="centerintro"></textarea>
	                    </div>
	                </div>
	                <div class="cont">
	                	<div class="cont_head2">
	                		<h3 id="b">이용정보</h3>
	                	</div>
	                    <div class="cont_info2">
	                    	<textarea rows="10" name="centercontent"></textarea>
	                    </div>
	                </div>
	                <div class="cont">
	                	<div class="cont_head2">
	                		<h3 id="c">운영시간</h3>
	                	</div>
	                    <div class="cont_info2">
	                    	<textarea rows="10" name="centerophour"></textarea>
	                    </div>
	                </div>
	                <div class="cont">
	                	<div class="cont_head2">
	                		<h3 id="d">프로그램</h3>
	                	</div>
	                    <div class="cont_info2">
	                    	<textarea rows="10" name="centerpro"></textarea>
	                    </div>
	                </div>
	                <div class="cont">
	                <div class="cont_head">
	                    <h3 id="f">사진</h3>
	                </div>
	                <div class="cont_info">
	                	<div class="cont_images" id="fileDiv">
	                    <p> 
	                    	<input type="file" id="file" name="file_0" accept=".jpg,.jpeg,.png,.gif">
	                    	<a href="#this" class="btn" id="delete" name="delete">삭제</a> 
	                    </p>
	                	</div>
	                </div>
	            	</div>
	            </div>
	            <div class="submit_btn" align="center">
	            	<input class="ip_button" type="submit" value="등록">	
					<input class="ip_button" type="button" value="취소" onclick="location.href='CenterController?command=centerlist'">
	       		</div>
      	</form>
	</div>
<header><%@ include file = "./form/footer.jsp" %></header>
</body>
</html>