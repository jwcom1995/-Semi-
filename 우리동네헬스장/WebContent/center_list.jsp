<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
%>
<%
response.setContentType("text/html; charset=UTF-8");
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 주변 센터</title>
<!-- kakao map api + services,clusterer 라이브러리 -->
<script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cf6a0311e8ff428c0d13bd95e775d7f3&libraries=services,clusterer"></script>
<script type="text/javascript"	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	
	//map, centerlist,piclist 는 다른 함수에도 필요하여 전역변수로 선언
	var map;
	var centerlist;
	var piclist;
	var locmarker;
	//실제로 CenterBoard에 표현되는 리스트들
	var boardlist;
	
	//지도 생성하는 과정
	window.onload = function() {
		var container = document.getElementById('map'); //지도를 표시할 div
		var options = {
			center : new kakao.maps.LatLng(37.498095, 127.027610), //지도의 중심 좌표
			level : 7
		//지도 확대 레벨
		};

		//지도 생성
		map = new kakao.maps.Map(container, options);

		// 주소-좌표 변환 객체를 생성	
		var geocoder = new kakao.maps.services.Geocoder();

		//마커 클러스터를 생성
		var clusterer = new kakao.maps.MarkerClusterer({
			map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
			averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
			minLevel : 8, // 클러스터 할 최소 지도 레벨
			disableClickZoom : true
		// 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
		});

		//마커 클러스터에 이벤트 등록
		kakao.maps.event.addListener(clusterer, 'clusterclick', function(
				cluster) {

			// 현재 지도 레벨에서 1레벨 확대한 레벨
			var level = map.getLevel() - 1;

			// 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
			map.setLevel(level, {
				anchor : cluster.getCenter()
			});
		});

		//Centercontroller에서 centerlist를 받아옴
		//javascript와 jstl혼용시 JSTL에선 Javascript 값을 받을수 없고 Javascript에선 JSTL값 받기 가능
		//웹 동작 순서 JAVA>JSTL>HTML>Javascript
		//객체를 담기위한 배열
		centerlist = new Array();
		// center 객체
		var centerObj = function(no,name,addr,price,category,grade) {
			this.no = no;
			this.name = name;
			this.addr = addr;
			this.price = price;
			this.category = category;
			//this.pic = pic;
			this.grade = grade;
		}

		//CenterController 에서 보내준 centerlist의 값을 넣어줌
		<c:forEach items="${centerlist}" var="center">
		var tempCenter = 
			new centerObj("${center.centerno}","${center.centername}","${center.centeraddr}","${center.centerprice}",
					"${center.centercategory}","${center.centergrade}");
		centerlist.push(tempCenter);
		</c:forEach>
		
		piclist = new Array();
		
		var picObj = function(centerno,name,path){
			this.centerno = centerno;
			this.name = name;
			this.path = path;
		}
		//CenterController 에서 보내준 piclist의 값을 넣어줌
		
		<c:forEach items="${piclist}" var="pic">
		var tempPic = 
			new picObj("${pic.boardno}","${pic.picname}","${pic.picpath}");
		piclist.push(tempPic);
		</c:forEach>
		
		makeCenterList(centerlist,true);
		//리콜함수로 주소값이 반환되기 때문에 index를 사용하여 centerlist 값에 접근
		
		
		var index = 0;
		for (var i = 0; i < centerlist.length; i++) {

			//주소 검색하여 주소를 좌표로 변환
			geocoder.addressSearch(	centerlist[i].addr,function(result, status) {

				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {

					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					centerlist[index].x=result[0].x;
					centerlist[index].y=result[0].y;
					// 결과값으로 받은 위치를 마커로 표시
					var marker = new kakao.maps.Marker({
						map : map,
						position : coords
					});
					map.setLevel(4);
					//마크 클러스트에 마커 추가
					clusterer.addMarker(marker);

					// 인포윈도우로 장소에 대한 설명을 표시
					var infowindow = new kakao.maps.InfoWindow(
						{
							content : '<div style="width:150px;text-align:center;padding:6px 0;">'
									+ centerlist[index].name
									+ '</div>'
						});
					index++;

					// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록
					// 이벤트 리스너로는 클로저를 만들어 등록
					// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
					kakao.maps.event.addListener(marker,'mouseover', makeOverListener(map,marker, infowindow));
					kakao.maps.event.addListener(marker,'mouseout',	makeOutListener(infowindow));
					}
			});
		}

		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
			return function() {
				infowindow.open(map, marker);
			};
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
			return function() {
				infowindow.close();
			};
		}
	}
	
	//센터리스트 요소를 만드는 함수
	function makeCenterList(list,reset_bl){
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
				return e.centerno == list[i].no;
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
			
			$("tbody").append(
				"<tr>"
				+"<td>"
				+"<a href='CenterController?command=centerdetail&centerno="+list[i].no+"'>"
				+imgtag+"</a></td>"
				+"<td>"
				+"<div class='center_brief'>"
				+"<label class='checkbox-wrap'><input type='checkbox' name='wish_list' id='center_no1'><i class='check-icon'></i></label>"
				+"<a href='CenterController?command=centerdetail&centerno="+list[i].no+"'>"
				+"<span class='brief_name'>"+list[i].name+"</span></a>"+"<br><hr>"
				+"<span class='brief_addr'>&nbsp;&nbsp; 주소 : "+list[i].addr+"</span>"+"<br>"
				+"<span class='brief_category'>&nbsp;&nbsp; 종류 : "+list[i].category+"</span>"+"<br>"
				+"<span class='brief_price'>&nbsp;&nbsp; 가격 : "+list[i].price+"</span>"+"<br>"
				+"<span class='brief_grade'>&nbsp;&nbsp; " 
				+"평점 : <span class='star-rating'><span style='width:"+(list[i].grade*20)+"%'></span>"
                +"</span> ("+list[i].grade+")</span>"+"<br>"+distanceinfo
				+"</div></td>"
				+"</tr>"		
			);
		}
		//테이블 페이징
		tablePagenation();
	}
	
	//입력한 값에따라 지도위치가 움직이고, 센터 리스트를 위치기준으로 변경
	function movePosition() {
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
					
					// 이동할 위도 경도 위치를 생성합니다 
					var moveLatLon = new kakao.maps.LatLng(data.documents[0].y, data.documents[0].x);
					// 지도 중심을 이동
					map.panTo(moveLatLon);
					
					//검색한곳을 표시할 마커의 옵션설정
					var imageSrc = 'img/placeholder.png',  
				    imageSize = new kakao.maps.Size(64, 69), 
				    imageOption = {offset: new kakao.maps.Point(27, 69)};
				    
					//이미 검색한 마커가 있을경우 마커 초기화
				    if(locmarker != null){
				    	locmarker.setMap(null);
				    }				    
				    
					// 설정한 마커옵션과 마커가 들어갈 위치를 지정
					var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
				    	markerPosition = new kakao.maps.LatLng(data.documents[0].y, data.documents[0].x);

					// 마커를 생성합니다
					locmarker = new kakao.maps.Marker({
				    	position: markerPosition, 
				    	image: markerImage
					});

					// 마커가 지도 위에 표시되도록 설정
					locmarker.setMap(map);  
					
					
					var nearCenterlist = nearCenterfinder(data.documents[0].y, data.documents[0].x);
					
					//distance 기준으로 오름차순정렬
					nearCenterlist.sort((a,b) => a.distance-b.distance);
					
					makeCenterList(nearCenterlist,true);
					
					$("#search_result").empty();
					$("#search_result").append("1.5km 반경내의 센터, 총 "+nearCenterlist.length+"개의 검색되었습니다.")
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
		for(var i = 0 ; i < centerlist.length; i++){

			//1.5km 근방에 있는 센터리스트를 불러옴
			if(distanceLoc(lat,lon,centerlist[i].y,centerlist[i].x)<1500){
				nearCenterlist.push(centerlist[i]);
				
				//계산한 거리를 객체의 distance요소를 추가하고 저장
				nearCenterlist[index].distance=distanceLoc(lat,lon,centerlist[i].y,centerlist[i].x);
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
		
		//카테고리에 해당하는 center만 sortedlist에 넣음
		for(var i = 0 ; i <boardlist.length;i++){
			if(selectedVal=="all"){
				sortedlist.push(boardlist[i]);
			}
			else if(selectedVal=="gym" && boardlist[i].category.includes("헬스")){
				sortedlist.push(boardlist[i]);
				
			}else if(selectedVal=="yoga" && boardlist[i].category.includes("요가")){
				sortedlist.push(boardlist[i]);
				
			}else if(selectedVal=="pilates" && boardlist[i].category.includes("필라테스")){
				sortedlist.push(boardlist[i]);
				
			}else if(selectedVal=="crossfit" && boardlist[i].category.includes("크로스핏")){
				sortedlist.push(boardlist[i]);
				
			}else if(selectedVal=="etc" && boardlist[i].category.includes("기타")){
				sortedlist.push(boardlist[i]);
				
			}
		}		
		//정렬된 리스트로 다시 만듬
		makeCenterList(sortedlist,false);
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
		
		makeCenterList(tmplist,false);
	}
	
	function sort_by_grade(){
		
		var selectedVal = $("select[name=grade]").val();
		var tmplist = boardlist;
		
		if(selectedVal=="desc_grade"){
			tmplist.sort((a,b) => b.grade-a.grade);
		}else{
			tmplist.sort((a,b) => a.grade-b.grade);
		}
		
		makeCenterList(tmplist,false);
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
			rows = $('#centerboard_list tbody tr'),
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
	
	function login_chk(){
		if(${loginUser==null}){
			if(confirm("로그인이 필요한 작업입니다.\n 로그인 하시겠습니까?")){
				location.href="login.jsp"
			}else{
				
			}
		} else{
			if(${loginUser.role eq 'GU'}){
				alert("BU등급 이상의 유저만 센터등록이 가능합니다.");
			}
			else{
			location.href="CenterController?command=centerwriteform";
			}
		}
	}
</script>



<style type="text/css">
/*눈누 원스토어 모바일POP체*/
@font-face {
    font-family: 'ONE-Mobile-POP';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/ONE-Mobile-POP.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
tbody a {
	text-decoration: none;
	color:black;
}
#title hr{
	height:3px;
	background-color:#036;
}
#wrap {
	width: 80%;
	margin: 0 auto;
	text-align: center;
}

#map {
	width: 700px;
	height: 400px;
	display: inline-block;
	border: 1px solid black;
	border-radius: 20px;
}

#search {
	display: flex;
	align-items: center;
	justify-content: center;
	padding:10px;
	background:#9EB9CE;
}

