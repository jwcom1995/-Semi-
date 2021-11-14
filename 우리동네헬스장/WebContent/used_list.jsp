<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고거래 게시판</title>
<style type="text/css">

/*눈누 원스토어 모바일POP체*/
@font-face {
    font-family: 'ONE-Mobile-POP';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/ONE-Mobile-POP.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
#title hr{
	height:3px;
	background-color:#036;
}
h1{
	text-align:left;
}
#wrap{
	width:80%;
	margin: 0 auto;
	text-align: center;
}
#search {
	display: flex;
	align-items: center;
	font-size: 15px;
	font-weight: bold;
	padding:10px;
	background:#9EB9CE;
}
.sorting_sub{
	width:180px;
	height:30px;
	text-align:center;
}
#search select {
	height: 25px;
	font-size:16px;
}
#usedboard_list img{
	border-radius: 30%;
	width:200px;
	height:200px;
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
/*찜 버튼 구현 끝*/

input[type=button]{

	margin-top:10px;
	margin-left:10px;
	background: rgb(00,68,137);
	font-weight:600;
	color : white;
	width:100px;
	height:40px;
	font-size:18px;
	border-radius: 5px;
	cursor:pointer;
	outline:none;
	box-shadow:none;
	border:none;

}
.used_brief a{
	text-decoration: none;
	color:black;
}
.used_brief {
	width: 100%;
	height: 200px;
	padding:10px;
	border: 2px solid black;
	border-radius: 25px;
	min-width: 600px;
	text-align:left;
	box-sizing: border-box;
}
.used_brief > span{
	margin-top:10px;
	font-weight:bold;
}
.used_brief .brief_title{
	font-family:'ONE-Mobile-POP';
	font-size:20px;
}
.brief_distance{
	color:blue;
}

