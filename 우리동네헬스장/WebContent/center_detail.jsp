<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${centerDto.centername} 상세페이지</title>
<script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cf6a0311e8ff428c0d13bd95e775d7f3&libraries=services"></script>
<script type="text/javascript"	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	
	$(function(){
		
		 // 찜 설정이 된 경우 채워진 하트 이미지 표시
	     if($("#wish").val() == "1"){
	      $(".button-add").css({"background":"url(./img/heart.png)"});
	     }
		
		if("${loginUser.userid}" == "${centerDto.userid}"){
			$("#detail_button").prepend(
					'<input class="ip_button" type="button" value="수 정" onclick="location.href=\'CenterController?command=centerupdateform&centerno=${centerDto.centerno}\'">'+
					'<input class="ip_button" type="button" value="삭 제" onclick="delete_chk()">'
			);
		}
		
		//지도 띄우기
		var centerAddr = "${centerDto.centeraddr}";		
		
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
								+ "${centerDto.centername}"
								+ '</div>',
						position : coords
					});
				infowindow.open(map, marker);
			}
			
		});
		
		var reviewlist = new Array();
		// center 객체
		var reviewObj = function(no,writer,grade,content,reg) {
			this.no = no;
			this.writer = writer;
			this.grade = grade;
			this.content= content;
			this.reg=reg;
		}
		<c:choose>
		<c:when test="${!empty reviewList}">
		//CenterController 에서 보내준 reviewlist의 값을 넣어줌
			<c:forEach items="${reviewList}" var="review">
			var tempReview = 
				new reviewObj("${review.reviewno}","${review.reviewwriter}","${review.reviewgrade}"
					,"${review.reviewcontent}","${review.reviewreg}");
			reviewlist.push(tempReview);
			</c:forEach>
			makeBoardList(reviewlist);
		</c:when>
		</c:choose>
		
		var piclist = new Array();
		
		var picObj = function(centerno,name,path){
			this.centerno = centerno;
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
			$(".img_part").empty();
			$(".img_part").append("<img src='/download/"+piclist[0].path+"'alt='"+piclist[0].name+"'>");
		</c:when>
		</c:choose>
		
		
	});
	function delete_chk(){
		if(confirm("해당 게시글을 삭제하시겠습니까?")){
			location.href='CenterController?command=centerdelete&centerno=${centerDto.centerno}';
		}
	}
	
	function makeBoardList(list){
		//tbody의 자식 요소 초기화
		$("tbody").empty();
		
		//list에 들어있는 center 정보 추가
		for(var i = 0 ; i < list.length ; i++){
			var review_con;
			if(list[i].content.length > 15){
				review_con=list[i].content.substr(0,15);
				review_con=review_con+"...";
			}else{
				review_con=list[i].content;
			}
				
			$("tbody").append(
				"<tr><td>"
				+"<div class='review_content'>"
				+"<span class='review_writer'>&nbsp;&nbsp; <b>작성자 :</b> "+list[i].writer+"</span></a>"+"<br><hr>"
				+"<span class='review_grade'>&nbsp;&nbsp; " 
				+"<b>평점 :</b> <span class='star-rating'><span style='width:"+(list[i].grade*20)+"%'></span>"
                +"</span> ("+list[i].grade+")</span>"+"<br>"
				+"<span class='review_contents'>&nbsp;&nbsp; <b>내용 :</b> <a href='#' onclick='reviewdetail_chk("+list[i].no+")'>"+review_con+"</a></span>"+"<br>"
				+"<span class='review_reg'>&nbsp;&nbsp; <b>등록일 :</b> "+list[i].reg+"</span>"+"<br>"
				+"</div></td>"
				+"</tr>"		
			);
		}
		tablePagenation();
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
			rows = $('#review_list tbody tr'),
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
	function makeimgGallery(list){
		
		$(".cont_images").empty();
		
		for(var i = 0 ; i < list.length; i++){
			$(".cont_images").append(
				"<img src='/download/"+list[i].path+"' alt = '"+list[i].name+"'>"
			);
		}
	}
	function review_login_chk(){
		if(${loginUser==null }){
			if(confirm("로그인이 필요한 동작입니다.\n 로그인 하시겠습니까?")){
				location.href="login.jsp"
			}else{
				
			}
		} else{
			//로그인 상태라면 컨르롤러에 작업 요청
			location.href='CenterController?command=review_write_form&centerno=${centerDto.centerno}'
		}
	}
	
	function reviewdetail_chk(no){
		if(${loginUser==null }){
			if(confirm("로그인이 필요한 동작입니다.\n 로그인 하시겠습니까?")){
				location.href="login.jsp"
			}else{
				
			}
		} else{
			var popupX = window.screen.width/2;
			var popupY = window.screen.height/2;
			var option="top=300,left=200,width=510px ,height=575px , status=no,menubar=no,toolbar=no,resizable=no";
			window.open('CenterController?command=review_detail&loginid=${loginUser.userid}&reviewno='+no,"리뷰 상세보기",option);
		}
	}
	
	 function clickLike(){
	      /* 1. ajax 로 USED_WISH 테이블에 데이터 넣기
	      2. 빈하트 -> 채워진 하트로 배경이미지를 변경 */

	      var param = {
	         "login_id" : $("#login_id").val(),
	         "title_no" : $("#center_no").val(),
	         "type" : "C"
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

<style type ="text/css">
header, section, article, aside, main, nav, footer{
    display: block;
}
h1, p{
    margin: 0;
}
hr{
	height:2px;
	background-color:black;
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
    border-radius:10px;
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
#map{
	display:inline-block;
	width:500px;
	height:260px;
}
.center_cont{
	margin-bottom:30px;
	display:flex;
	justify-content: center;
	align-items: center;
	width:100%;
}
.cont_head{
	display:flex;
	align-content: center;
    align-items: center;
    justify-content: center;
	min-width:200px;
	height:200px;
	width:20%;
	border-right: 3px solid #036;
}
.cont_info{
	width:80%;
	padding:8px;
	padding-left:30px;
	height:200px;
	display:flex;
	align-content: center;
    align-items: center;
    justify-content: left;
}
.img_cont, .review_cont{
	width:90%;
	margin-left:5%;
	margin-top:30px;
	height: auto;
}
.img_cont{
	margin-top:60px;
}
.cont_images img{
	width:300px;
	height:200px;
	border-radius: 5px;
	margin:5px;
}
.review_content,.empty_review{
	height:150px;
	border: 2px solid black;
	border-radius: 5px;
	min-width:600px;
	margin-top:10px;
}
.review_content{
	padding:10px;
	box-sizing: border-box;
}
.review_content hr{
	height:1px;
	background-color:black;
}
.review_content a{
	text-decoration:none;
	color:black;
}
.review_content a:hover{
	color:gray;
}
.empty_review{
	line-height:150px;
	text-align:center;
}
/*별점 구현*/
.star-rating{
	width:128px;
	margin-left:5px;
}
.star-rating,.star-rating span{
	display:inline-block;
	height:24px;
	overflow:hidden;
	background:url("img/stars_empty.png") no-repeat;
}
.star-rating span{
	background:url("img/stars_filled.png") no-repeat;
	background-position:left bottom;
	line-height:0;
	vertical-align:top;
}
.txt_part{
	font-size:18px;
}
#review_header{
	display:flex;
	justify-content:space-between;
}
#review_header button{
	height:30px;
}
#review_button{
	align-self:flex-end;
}

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
/*찜 버튼 구현 끝*/