#searchicon {
	cursor: pointer;
}

#sorting {
	display: flex;
	justify-content: center;
	font-size: 15px;
	font-weight: bold;
	text-align: center;
}

.sorting_sub {
	width: 180px;
	height: 30px;
	font-weight:bold;
}

#search select {
	height: 25px;
	font-size:16px;
}
#centerboard_list img {
	border-radius:10px;
	width: 200px;
	height: 200px;
}

.center_brief {
	width: 100%;
	height: 200px;
	padding:10px;
	border: 2px solid black;
	border-radius: 25px;
	min-width: 600px;
	text-align:left;
	box-sizing: border-box;
}
.center_brief > span{
	margin-top:10px;
	font-weight:bold;
}
.center_brief .brief_name{
	font-family:'ONE-Mobile-POP';
	font-size:28px;
}

#search_result{
	color : blue;
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
/*찜 버튼 구현*/
.checkbox-wrap {
	cursor: pointer;
	position: relative;
	left: 95%;
}
.checkbox-wrap .check-icon {
	display: inline-block;
	width: 30px;
	height: 30px;
	background: url('img/emt_heart.png') left center no-repeat;
	vertical-align: middle;
	transition-duration: .3s;
}

.checkbox-wrap input[type=checkbox] {
	display: none;
}

