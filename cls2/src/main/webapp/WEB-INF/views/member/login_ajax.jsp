<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/cafe/css/w3.css">
<link rel="stylesheet" type="text/css" href="/cafe/css/user.css">
<script type="text/javascript" src="/cafe/js/jquery-3.6.0.min.js"></script>
<style type="text/css">
	#fr {
		display: none;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		// btn1 click event
		$('#btn1').click(function(){
			/*
			var sid = $('#id').val(); // 입력태그의 경우는 입력된 내용을 읽어오는 방법은 $(태그선택).val();
			// 입력태그에 강제로 데이터 쓰는 방법은 
			//		$(태그선택).val(데이터);
			var spw = $('#pw').val();
			alert(sid + ' : ' + spw);
			*/
			
			var result = $('#fr').css('display');
			if( result == 'block'){
				$('#fr').stop().slideToggle(1000);
			}
			/*
			var result = $('#fr').hasClass('w3-hide');
			
			if(result != true){
			} else {
//				$('#fr').toggleClass('w3-hide');
				$('#fr').stop().slideToggle(1000);
			}
			*/
		});
		
		// login 버튼 이벤트 처리
		$('#btn2').click(function(){
			var sid = $(document.frm.id).val();
			var spw = $(document.frm.pw).val();
			
			if(!(sid && spw)){
				alert('입력사항을 확인하세요!');
				return;
			}
			
			/*
			// 서버에게 요청해야 한다.
				
				일반적으로 로그인처리는 비동기통신으로 처리하는 것은 아니다.
				
				이 예제의 경우는 비동기 통신 연습용으로
				이 예제에 한해서만 비동기 통신으로 로그인 처리를 해보기로 하자.
				
				Ajax(Asynchronous JavaScript and XML, 에이잭스)는 
				비동기적인 웹 애플리케이션의 제작을 위해 아래와 같은 조합을 이용하는 웹 개발 기법이다.
				
				jQuery 에서는 비동기통신을 쉽게 할 수 있도록 함수를 제공해주고 있다.
				
					형식 ]
						
						$.ajax({
							url: 'XXXXXX',	// ==> 요청주소 (파라미터는 제외..)
							type: 'GET 또는 POST',	// 요청 방식
							dataType: 'XXXXXXXXX',	// 응답문서의 형식
							data: {					// 전달할 데이터(파라미터)
								id: 'XXXX',
								pw: 'XXXXXX'
							},
							success: function(data){
								// 통신에 성공한 경우 
								// 이 경우 서버에서 응답해준 내용이 data 매개변수에 기억된다.
								
								// 우리의 경우 서버가 응답해준 내용이 그대로 data 라는 변수에 기억된다.
									==> 서버가 응답해주는 내용은 YES 인경우
											{"result": "YES"}
										일 것이고
										결과적으로
											var data = {"result": "YES"};
										와 같은 결과가 된다.
								
							},
							error: function(){
								// 통신에 실패했을경우 실행되는 부분...
							}
						});
			*/
			
			$.ajax({
				url: 'http://localhost:8090/member/login.cls2',
				type: 'POST',
				dataType: 'json',
				data: {
					id: sid,
					pw: spw
				},
				success: function(obj){
					if(obj.result == 'YES'){
						// 태그에 데이터 채우고
						$('#sid').html(sid);
						$('#spw').html(spw);
						
						// 입력창 가리고...
						$('.showFr').addClass('w3-hide');
						// 메세지 창 보이게 해주고
						$('#fr').stop().slideDown(1000);
					} else {
						// 이 경우는 로그인에 실패한 경우이다.
						// 따라서 입력내용을 모두 지우고 포커스를 아이디로 이동시키자.
						alert('result : ' + obj.result);
						$('#frm').reset();
						$('#id').focus();
					}
				},
				error: function(){
					alert('####### 통신 에러 #######');
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="w3-content mxw650 w3-center">
		<h1 class="w3-blue w3-padding w3-card-4 w3-round-large">Login</h1>
		
		<form method="POST" action="http://localhost/member/login.cls2" name="frm" id="frm"
				class="showFr">
			<div class="w3-col w3-margin-top w3-card-4 w3-padding w3-round-large">
				<div class="w3-col w3-margin-top">
					<label for="id" class="w3-col m3 w3-right-align w3-text-grey">아이디 : </label>
					<input type="text" name="id" id="id" class="w3-col m8 mgl20">
				</div>
				<div class="w3-col pdt10 w3-margin-bottom">
					<label for="pw" class="w3-col m3 w3-right-align w3-text-grey">비밀번호 : </label>
					<input type="password" name="pw" id="pw" class="w3-col m8 mgl20">
				</div>
			</div>
		</form>
		
		<div class="w3-col w3-margin-top w3-card-4 w3-round-xlarge pdAll20" id="fr">
			<div class="w3-col w3-border w3-round-large w3-padding">
				<h3 class="w3-center w3-text-green">아이디 : <span id="sid"></span></h3>
				<h3 class="w3-center w3-text-green">비밀번호 : <span id="spw"></span></h3>
			</div>
		</div>
		
		<div class="w3-col w3-margin-top w3-card-4 showFr">
			<div class="w3-half w3-padding w3-red w3-hover-orange" id="btn1">reset</div>
			<div class="w3-half w3-padding w3-green w3-hover-lime" id="btn2">login</div>
		</div>
	</div>
</body>
</html>