</style>
</head>
<body>
<header><%@ include file = "./form/header.jsp" %></header>
<div id="main">
        <div class="wrap">
            <div class="main_title">
            <br><br>
                <h1>${centerDto.centername}</h1><br>
            </div>
            <hr>
            <div class="top_cont">
                <div class="img_part">                	
                    <img src="./img/center_default.png">            
                </div>
                <div class="txt_part">
                    <p><b>${centerDto.centeraddr}</b></p>
                    <b>평점 : </b><span>
                    <span class="star-rating">
                    	<span style="width:${centerDto.centergrade*20}%"></span>
                    </span> (${centerDto.centergrade})
                    </span>
                    	<input type="button" onclick="clickLike()" class="button-add" />
					<c:choose>
                    <c:when test="${loginUser !=null }">
						<input type="hidden" id="login_id" value="<%=loginUser.getUserid()%>"> 
						<input type="hidden" id="center_no" value="<%=request.getParameter("centerno")%>">
						<input type="hidden" id="wish" value="${wish}">
					</c:when>
					</c:choose>
                </div>
            </div>
            <hr>
            <div class="information">
                <a href="#">센터소개</a>
                <a href="#a">이용정보</a>
                <a href="#b">운영시간</a>
                <a href="#c">프로그램</a>
                <a href="#d">사진</a>
                <a href="#e">이용후기</a>
            </div>
            <hr><br><br>
            <div class="text_cont">
                <div class="center_cont">
                    <div class="cont_head">
                        <h2 id="a">센터소개</h2>
                    </div>
                    <div class="cont_info">
                    	${centerDto.centerintro}
                    </div>
                </div>
                <div class="center_cont">
                	<div class="cont_head">
                		<h2 id="b">이용정보</h2>
                	</div>
                    <div class="cont_info">
                    	${centerDto.centercontent}
                    </div>
                </div>
                <div class="center_cont">
                	<div class="cont_head">
                		<h2 id="c">운영시간</h2>
                	</div>
                    <div class="cont_info">
                    	${centerDto.centerophour }
                    </div>
                </div>
                <div class="center_cont">
                	<div class="cont_head">
                		<h2 id="d">프로그램</h2>
                	</div>
                    <div class="cont_info">
                     	${centerDto.centerpro}
                    </div>
                </div>
                <div class="center_cont">
                	<div class="cont_head">
                		<h2 id="f">위치</h2>
                	</div>
                    <div class="cont_info">
                     	<div id="map"></div>
                    </div>
                </div>
            </div>
            <div class="img_cont">
                <div>
                    <h2 id="f">사진</h2>
                </div>
                <div class="cont_images">
                    <img src="./img/no_photo_big.png">
                </div>
            </div>
             <div class="review_cont">
                <div id="review_header">
                    <h2 id="e">이용후기</h2>
                    <div id="review_button">
                    	<input class="ip_button" type="button" onclick="review_login_chk()" value="리뷰작성">
                    </div>
                </div>
          
                <div id="review_list">
                	<table width="100%">
					<tbody>
					<tr><td>
					<div class="empty_review">
						<p>아직 등록된 리뷰가 없습니다.</p>
					</div>
					</td></tr>
					</tbody>
					<tfoot>
					<tr><td align="center">
					<div class="pagination"><ol id="numbers"></ol></div></td></tr>
					</tfoot>
					</table>
 				</div>           
            </div>
            <div id="detail_button" align="center">
            	<input class="ip_button" type="button" value="목 록" onclick="location.href='CenterController?command=centerlist'";>
            </div>
        </div>
       </div>
<header><%@ include file = "./form/footer.jsp" %></header>
</body>
</html>