#search_result{
	color : blue;
}
tbody tr{
	height:215px;
}
tfoot input{
	margin-top:15px;
	width: 85px;
	height: 35px;
	border-radius: 5px;
	border: none;
	font-weight: bold;
	cursor:pointer;
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

.brief_category{
	text-align:center;
	font-weight:bold;
	width:90px;
	font-size:18px;
	display:inline-block;
}
.brief_title{
	min-width:450px;
	width:85%;
	display:inline-block;
}
a{
	cursor:pointer;
}
.waiting{
	text-align:center;
	width:80px;
	display:inline-block;
	background:rgb(15, 82, 186);
	color:white;
	font-weight:bold;
	font-size:16px;
	border-radius:5px;
}
.done{
	text-align:center;
	width:80px;
	display:inline-block;
	background:gray;
	color:white;
	font-weight:bold;
	font-size:16px;
	border-radius:5px;
}
</style>

<script type="text/javascript"	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cf6a0311e8ff428c0d13bd95e775d7f3&libraries=services"></script>
<script type="text/javascript">

	//controller 에서 받아올 used db정보
	var usedList;
	var piclist;
	//실제로 CenterBoard에 표현되는 리스트들
	var boardlist;
	//페이지 시작과 동시에 실행될 작업들
	$(function(){
		
		usedList = new Array();
		
		var usedObj = function(no,title,writer,addr,price,category,status){
			this.no=no;
			this.title = title;
			this.writer=writer;
			this.addr=addr;
			this.price=price;
			this.category=category;
			this.status=status;
		}
		
		<c:forEach items="${usedList}" var="used">
			var tmpUsed = new usedObj("${used.usedno}","${used.usedtitle}","${user.userid}","${used.usedaddr}"
					,"${used.usedprice}","${used.usedcategory}","${used.usedstatus}");
			usedList.push(tmpUsed);
		</c:forEach>
		
		piclist = new Array();
		
		var picObj = function(usedno,name,path){
			this.usedno = usedno;
			this.name = name;
			this.path = path;
		}
		
		<c:choose>
		<c:when test="${!empty piclist}">
		<c:forEach items="${piclist}" var="pic">
			var tempPic = 
				new picObj("${pic.boardno}","${pic.picname}","${pic.picpath}");
			piclist.push(tempPic);
		</c:forEach>		
		</c:when>
		</c:choose>
		//주소-좌표 변환 해주는 객체 생성
		var geocoder = new kakao.maps.services.Geocoder();
		
		var index = 0;
		
		for (var i = 0; i < usedList.length; i++) {

			//주소 검색하여 주소를 좌표로 변환
			geocoder.addressSearch(	usedList[i].addr,function(result, status) {

				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {					
					//위도 경도 넣기
					usedList[index].x=result[0].x;
					usedList[index].y=result[0].y;
					index++;
				}
			});
		}
		makeBoardList(usedList,true);
	});
	
	//table에 리스트 요소를 만드는 함수
	function makeBoardList(list,reset_bl){
		//tbody의 자식 요소 초기화
		$("tbody").empty();
		
		//boardlist 초기화 여부 판단
		if(reset_bl){
			boardlist=list;
		}
		//list에 들어있는 center 정보 추가
		for(var i = 0 ; i < list.length ; i++){
			//center 정보중 pic가 null,공백 일 경우 default 이미지를 넣음
			var imgtag;
			var tmppic = piclist.filter(function(e){
				return e.usedno == list[i].no;
			});
			if(tmppic[0] == undefined){
				imgtag="<img src='img/center_default.png'>";
			}else{
				imgtag="<img src='/download/"+tmppic[0].path+"'alt ='"+tmppic[0].name+"'>";
			}
			
			var distanceinfo;
			
			if(list[i].distance != null){
				distanceinfo="<br><span class='brief_distance'>&nbsp;&nbsp; 거리 : "+Math.round(list[i].distance)+"m</span><br>";
			} else{
				distanceinfo="";
			}
			
			var status;
			if(list[i].status == 'N'){
				status="<span class='waiting'>거래중</span>";
			} else{
				status="<span class='done'>거래완료</span>";
			}
			$("tbody").append(
				"<tr>"
				+"<td>"
				+"<a href='usedcontroller?command=useddetail&usedno="+list[i].no+"'>"
				+imgtag+"</a></td>"
				+"<td>"
				+"<div class='used_brief'>"
				+"<a href='usedcontroller?command=useddetail&usedno="+list[i].no+"'>"
				+"<span class='brief_category'>["+list[i].category+"]</span><span class='brief_title'>"+list[i].title+"</span></a>"
				+"<label class='checkbox-wrap'><input type='checkbox' name='wish_list' id='center_no1'><i class='check-icon'></i></label>"
				+"<br><hr>"
				+"<span class='brief_addr'>&nbsp;&nbsp; 주소 : "+list[i].addr+"</span>"+"<br>"
				+"<span class='brief_price'>&nbsp;&nbsp; 가격 : "+list[i].price+"</span>"+"<br>"
				+"<span class='brief_status'>&nbsp;&nbsp; 거래상태 : " +status+"</span><br>"
				+distanceinfo
				+"</div></td>"
				+"</tr>"		
			);
		}
		//테이블 페이징
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
		var rowsPerPage = 5,
			rows = $('#usedboard_list tbody tr'),
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
	
	function searchAddr() {
		var address = $('input[name=address]').val();
		
		//주소입력이 null값 공백인지 확인후 알림
		if (!address) {
			alert("올바른 주소를 입력해주세요");
		}
		//주소입력이 null값이 아닌경우 좌표 이동
		else {
			$.ajax({
				url : 'https://dapi.kakao.com/v2/local/search/address.json?query='+encodeURIComponent(address),
				type : 'GET',
				headers : {	'Authorization' : 'KakaoAK f897ab2bc89e5486a5355b613e9fd8a7'},
				success : function(data) {
					console.log(data);

					var nearCenterlist = nearCenterfinder(data.documents[0].y, data.documents[0].x);
										
					//distance 기준으로 오름차순정렬(위의 코드 한줄로 표현)
					nearCenterlist.sort((a,b) => a.distance-b.distance);
					
					makeBoardList(nearCenterlist,true);
					
					$("#search_result").empty();
					$("#search_result").append("2km내 기준 게시글 중, 총 "+nearCenterlist.length+"개의 검색 결과가 있습니다.")
				},
				error : function(e) {
					console.log(e);
				}
			});
		}
	}
	//해당 좌표 근처에 있는 센터 찾기
	function nearCenterfinder(lat,lon){
		var nearCenterlist = new Array();
		
		var index=0;
		for(var i = 0 ; i < usedList.length; i++){

			//2km 근방에 있는 센터리스트를 불러옴
			if(distanceLoc(lat,lon,usedList[i].y,usedList[i].x)<2000){
				nearCenterlist.push(usedList[i]);
				
				//계산한 거리를 객체의 distance요소를 추가하고 저장
				nearCenterlist[index].distance=distanceLoc(lat,lon,usedList[i].y,usedList[i].x);
				index++;
			}
		}
		
		return nearCenterlist;
	}
	
	//두 위도,경도 사이의 거리 반환 함수
	function distanceLoc(lat1,lon1,lat2,lon2){
		
		//지구의 반지름
		var R = 6372.8*1000;
		
		var dLat = Math.radians(lat2-lat1);
		var dLon = Math.radians(lon2-lon1);
		var a = Math.pow(Math.sin(dLat/2),2)+Math.pow(Math.sin(dLon/2),2)*Math.cos(Math.radians(lat1))*Math.cos(Math.radians(lat2));
		var c = 2 * Math.asin(Math.sqrt(a));
		
		return ((R*c));
	}
	//라디안 구하는 함수
	Math.radians = function(degrees) {
	    return degrees * Math.PI / 180;
	};
	
	//카테고리로 리스트 정렬
	function sort_by_category(){
		var selectedVal = $("select[name=center_category]").val();
		
		var sortedlist= new Array();
		
		//카테고리에 해당하는 used만 sortedlist에 넣음
		for(var i = 0 ; i <boardlist.length;i++){
			if(selectedVal=="all"){
				sortedlist.push(boardlist[i]);
			}
			else if(selectedVal=="gym" && boardlist[i].category=="헬스장"){
				sortedlist.push(boardlist[i]);
				
			}else if(selectedVal=="yoga" && boardlist[i].category=="요가"){
				sortedlist.push(boardlist[i]);
				
			}else if(selectedVal=="pilates" && boardlist[i].category=="필라테스"){
				sortedlist.push(boardlist[i]);
				
			}else if(selectedVal=="crossfit" && boardlist[i].category=="크로스핏"){
				sortedlist.push(boardlist[i]);
				
			}else if(selectedVal=="etc" && boardlist[i].category=="기타"){
				sortedlist.push(boardlist[i]);
				
			}
		}		
		//정렬된 리스트로 다시 만듬
		makeBoardList(sortedlist,false);
	}
	
	//가격으로 리스트 정렬
	function sort_by_price(){
		
		var selectedVal = $("select[name=price]").val();
		var tmplist = boardlist;
		
		if(selectedVal=="desc_price"){
			tmplist.sort((a,b) => b.price-a.price);
		}else{
			tmplist.sort((a,b) => a.price-b.price);
		}
		
		makeBoardList(tmplist,false);
	}
	
	//거래상태 기준정렬
	function sort_by_status(){
		
		var selectedVal = $("select[name=status]").val();
		
		var sortedlist= new Array();
		
		for(var i = 0 ; i < boardlist.length;i++){
			
			if(selectedVal == "status_y" && boardlist[i].status=='Y'){
				sortedlist.push(boardlist[i]);
			}else if (selectedVal == "status_n" && boardlist[i].status=='N'){
				sortedlist.push(boardlist[i]);
			}
		}
		
		makeBoardList(sortedlist,false);
	}
	
	function login_chk(){
		if(${loginUser==null}){
			if(confirm("로그인이 필요한 작업입니다.\n 로그인 하시겠습니까?")){
				location.href="login.jsp"
			}else{
				
			}
		} else{
			location.href="usedcontroller?command=usedwriteform";
		}
	}
</script>
</head>
<body>
	<header><%@ include file="./form/header.jsp" %></header>
	
	<div id="wrap">
	<div id="title">
		<br><br>
			<h1 >회원권 중고거래</h1><hr>
		</div>
	<br><br>
		<div id="search">
            <img src="img/icon_search.png" width ="40px" height="40px" onclick="searchAddr()"><input type="text" name="address" placeholder="ex)서울시 성북구" style="width:40%;height:37px;font-size:16px;" onkeyup="if(window.event.keyCode==13){searchAddr()}">&nbsp;&nbsp;
        	<div class="sorting_sub">
        	센터종류&nbsp; <select name="center_category" onchange="sort_by_category()">
        		<option value="all">전체</option>
				<option value="gym">헬스장</option>
				<option value="yoga">요가</option>
				<option value="pilates">필라테스</option>
				<option value="crossfit">크로스핏</option>
				<option value="etc">기타</option>
			</select>
			</div>
			<div class="sorting_sub" onchange="sort_by_price()">
			가격&nbsp; <select name="price">
				<option value="desc_price">가격 높은 순</option>
				<option value="asc_price">가격 낮은 순</option>
			</select>
			</div>
			<div class="sorting_sub" onchange="sort_by_status()">
			거래상태&nbsp; <select name="status">
				<option value="status_n">거래중</option>
				<option value="status_y">거래완료</option>
			</select>
			</div>
        </div>
        <br><br>
		<div id="search_result"></div>
		<br><br>
        <div id="usedboard_list">
			<table width="100%">
				<col width="200px">
				<tbody>
				</tbody>
				<tfoot>
					<tr>
					<td colspan="2" align="right">
					<input type="button" onclick="login_chk()" value="글 등 록">
					</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="pagination">
			<ol id="numbers">
			
			</ol>
		</div>
	</div>
	<footer><%@ include file="./form/footer.jsp" %></footer>
</body>
</html>