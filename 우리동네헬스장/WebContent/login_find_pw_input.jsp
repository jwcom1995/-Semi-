<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
response.setContentType("text/html; charset=UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리동네 헬스장</title>
<style type="text/css">
html {
	height: 100%;
}

body {
	margin: 0;
	height: 100%;
	background: #f5f6f7;
}

h5 {
	text-align: center;
}

#wrapper {
	position: relative;
	height: 100%;
}

#content {
	position: absolute;
	left: 50%;
	transform: translate(-50%);
	width: 460px;
}

h3 {
	margin: 19px 0 8px;
	font-size: 14px;
	font-weight: 700;
}

.box {
	display: block;
	width: 100%;
	height: 51px;
	border: solid 1px #dadada;
	padding: 10px 14px 10px 14px;
	box-sizing: border-box;
	background: #fff;
	position: relative;
}

.int {
	display: block;
	position: relative;
	width: 100%;
	height: 29px;
	border: none;
	background: #fff;
	font-size: 15px;
}



#USER_BIRTH DATE_wrap {
	display: table;
	width: 100%;
}

#bir_yy {
	display: table-cell;
	width: 147px;
}

#bir_mm {
	display: table-cell;
	width: 147px;
}

#bir_dd {
	display: table-cell;
	width: 147px;
}

#bir_mm, #bir_dd {
	padding-left: 2%;
}

#phone_wrap {
	display: table;
	width: 100%;
}

#phone_certification {
	display: table-cell;
	width: 70%;
}


select {
	width: 100%;
	height: 29px;
	font-size: 15px;
	background: #fff;
	background-size: 20px 8px;
	-webkit-appearance: none;
	display: inline-block;
	text-align: start;
	border: none;
	cursor: default;
	font-family: Dotum, '돋움', Helvetica, sans-serif;
	background-size: 20px 8px;
}

.btn_area {
	margin: 30px 0 91px;
}
.button1 {
	background-color: gray;
	color: white;
	border: 3px solid white;
	padding: 18px 0 15px;
	font-size:13px;
	width: 100%;	
}
#button2 {
	width: 100%;
	padding: 21px 0 17px;
	border: 0;
	cursor: pointer;
	color: white;
	background-color:rgb(75, 161, 231);
	border-radius: 10px;
	font-size: 20px;
	font-weight: 200;
}
</style>
<script type="text/javascript" src="js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	function phonechk(){
		var phonenum = document.getElementsByName("myphone")[0];
		
		if(phonenum.value.trim()==""||phonenum.value==null){
			alert("전화번호를 입력해주세요");
		}else{
			var target = "usercontroller?command=phonechk&myphone="+phonenum.value.trim();
			open(target,"","width=0,height=0");	
		}
	}
	function rannumchk(){
		var rannum = document.getElementsByName("rannum")[0].value;
		var inputnum = document.getElementsByName("inputnum")[0].value;
		
		if(rannum!=inputnum){
			alert("인증번호 오류");
			document.getElementsByName("inputnum")[0].focus();
			return false;
		}
		
		return true;
	}
