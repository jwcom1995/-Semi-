<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고거래 상세페이지</title>
<style type="text/css">
*{
	margin: 0px;
	padding: 0px;
}
	
.wrap{
	display: flex;
	flex-direction:column;
	align-items: center;
	width: 80%;
	margin: 0 auto;
}
.used_detail{
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	background: #cdd0dd;
	width: 800px;
}
.headline{
	margin: 15px;
	width: 650px;
	text-align:left;
}
.title span{
	font-weight: bold;
	font-size: 20px;
}
.title img{
	padding-left: 400px;
}
.write_info a{
	font-size: 12px;
}
.content{
	width: 700px;
	background: white;
	margin: 50px;
	text-align: center;
}
#map{
	display:inline-block;
	margin-top: 40px;
	width:500px;
	height:260px;
}
.pic{
	display:inline-block;
	margin-top: 40px;
	width:600px;
	text-align:left;
}
.pic img{
	width:150px;
	height:100px;
}
.content_info,.ask_list{
	display:inline-block;
	margin-top: 40px;
	width:600px;
}
.content_info p{
	text-align: left;
}
.regist{
	
}
.regist input, .status input{
	width: 85px;
	height: 35px;
	border-radius: 5px;
	border: none;
	font-weight: bold;
}
#ask{
	background: rgb(75, 161, 231);
	color: white;
}
#list{
	background: grey;
	color: white;
}
/*찜 버튼 구현 시작*/
.checkbox-wrap{
	cursor:pointer;
}
.checkbox-wrap .check-icon  { 
	display: inline-block; 
	width: 30px; height: 30px; 
	background: url('img/emt_heart.png') left center no-repeat; 
	vertical-align: middle; 
	transition-duration: .3s; }	
.checkbox-wrap input[type=checkbox]{display:none;}
.checkbox-wrap input[type=checkbox]:disalbed + .check-icon{
	background-image:url('img/emt_heart.png');
}
input[type=checkbox]:checked + .check-icon{
	background-image:url('img/heart.png');
}

input.button-add {
    background-image: url(./img/emt_heart.png); /* 16px x 16px */
    background-color: transparent; /* make the button transparent */
    background-repeat: no-repeat;  /* make the background image appear only once */
    background-position: 0px 0px;  /* equivalent to 'top left' */
    border: none;           /* assuming we don't want any borders */
    cursor: pointer;        /* make the cursor like hovering over an <a> element */
    height: 16px;           /* make this the size of your image */
    padding-left: 16px;     /* make text start to the right of the image */
    vertical-align: middle; /* align the text vertically centered */
    position : relative;
    transform : rotate(0deg);
    width :24px;
    height : 24px;
}
.headline hr{
	height:3px;
	background-color:#036;
}
/*찜 버튼 구현 끝*/
#numbers{
	list-style: none;
}
#numbers li{
	display:inline-block;
	margin-left:5px;
	margin-right:5px;
}
#numbers li a {
	text-decoration: none;
	color:black;
	font-weight:bold;
}
#numbers li a.active {
	color:blue;
}
tbody a {
	text-decoration: none;
	color:black;
	cursor:pointer;
}
.pic .usedpic{
	transition:all 02.x linear;
}
.pic .usedpic:hover{
	transform:scale(3);
}
#board_blank{
	width:100%;
	height:67px;
	border: 1px solid black;
	text-align:center;
	line-height:67px;
}
input[type=button]{
	cursor:pointer;
}
#category{
	display:inline-block;
	width:100px;
	text-align:center;	
}
#title{
	display:inline-block;
	width:500px;
}
.write_info{
	padding-left:10px;
}
.ask_contents{
	display:inline-block;
	width:230px;
	overflow:hidden;
	/*텍스트가 설정한 범위 넘을경우 ...로 표시*/
	text-overflow:ellipsis;
	white-space:nowrap;
}

table{
  border-collapse: collapse;
}
.ask_list table tr{
}
.ask_list table th{
	border-bottom: 3px solid #036;
}
.ask_list table tbody tr{
	border-bottom: 1px solid #ccc;
}
.content_info table{
	border-collapse: separate;
	border-spacing: 0 20px;
}
.content_info table th{
	border-right: 3px solid #036;
}
.content_info tr{
	line-height:30px;
}
.content_info td{
	text-align:left;
	padding-left:20px;
}

