<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/cls2/css/w3.css">
<link rel="stylesheet" type="text/css" href="/cls2/css/user.css">
<script type="text/javascript" src="/cls2/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/cls2/js/w3color.js"></script>
<style type="text/css">
	.avtimg {
		width: 100px;
		height: 100px;
	}
	.avtbox {
		display: inline-block;
		width: 102px;
		height: 117px;
	}
	#pwmsg, #repwmsg, #avtfr, #mavt, #favt, #idmsg {
		display: none;
	}
	.btn {
		width: 100px;
		height: 38.22px;
		padding: 8px 16px;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('[name="gen"]').change(function(){
			var sgen = $(this).val();
			if(sgen == 'M'){
				$('#favt').css('display', 'none');
				$('#mavt').css('display', 'block');
				$('#avtfr').css('display', 'block');
			} else {
				$('#mavt').css('display', 'none');
				$('#favt').css('display', 'block');
				$('#avtfr').css('display', 'block');
			}
		});
		
		$('#rbtn').click(function(){
			document.frm.reset();
		});
		
		$('#hbtn').click(function(){
			$(location).attr('href', '/cls2/main.cls');
		});
		
		$('#jbtn').click(function(){
			// 할일
			// 입력된 데이터 읽고
			var sid = $('#id').val();
			var spw = $('#pw').val();
			var smail = $('#mail').val();
			var stel = $('#tel').val();
			var sgen = $('[name="gen"]:checked').val();
			var savt = $('[name="ano"]:checked').val();
			
			// 유효성 검사
			if(!(sid && spw && smail && stel && sgen && savt)){
				alert('필수 입력사항을 확인하세요!');
				return;
			}
			// 정규식 검사
			if(!(idChk() && mailCk() && nameCk() && telCk())){
				alert('형식에 맞지 않은 데이터가 있습니다.');
				return;
			}			
			
			// 폼 전송하고...
			$('#frm').submit();
		});
		
		function idChk(){
			var sid = $('#id').val();
			var exp = /^[a-zA-Z0-9]{2,8}$/;
			return exp.test(sid);
		}
		
		$('#id').keyup(function(){
			if(idChk()){
				$('#idmsg').removeClass('w3-text-red w3-text-blue').addClass('w3-text-green');
				$('#idmsg').html('*** 사용가능한 형식입니다. ***');
				$('#idck').removeClass("btn w3-center").addClass('w3-button');
				$('#idmsg').stop().slideDown(300);
				$('.w3-button#idck').unbind('click');
				$('.w3-button#idck').click(function(){
					// 할일
					// 아이디 읽고
					$('#idmsg').stop().slideUp(300);
					var sid = $('#id').val();
					
					$.ajax({
						url: '/cls2/member/idCheck.cls',
						type: 'post',
						dataType: 'json',
						data: {
							id: sid
						},
						success: function(obj){
							var result = obj.result;
							alert('id : ' + obj.id);
							if(result == 'OK'){
								$('#idmsg').html('*** 사용 가능한 아이디 입니다. ***');
								$('#idmsg').removeClass('w3-text-red').addClass('w3-text-blue');
								$('#idmsg').stop().slideDown(500);
							} else {
								$('#idmsg').html('### 사용 불가능한 아이디 입니다. ###');
								$('#idmsg').removeClass('w3-text-blue').addClass('w3-text-red');
								$('#idmsg').stop().slideDown(500);
							}
							
						},
						error: function(){
							alert('### 통신 실패 ###');
						}
					});
				});
			} else {
				$('#idmsg').removeClass('w3-text-green w3-text-blue').addClass('w3-text-red');
				$('#idmsg').html('### 사용 불가능한 형식입니다. ###');
				$('#idck').removeClass("w3-button").addClass('btn w3-center');
				$('#idmsg').stop().slideDown(300);
			}
		});
		
		function nameCk(){
			var exp = /^[가-힣]{2,}$/;
			var sname = $('#name').val();
			return exp.test(sname);
		}
		
		function mailCk(){
			var exp = /^[a-zA-Z!_+%*]{2,8}@[a-z]{2,}\.[a-z]{2,3}(\.[a-z]{2})?$/;
			var smail = $('#mail').val();
			return exp.test(smail);
		}
		
		function telCk(){
			var exp = /^0[0-9]{2}-[0-9]{3,4}-[0-9]{4}$/;
			var stel = $('#tel').val();
			return exp.test(stel);
		}
		
		
	});