.checkbox-wrap input[type=checkbox]:disalbed+.check-icon {
	background-image: url('img/emt_heart.png');
}

input[type=checkbox]:checked+.check-icon {
	background-image: url('img/heart.png');
}

/*평점 구현*/
.star-rating{
	width:128px;
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
tbody tr{
	height:215px;
}
tfoot input{
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
.brief_distance{
	color:blue;
}
#title{
	text-align:left;
}

</style>

</head>
<body>
	<header>
		<%@ include file="./form/header.jsp"%>
	</header>
	
	<div id="wrap">
		<div id="title">
		<br><br>
			<h1 >내 주변 센터 목록</h1><hr>
		</div>
	
	<br>
		<br><br>
		<div id="search">
			<!-- 엔터치거나 검색버튼 클릭시 검색함수 -->
			<img id="searchicon" alt="searchicon" src="img/icon_search.png"	width="40px" height="40px" onclick="movePosition();"> 
			<input	type="text" name="address" placeholder="서울시 성북구"	onkeyup="if(window.event.keyCode==13){movePosition()}" style="width: 500px; height: 37px; font-size: 16px;">
			<div class="sorting_sub">
				센터종류&nbsp; <select name="center_category" onchange="sort_by_category()">
					<option value="all">전체</option>
					<option value="gym">헬스</option>
					<option value="yoga">요가</option>
					<option value="pilates">필라테스</option>
					<option value="crossfit">크로스핏</option>
					<option value="etc">기타</option>
				</select>
			</div>
			<div class="sorting_sub">
				가격&nbsp; <select name="price" onchange="sort_by_price()">
					<option value="desc_price">가격 높은 순</option>
					<option value="asc_price">가격 낮은 순</option>
				</select>
			</div>
			<div class="sorting_sub">
				평점&nbsp; <select name="grade" onchange="sort_by_grade()">
					<option value="desc_grade">평점 높은 순</option>
					<option value="asc_grade">평점 낮은 순</option>
				</select>
			</div>
		</div>
		<br><br>
		<div id="map"></div>
		<br>
		<br>
		<br>
		<div id="search_result"></div>
		<br>
		<br>
		<div id="centerboard_list">
			<table width="100%">
				<col width="200px">
				<tbody>
				</tbody>
				<tfoot>
					<tr>
					<td colspan="2" align="right">
					<input class="ip_button" type="button" onclick="login_chk()" value="글 등 록">
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
	<footer>
		<%@ include file="./form/footer.jsp"%>
	</footer>
</body>
</html>