.regist input[type=button], .status input[type=button]{
	margin-top:30px;
	margin-bottom:30px;
}
.waiting{
	width:60px;
	display:inline-block;
	background:rgb(15, 82, 186);
	color:white;
	font-weight:bold;
	font-size:12px;
	border-radius:5px;
}
.done{
	width:60px;
	display:inline-block;
	background:gray;
	color:white;
	font-weight:bold;
	font-size:12px;
	border-radius:5px;
}
</style>
<script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cf6a0311e8ff428c0d13bd95e775d7f3&libraries=services"></script>
<script type="text/javascript"	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	$(function(){
		
		 // 찜 설정이 된 경우 채워진 하트 이미지 표시
	     if($("#wish").val() == "1"){
	      $(".button-add").css({"background":"url(./img/heart.png)"});
	     }
	      
		
		var centerAddr = "${usedDto.usedaddr}";		
		
		// 주소-좌표 변환 객체를 생성	
		var geocoder = new kakao.maps.services.Geocoder();
		
		//주소 검색하여 주소를 좌표로 변환
		geocoder.addressSearch(centerAddr,function(result, status) {
			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {
				
				var container = document.getElementById('map'); //지도를 표시할 div
				var options = {
					center : new kakao.maps.LatLng(result[0].y, result[0].x), //지도의 중심 좌표
					level : 4
				//지도 확대 레벨
				};
				//지도 생성
				map = new kakao.maps.Map(container, options);
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				//마커로 표시
				var marker = new kakao.maps.Marker({
					map : map,
					position : coords
				});
				
				// 인포윈도우로 장소에 대한 설명을 표시
				var infowindow = new kakao.maps.InfoWindow(
					{
						content : '<div style="width:150px;text-align:center;padding:6px 0;">'
								+ "${usedDto.usedcenternm}"
								+ '</div>',
						position : coords
					});
				infowindow.open(map, marker);
			}
			
		});
		
		uskList = new Array();
		
		var uskObj = function(no,writer,title,status,reg){
			this.no=no;
			this.writer=writer;
			this.title=title;
			this.status=status;
			this.reg=reg;
		}
		<c:choose>
		<c:when test="${!empty usklist}">
		<c:forEach items="${usklist}" var="usk">
			var tmpUsk = new uskObj("${usk.uskno}","${usk.userid}","${usk.usktitle}"
					,"${usk.uskstatus}","${usk.uskreg}");
			uskList.push(tmpUsk);
		</c:forEach>		
		makeBoardList(uskList,false);
		</c:when>
		</c:choose>
		
		var piclist = new Array();
		
		var picObj = function(usedno,name,path){
			this.usedno = usedno;
			this.name = name;
			this.path = path;
		}
		
		<c:choose>
		<c:when test="${!empty piclist}">
		//CenterController 에서 보내준 piclist의 값을 넣어줌
			<c:forEach items="${piclist}" var="pic">
			var tempPic = 
				new picObj("${pic.boardno}","${pic.picname}","${pic.picpath}");
			piclist.push(tempPic);
			</c:forEach>
			makeimgGallery(piclist);
		</c:when>
		</c:choose>
		
		//게시글을 보는사람이 글 작성자인지 아닌지 판단하여 수정,삭제 기능 부여
		if("${loginUser.userid}" == "${usedDto.userid}"){
			$(".regist").prepend(
				"<input type='button' id='used_update' value='수  정' onclick='location.href=\"usedcontroller?command=usedupdateform&usedno=${usedDto.usedno}\"'>&nbsp;&nbsp;"
				+"<input type='button' id='used_delete' value='삭  제' onclick='used_delete()'>&nbsp;&nbsp;"
			);
			$(".status").append(
				"<input type='button' id='status_n' value='거 래 중' onclick=\"location.href='usedcontroller?command=usedstatus&status=N&usedno=${usedDto.usedno}'\">&nbsp;&nbsp;"
				+"<input type='button' id='status_y' value='거 래 완 료' onclick=\"location.href='usedcontroller?command=usedstatus&status=Y&usedno=${usedDto.usedno}'\">&nbsp;&nbsp;"
			);
			
			if("${usedDto.usedstatus}" =="N"){
				$("#status_n").css('background','rgb(00,68,137)');
				$("#status_n").css('color','white');
				$("#status_n").css('cursor','default');
				$("#status_n").removeAttr("onclick");
			}else{
				$("#status_y").css('background','rgb(00,68,137)');
				$("#status_y").css('color','white');
				$("#status_y").css('cursor','default');
				$("#status_y").removeAttr("onclick");
			}
		} else{
			$(".regist").prepend(
					"<input type='button' id='ask' value='문  의' onclick='login_chk()'>&nbsp;&nbsp;"
			);
		}
	});
	
	function login_chk(){
		if(${loginUser==null}){
			if(confirm("로그인이 필요한 작업입니다.\n 로그인 하시겠습니까?")){
				location.href="login.jsp" 
				
			}
		} else{
			question1On1();
		}
	}
	
	function question1On1(){
		var option="top=10,left=10,width=430,height=455, status=no,menubar=no,toolbar=no,resizable=no";
		window.open("usedcontroller?command=askwriteform&usedno=${usedDto.usedno}&writer=${loginUser.userid}","1:1 문의하기",option);
	}
	
	function ask_detail(uskno,writer){
		
		//접근을 시도하는 사람이 판매자나 글 작성자인지 확인
		if( "${loginUser.userid}" == "${usedDto.userid}" || "${loginUser.userid}" == writer){
			
			var option="top=10,left=10,width=430,height=440, status=no,menubar=no,toolbar=no,resizable=yes";
			window.open("usedcontroller?command=used_ask_detail&writer=${loginUser.userid}&uskno="+uskno,"1:1 문의하기",option);
			
		} else{
			alert("판매자와 글 작성자만 접근 가능합니다.");
		}
		
	}
	
	//삭제의사 재확인
	function used_delete(){
		if(confirm("해당 게시글을 삭제하시겠습니까?")){
			location.href="usedcontroller?command=useddelete&usedno=${usedDto.usedno}";	
		}
	}
	
	//table에 리스트 요소를 만드는 함수
	function makeBoardList(list,reset_bl){
		//tbody의 자식 요소 초기화
		$(".ask_list tbody").empty();
		
		//boardlist 초기화 여부 판단
		if(reset_bl){
			boardlist=list;
		}
		//list에 들어있는 center 정보 추가
		for(var i = 0 ; i < list.length ; i++){
			
			var status;
			if(list[i].status == 'N'){
				status="<span class='waiting'>대기중</span>";
			} else{
				status="<span class='done'>답변완료</span>";
			}
			$(".ask_list tbody").append(
				"<tr>"
				+"<td>"
				+(i+1)+"</td>"
				+"<td>"+list[i].writer+"</td>"
				+"<td align='left'><span class='ask_contents'><a onclick='ask_detail("+list[i].no+",\""+list[i].writer+"\")'><b>"+list[i].title+"</b></a></span></td>"
				+"<td>"+status+"</td>"
				+"<td>"+list[i].reg+"</td>"
				+"</tr>"		
			);
		}
		//테이블 페이징
		tablePagenation();
	}
	function makeimgGallery(list){
		
		$(".pic").empty();
		
		for(var i = 0 ; i < list.length; i++){
			$(".pic").append(
				"<img class='usedpic' src='/download/"+list[i].path+"' alt = '"+list[i].name+"'>"
			);
		}
	}
	function tablePagenation(){
		/*
		변수 생성
		- rowsPerPage페이지당 보여줄 개수 20
		- rows 가로행 tr 
		- rowsCount 개수 100
		- pageCount 페이지네이션 개수 = 100/20
		- pagenumbers
		콘솔에서 pageCount 찍어보고
		*/
		$("#numbers").empty();
		var rowsPerPage = 3,
			rows = $('.ask_list tbody tr'),
			rowsCount = rows.length
			pageCount = Math.ceil(rowsCount/rowsPerPage),
			numbers = $('#numbers');
		
		/* 페이지네이션 li를 생성 반복문*/
		for(var i = 0 ; i < pageCount;i++){
			numbers.append('<li><a href="">'+(i+1)+'</a></li>');
		}
		//#numbers li:first-child a
		numbers.find('li:first-child a').addClass('active');
		
		//페이지네이션 함수 displayRows
		function displayRows(idx){
			
			var start = (idx)*rowsPerPage;
				end = start + rowsPerPage;
				
			rows.hide();
			//해당하는 부분만 보여줌
			rows.slice(start,end).show();
		}
		
		displayRows(0);
		//페이지네이션 클릭시 보여주기
		/*
			클릭한 그 a 태그의 active,
			그 요소의 숫자를 dislplayRows의 매개변수로 지정
		*/
		numbers.find('li').click(function(e){
			//a태그의 이벤트를 막음
			e.preventDefault();
			
			numbers.find('li a').removeClass('active');
			$(this).find('a').addClass('active');
			var index = $(this).index();
			displayRows(index);
		});
	}
	
	   //찜 버튼 클릭 시 
	   function clickLike(){
	      /* 1. ajax 로 USED_WISH 테이블에 데이터 넣기
	      2. 빈하트 -> 채워진 하트로 배경이미지를 변경 */

	      var param = {
	         "login_id" : $("#login_id").val(),
	         "title_no" : $("#used_no").val(),
	         "type" : "U"
	      }
	      
	      console.log(param);
	      
	      
	      // 찜을 설정한 경우
	      if($("#wish").val() == "1"){
	         // 찜 해제 필요
	         param.wish_data = "1";
	      
	      } else {
	         //찜 설정
	         param.wish_data = "0";
	      }
	      
	      
	      $.ajax({             
	         url : "usedcontroller?command=wish"  ,   //어디로 요청을 보낼지
	         dataType : "json",                   //서버로부터 받을 데이터 타입
	         data : param,
	         success:function(msg){               //성공시 실행
	            console.log(msg);
	            $(".button-add").css({"background":"url(./img/heart.png)"});  
	            location.reload();
	            //console.log(msg);
	         },
	         error:function(){                  //실패시 실행
	            alert("실패ㅠㅠ");
	         }
	      })
	      
	   }