</script>
</head>
<body>
	<header><%@ include file="form/login_header.jsp"%></header>
	
	<div id="wrapper">
		<h5>
			가입시 입력하셨던 전화번호를 작성해주세요. <br> 입력하신 전화번호로 인증번호를 발송해 드립니다.
		</h5>
		<div id="content">
		<form action="usercontroller?command=findpw" method="post"  onsubmit="return rannumchk()">
			<div>
				<h3 class="join_title">
					<label for="USER_ID">ID</label>
				</h3>
				<span class="box int_id">
				 <input type="text" id="id"
					class="int" maxlength="100" name="myid" placeholder="아이디 입력">
				</span>
			</div>
			<div>
				<h3 class="join_title">
					<label for="USER_BIRTH DATE">생년월일</label>
				</h3>

				<div id="USER_BIRTH DATE_wrap">
					<div id="bir_yy">
						<span class="box"> 
						<select id="yy" class="sel" name="mybirthyy" value="" required>
								<option value="00">년도</option>
								<option value="1990">1990</option>
								<option value="1991">1991</option>
								<option value="1992">1992</option>
								<option value="1993">1993</option>
								<option value="1994">1994</option>
								<option value="1995">1995</option>
								<option value="1996">1996</option>
								<option value="1997">1997</option>
								<option value="1998">1998</option>
								<option value="1999">1999</option>
								<option value="2000">2000</option>
								<option value="2001">2001</option>
								<option value="2002">2002</option>
								<option value="2003">2003</option>
								<option value="2004">2004</option>
								<option value="2005">2005</option>
								<option value="2006">2006</option>
								<option value="2007">2007</option>
								<option value="2008">2008</option>
								<option value="2009">2009</option>
								<option value="2010">2010</option>
								<option value="2011">2011</option>
								<option value="2012">2012</option>
								<option value="2013">2013</option>
								<option value="2014">2014</option>
								<option value="2015">2015</option>
								<option value="2016">2016</option>
								<option value="2017">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								<option value="2021">2021</option>
						</select>
						</span>
					</div>

					<div id="bir_mm">
						<span class="box"> <select id="mm" class="sel" name="mybirthmm" value="" required>
								<option>월</option>
								<option value="01">1</option>
								<option value="02">2</option>
								<option value="03">3</option>
								<option value="04">4</option>
								<option value="05">5</option>
								<option value="06">6</option>
								<option value="07">7</option>
								<option value="08">8</option>
								<option value="09">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
						</select>
						</span>
					</div>

					<div id="bir_dd">
						<span class="box"> <select id="dd" class="sel" name="mybirthdd" value="" required>
								<option value="00">일</option>
								<option value="01">1</option>
								<option value="02">2</option>
								<option value="03">3</option>
								<option value="04">4</option>
								<option value="05">5</option>
								<option value="06">6</option>
								<option value="07">7</option>
								<option value="08">8</option>
								<option value="09">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
								<option value="24">24</option>
								<option value="25">25</option>
								<option value="26">26</option>
								<option value="27">27</option>
								<option value="28">28</option>
								<option value="29">29</option>
								<option value="30">30</option>
								<option value="31">31</option>
						</select>
						</span>
					</div>

				</div>
			</div>
			<br>
			<br>
			<div>
				<h3 class="USER_PHONE">
					<label for="USER_PHONE">휴대전화번호</label>
				</h3>
				<span class="box"> 
				
				<select id="phone_contury"	class="sel">
						<option value="00">대한민국 +82</option>
						<option value="01">미국 +1</option>
						<option value="02">독일 +49</option>
						<option value="03">호주 +61</option>
						<option value="04">영국 +44</option>
				</select>
				</span>
				<br>
				
				<span class="box"> 
					<input type="text" id="dd" class="int" name="myphone" placeholder="전화번호 입력" value="" required="required">
				</span> 
				<br>
				<div id="phone_wrap">
					
					<div id="button1">
						<input type="button" value="인증번호 받기"	class="button1" onclick="phonechk();">
					</div>
					<div id="phone_certification">
					 <span class="box"> 
					 	<input type="text" id="dd" class="int" name="inputnum" placeholder="인증번호 6자리" value="" required="required">
					 	<input type="hidden" name="rannum" value="null">
					</div>
				</div>
			</div>
			
			<br>
			<br>

			<div>
				<h3 class="join_title">
					<label for="USER_EMAIL">E-Mail</label>
				</h3>
				<span class="box int_email">
				 <input type="text" id="email"
					class="int" maxlength="100" name="myemail" placeholder="이메일 주소 입력">
				</span>
			</div>
			<br>
			<br>
			<div class="btn_area">
				<button type="submit" id="button2">
					<span>확인</span>
				</button>
				<br><br>
				<button type="button" style="background-color: gray;" onclick="location.href='usercontroller?command=loginform'" id="button2">
					<span>취소</span>
				</button>
			</div>
		</form>

	<footer><%@ include file = "form/footer.jsp" %></footer>

		</div>

	</div>
	
</body>
</html>