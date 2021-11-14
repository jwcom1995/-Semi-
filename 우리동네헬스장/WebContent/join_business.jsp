<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<html>
<head>
<meta charset="UTF-8">

    <title>사업자 등록</title>
    
    <style>
    	div{
    		text-align:center;
    	}
        #wrap{
            width:1000px;
            margin:auto;
            margin-left:auto; 
            margin-right:auto;
            text-align : center;
            
        }
        form{
        	display:inline-block;
        }
        h2{
        	text-align:center;
        }
        table{
  			border-collapse: separate;
			border-spacing: 0 20px;
 		 font-size:18px;
  		width:1000px;
		}
table tr{
	line-height:50px;
}
table th{
	border-right: 3px solid #036;
}
table td{
	padding-left:10px;
}
table tbody tr{
	border-bottom: 1px solid #ccc;
}
        
        #title{
            background-color:white;
        }
        .button input{
			background-color:rgb(75, 161, 231);
			color : white;
			float : right;
			border:1px solid white;
			width: 90px;
			height: 30px;
			cursor: pointer;
			padding-right: 10px;
		}
		.input{
			width: 370px;
		}
		th{
			text-align: center;
		}
		#table input[type="text"]{
			width: 100%;
			line-height: 30px;
		}
		#title2 hr{
		height:3px;
		background-color:#036;
		}
		h1{
			text-align:left;
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
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    	
    </script>
</head>
<body>
	<header><%@ include file = "form/header.jsp" %></header>
    <div id="wrap">
       <div id="title2">
		<br><br>
			<h1>사업자 등록</h1><hr>
		</div>
        <br>
        
         <form action="usercontroller?command=join_biz&userno=${dto.userno }" method="post" enctype="multipart/form-data">
            <table id="table">
                <tr>
                    <th id="USER_NAME">사업자명</th>
                    <td>
						<input type="text" class="input" name="usernm" id="USER_NAME" placeholder="사업자명을 작성해주세요" value="${ dto.username }">
					</td>
                </tr>
                <tr>
                    <th id="BIZ_NAME">사업장명</th>
                    <td>
					<input type="text" cols="40" name="biznm" class="input" placeholder="사업장명을 작성해주세요" required>
                    </td>
                </tr>
                <tr>
                    <th id="BIZ_ADDRESS">주소</th>
                    <td>
                    	<input type="button" id="zip_chk" value="주소 검색" onclick="zipChk()">
						<input type="hidden" id="address1" name="myaddr1" placeholder="주소를 입력하세요" readonly>
						<span id="guide" style="color:#999;display:none"></span>
						<input type="hidden" id="address2" name="myaddr2" size="45" placeholder="상세 주소를 입력하세요">
						<input type="text" id="sample4_roadAddress" name="bizaddr" placeholder="사업장 주소를 작성해주세요" style="width: 100%">
						<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
						<input type="hidden" class="input" id="zipcode" name="myzipcode" size="7" placeholder="우편번호" readonly required>&nbsp;&nbsp;
						
					</td>
                </tr>
                <tr>
                    <th id="BIZ_CATEGORY">사업장 종류</th>
                    <td>
						<input type="checkbox" name="health" value="헬스">헬스
						<input type="checkbox" name="pilates" value="필라테스">필라테스
						<input type="checkbox" name="yoga" value="요가">요가
						<input type="checkbox" name="crossfit" value="크로스핏">크로스핏
						<input type="checkbox" name="etc" value="기타">기타      
		             </td>
                </tr>
                <tr>
                    <th id="BIZ_CONTENT">기타</th>
                    <td>
						<textarea  rows="10" name="bizcontent" style="resize: none; width:100%" placeholder="기타내용을 입력해주세요"></textarea>
                    </td>
                </tr>
                <tr>
                    <th id="BIZ_PIC">사업자 등록증</th>
                    <td>
                        <input type="file" name="imgfile" accept=".jpg,.jpeg,.png,.gif" required>
                    </td>
                </tr>
             </table>
         
        
        	<div class = "button" style="width: 97%;">
        		<input type="button" value="취소" class="button2" onclick="location.href='main.jsp'">
				<input type="submit" value="사업자 등록" class="button1">	
			</div>
		</form>
        
    </div>
    
    <footer><%@ include file = "form/footer.jsp" %></footer>
    
</body>
</html>