</script>
</head>
<body>

	<header><%@ include file="form\header.jsp" %></header>
	<br><br><br><br>
	<div class="wrap">
		<div class="used_detail">
			
			
			<div class="content">
			<div class="headline">
				<div class="title">
					<span id="category">[${usedDto.usedcategory}]</span>
					<span id="title">${usedDto.usedtitle}</span>
					<!-- <label class='checkbox-wrap'><input type='checkbox' name='wish_list' id='center_no1'><i class='check-icon'></i></label> -->
					<input type="button" onclick="clickLike()" class="button-add" />
				</div>
				
				<div class="write_info">
					<a>${usedDto.userid}</a>
					<a>${usedDto.usedreg}</a>
					<c:choose>
					<c:when test="${loginUser !=null }">
					<input type="hidden" id = "login_id" value="<%=loginUser.getUserid() %>">
               		<input type="hidden" id = "used_no" value="<%=request.getParameter("usedno") %>">
               		<input type="hidden" id = "wish" value="${wish}"> 
					</c:when>
					</c:choose>
				</div>
				<br><hr>
			</div>
				<div id="map">					
				</div>		
						
				<div class="content_info">
					<table width="100%">
						<col width="20%">
						<col width="80%">
						<tr>
							<th>가격</th>
							<td>${usedDto.usedprice}</td>
						</tr>
						<tr>
							<th>센터명</th>
							<td>${usedDto.usedcenternm}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${usedDto.usedaddr}</td>
						</tr>
						<tr>
							<th>상세정보</th>
							<td>${usedDto.usedcontent}</td>
						</tr>
					</table>
				</div>
				
				<div class="pic">
					<h3 align="left">이미지</h3><br>
					<img src="./img/no_photo.png">
				</div>
				
				<div class="ask_list">
				<h3 align="left">1:1문의 게시글</h3><br>
				<table width="100%">
					<col width="40px">
					<col width="60px">
					<col width="200px">
					<col width="80px">
					<col width="120px">
					<thead>
						<tr>
							<th>번호</th><th>작성자</th><th>제목</th><th>답변상태</th><th>작성일</th>
						</tr>
					</thead>
					<tbody>
					<tr><td colspan="5"><div id='board_blank'>아직등록된 게시글이 없습니다.</div></td></tr>
					</tbody>
				</table>
				<div class="pagination">
					<ol id="numbers"></ol>
				</div>
				<br>
				<div class="status">
					
				</div>
				</div>
			</div>			
			
		</div>
		<div class="regist">
				<input type="button" id="list" value="목  록" onclick="location.href='usedcontroller?command=usedlist'">
		</div>
	</div>
	
	<footer><%@ include file="form\footer.jsp" %></footer>	
</body>
</html>