</script>
</head>
<body>
	<div class="w3-content w3-margin-top mxw700">
		<!-- 타이틀 -->
		<h1 class="w3-pink w3-center w3-padding w3-card-4">cls2 회원가입</h1>
		<form method="POST" action="/cls2/member/joinProc.cls" name="frm" id="frm"
			class="w3-col w3-margin-top w3-margin-bottom w3-padding w3-card-4">
			<div>
				<label for="name" class="w3-col s3 w3-right-align w3-margin-top clrgrey ft14 mgb10">회원이름 : </label>
				<input type="text" name="name" id="name" class="w3-col s8 w3-margin-top mgl10 w3-input w3-border mgb10">
			</div>
			<div>
				<label for="id" class="w3-col s3 w3-right-align clrgrey ft14 mgb10">아 이 디 : </label>
				<div class="w3-col s8 mgl10">
					<input type="text" name="id" id="id" class="w3-col w3-input w3-border mgb10" style="width: 338px;">
					<div class="w3-col w100 w3-blue w3-right w3-center btn" id="idck">id check</div>
					<span class="w3-col mgb10" id="idmsg"></span>
				</div>
			</div>
			<div>
				<label for="pw" class="w3-col s3 w3-right-align clrgrey ft14 mgb10">비밀번호 : </label>
				<div class="w3-col s8 mgl10 mgb10">
					<input type="password" name="pw" id="pw" class="w3-col w3-input w3-border">
					<span class="w3-col w3-text-red" id="pwmsg"># 비밀번호는 12345 만 가능합니다.</span>
				</div>
			</div>
			<div>
				<label for="repw" class="w3-col s3 w3-right-align clrgrey ft14 mgb10">pw check : </label>
				<div class="w3-col s8 mgl10 mgb10">
					<input type="password" name="repw" id="repw" class="w3-col w3-input w3-border">
					<span class="w3-col w3-text-red" id="repwmsg"># 비밀번호가 일치하지 않습니다.</span>
				</div>
			</div>
			<div>
				<label for="mail" class="w3-col s3 w3-right-align clrgrey ft14 mgb10">회원메일 : </label>
				<input type="text" name="mail" id="mail" class="w3-col s8 mgl10 w3-input w3-border mgb10">
			</div>
			<div>
				<label for="tel" class="w3-col s3 w3-right-align clrgrey ft14 mgb10">전화번호 : </label>
				<input type="text" name="tel" id="tel" class="w3-col s8 mgl10 w3-input w3-border mgb10">
			</div>
			<div>
				<label class="w3-col s3 w3-right-align clrgrey ft14 mgb10">회원성별 : </label>
				<div class="w3-col s8 mgl10 mgb10 w3-center">
					<div class="w3-half">
						<input type="radio" name="gen" id="mgen" class="w3-radio" value="M"> <label for="mgen"> 남자</label>
					</div>
					<div class="w3-half">
						<input type="radio" name="gen" id="fgen" class="w3-radio" value="F"> <label for="fgen"> 여자</label>
					</div>
				</div>
			</div>
			<div id="avtfr">
				<label class="w3-col s3 w3-right-align clrgrey ft14 mgb10">아 바 타 : </label>
				<div class="w3-col s8 mgl10 mgb10 w3-center">
						<div class="avtboxfr w3-center w3-margin-top" id="mavt">
					<c:forEach var="idx" begin="1" end="3">
						 	<div class="avtbox">
						 		<label for="mavt${idx}">
						 			<img src="/cls2/img/avatar/img_avatar${idx}.png" class="w3-col avtimg">
						 		</label>
						 		<input type="radio" name="ano" id="mavt${idx}" value="1${idx}">
						 	</div>
				 	</c:forEach>
						 </div>
						 <div class="avtboxfr w3-center w3-margin-top" id="favt">
					<c:forEach var="idx" begin="4" end="6">
						 	<div class="avtbox">
						 		<label for="favt${idx}">
						 			<img src="/cls2/img/avatar/img_avatar${idx}.png" class="w3-col avtimg">
						 		</label>
						 		<input type="radio" name="ano" id="favt${idx}" value="1${idx}">
						 	</div>
				 	</c:forEach>
				 		</div>
				</div>
			</div>
		</form>
		
		<!-- 버튼 태그 -->
		<div class="w3-col w3-margin-top w3-card-4">
			<div class="w3-third w3-deep-orange w3-hover-orange w3-button" id="rbtn">reset</div> 
			<div class="w3-third w3-green w3-hover-lime w3-button" id="hbtn">home</div> 
			<div class="w3-third w3-blue w3-hover-aqua w3-button" id="jbtn">join</div> 
		</div>

<%-- 회원가입 실패시 메세지 처리 --%>
<c:if test="${not empty MSG}">
		<div id="msgWin" class="w3-modal">
			<div class="w3-modal-content mxw600 w3-center w3-card-4">
				<header class="w3-container w3-red"> 
					<span class="w3-button w3-display-topright" id="closeBtn">&times;</span>
					<h2>회원가입 실패</h2>
				</header>
				<div class="w3-container w3-margin-bottom">
					<h3 class="w3-padding w3-text-red">${MSG}</h3>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#msgWin').css('display', 'block');
				
				$('#closeBtn').click(function(){
					$('#msgWin').css('display', 'none');
				});
			});
		</script>
</c:if>
	</div>
</body>
</html>