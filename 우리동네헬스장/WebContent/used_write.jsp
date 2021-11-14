<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고거래 게시글 작성</title>
<style type="text/css">
#title hr{
	height:3px;
	background-color:#036;
}
h1{
	align:left;
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

#address_info{
	display:flex;
	align-items: center;
}
#address_button{
	display:inline-block;
}
#zip_chk{
	margin-bottom:16px;
}
#address_text{
	width:100%;
	display:inline-block;
}
#sample4_roadAddress{
	margin-bottom:40px;
}
.ip_button{
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
table{
	border-collapse: separate;
	border-spacing: 0 20px;
}
table th{
	border-right: 3px solid #036;
}
tr{
	line-height:30px;
}
td{
	text-align:left;
	padding-left:20px;
}
</style>
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
		var str = "<tr><th></th><td><input type='file' id=file name='file_"+(gfv_count++)+"'><a href='#this' class='btn' name='delete'>삭제</a></td></tr>"; 
		$("#fileDiv tbody").append(str); 
		$("a[name='delete']").on("click", function(e){ //삭제 버튼 
			e.preventDefault(); 
		fn_deleteFile($(this)); 
		}); 
		} 
	
	function fn_deleteFile(obj){ obj.parent().remove(); }

</script>
</head>
<body>
	<header><%@ include file="./form/header.jsp" %></header>
	
	<div id="wrap">
	<div id="title"><br><br>
		<h1 align="left">중고거래 게시글 등록</h1><hr>
		</div><br>
	<form action="usedcontroller?command=usedwrite" method="post" enctype="multipart/form-data">
		<input type="hidden" name="logonid" value="${loginUser.userid}">
		<input type="hidden" name="logonno" value="${loginUser.userno}">
		<table width="100%" id="fileDiv">
			<colgroup>
				<col width="20%">
				<col width="80%">
			</colgroup>
			<tbody>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" placeholder="제목을 입력해주세요" required></td>
			</tr>
			<tr>
				<th>판매 가격</th>
				<td><input type="text" name="price" placeholder="희망 판매가격을 입력해주세요" required></td>
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
				<td>
					<div id="address_info">
					<div id="address_button">
					<input type="hidden" id="zipcode" name="myzipcode" size="7" placeholder="우편번호" readonly>&nbsp;&nbsp;
					<input type="button" id="zip_chk" value="주소 검색" onclick="zipChk()"></div>
					<div id="address_text">
					<input type="hidden" id="address1" name="myaddr1" placeholder="주소를 입력하세요" readonly><br><br>
					<span id="guide" style="color:#999;display:none"></span>
					<input type="hidden" id="address2" name="myaddr2" size="45" placeholder="상세 주소를 입력하세요">
					<input type="text" name="addr" id="sample4_roadAddress" placeholder="주소를 입력해주세요" required readonly onclick="zipChk()">
					<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>센터명</th>
				<td><input type="text" name="centernm" placeholder="센터명을 입력해주세요" required></td>
			</tr>
			<tr>
				<th>상세설명</th>
				<td><textarea name="content" rows="15" required></textarea></td>
			</tr>
			<tr>
				<th>사진첨부</th>
				<td>
					<input type="file" id="file" name="file_0" accept=".jpg,.jpeg,.png,.gif">
	                <a href="#this" class="btn" id="delete" name="delete">삭제</a> 
				</td>
			</tr>
			</tbody>
			<tfoot>
			<tr>
			<td colspan="2" style="text-align:center;"><br><br>
				<input class="ip_button" type="submit" value="등록">
				<input class="ip_button" type="button" value="취소" onclick="location.href='usedcontroller?command=usedlist'">
			</td>
			</tr>	
			</tfoot>
		</table>
		
	</form>
	</div>
	<footer><%@ include file="./form/footer.jsp" %></footer>
</body>
</html>