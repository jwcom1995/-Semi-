<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* 시스템검색 autocomplete 스크롤바 높이지정 */
.ui-autocomplete {max-height:200px; overflow-y:auto; overflow-x:hidden; }
</style>
<style type="text/css">
	.p_btn {text-align:center; margin-top:10px;}
	.p_btn a {display:inline-block; margin:0 2px; color: #000; text-decoration: none; cursor: pointer;}
	.p_btn a.btn_confirm {border:1px solid #12508c; background:#266bae; padding:10px 35px; color:#fff; font-family:"Dodum", "돋움", sans-serif;font-weight:bold;letter-spacing:-0.075em; font-size:20px;}
	.p_btn a.btn_confirm:hover {background:#115393;}
	
</style>
</head>
<body>
<!-- 개인정보 보호정책 -->
				<div class="agreement">
					<div class="confirm_subtitle">프로모션 정보 수신</div>
					<div class="useStplatCn">
						<ul>
							<li>
								<textarea id="useStplatCn" cols="100" rows="17" class="agreement_contents" style="resize: none; font-size: 15px;">
								
개인정보보호법 제22조 제4항에 의해 선택정보 사항에 대해서는 기재하지 않으셔도 서비스를 이용하실 수 있습니다.

1. 마케팅 및 광고에의 활용신규 서비스(제품) 개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 인구통계학적 특성에 따른 서비스 제공 및 광고 게재, 서비스의 유효성 확인, 접속빈도 파악 또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.

2. "우리동네 헬스장"은 서비스를 운용함에 있어 각종 정보를 서비스 화면, 전화, e-mail, SMS, 우편물, 앱푸시 등의 방법으로 "우리동네 헬스장" 회원에게 제공할 수 있으며, "우리동네 헬스장" 쿠폰의 수신 등, 의무적으로 안내되어야 하는 정보성 내용은 수신동의 여부와 무관하게 제공됩니다.
								</textarea>
							</li>
						</ul>
					</div>
				</div>
				
				<div class="p_btn">
					<span id="btn_confirm"><a href="javascript: window.close();" class="btn_confirm">닫기</a></span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>