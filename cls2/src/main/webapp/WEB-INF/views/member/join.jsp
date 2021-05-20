<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/cafe/css/w3.css">
<link rel="stylesheet" type="text/css" href="/cafe/css/user.css">
<script type="text/javascript" src="/cafe/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/cafe/js/w3color.js"></script>
<style type="text/css">
	 
   
   .avtimg {
      width: 100px;
      height: 100px;
   }
   .avtboxfr {
      /* padding-left: 100px; */
   }
   .avtbox {
      display: inline-block;
      width: 102px;
      height: 117px;
   }
   #avtfr,#mavt, #favt, #idmsg,#pwmsg, #repwmsg  {
      display: none;
   }
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('[name="gen"]').change(function(){
			
			var sgen = $(this).val();
			if(sgen =='M'){
				$('#favt').css('display', 'none');
				$('#mavt').css('display', 'block');
				$('#avtfr').css('display', 'block');
			}else{
				$('#mavt').css('display', 'none');
				$('#favt').css('display', 'block');
				$('#avtfr').css('display', 'block');
			}
		});
		
		$('#rbtn').click(function(){
			document.frm.reset();
		});
		
		
		$('#hbtn').click(function(){
			/*
			$('#frm').attr('action', '/cafe/main.cls');
			$('#frm').submit();
			*/
			$(location).attr('href', '/cafe/main.cls');
		});
		
		$('#idck').click(function(){
			//할일
			//아이디 읽고
			$('#idmsg').stop().slideDown(300);
			var sid = $('#id').val();
			
			$.ajax({
				url: '/cafe/member/idcheck.cls',
				type: 'post',
				dataType: 'json',
				data: {
					id: sid
				},
				success: function(data){
					var result = data.result;
					
					if(result == 'OK'){
						$('#idmsg').html('* 사용가능한 아이디입니다. *');
						$('#idmsg').removeClass('w3-text-red').addClass('w3-text-blue');
						$('#idmsg').stop().slideDown(500);
					} else{
						$('#idmsg').html('* 사용불가능한 아이디입니다. *');
						$('#idmsg').removeClass('w3-text-blue').addClass('w3-text-red');
						$('#idmsg').stop().slideDown(500);	
					}
				},
				error: function(){
					alert('###통신 실패###');					
				}
			})
		});
		
		$('#jbtn').click(function(){
			//할일
			//입력된 데이터 읽고
			var sid = $('#id').val();
			var spw = $('#pw').val();
			var smail = $('#mail').val();
			var stel = $('#tel').val();
			var sgen = $('[name="gen"]:checked').val();
			var savt = $('[name="avt"]:checked').val();
			
			// 유효성 검사
			if(!(sid && spw && smail && stel && sgen && savt)){
				alert('필수 입력사항을 확인하세요');
				return;
			}
			
			//정규식 검사
			$('#frm').submit();
		});
	});
	
</script>
</head>
<body>
	<div class="w3-content w3-margin-top mxw700">
		<!--  타이틀  -->
		<h1 class="w3-pink w3-center w3-padding w3-card-4">Cls 회원가입</h1>
		<form method ="POST" action="/cafe/member/joinProc.cls"  name="frm" id="frm"
			class="w3-col w3-margin-top w3-margin-bottom w3-padding w3-card-4">
			<div >
				<label for="name" class="w3-col s3 w3-right-align w3-margin-top clrgray ft14 mgb10 "> 회원이름 : </label>
				<input type="text" name="name" id="name" class="w3-col s8  w3-margin-top mgl10 w3-input w3-border mgb10">
			</div>
				<label for="id" class="w3-col s3 w3-right-align ft14 mgb10 clrgray"> 아이디 : </label>
			<div class="w3-col s8 mgl10">
				<input type="text" name="id" id="id" class="w3-col s8 w3-input w3-border mgb10">
				<div class="w3-col s3 w3-button w3-blue w3-right" id="idck"> id check</div>
				<span class="w3-col mgb10" id="idmsg"></span>

			</div>
			<div >
				<label for="pw" class="w3-col s3 w3-right-align clrgray ft14 mgb10 "> 비밀번호 : </label>
			<div class="w3-col s8 mgb10 mgl10">
				<input type="password" name="pw" id="pw" class="w3-col s8 w3-input w3-border mgb10">
				<span class="w3-col w3-text-red" id="pwmsg"> 비밀번호는 12345만 가능합니다.</span>
			</div>
			</div>
			<div >
				<label for="repw" class="w3-col s3 w3-right-align clrgray ft14 mgb10 "> pw check : </label>
			<div class="w3-col s8 mgl10 mgb10">
				<input type="password" name="repw" id="repw" class="w3-col s8 w3-input w3-border mgb10">
				<span class="w3-col w3-text-red" id="repwmsg">비밀번호가 일치하지않습니다.</span>
			</div>
			</div>
			<div >
				<label for="mail" class="w3-col s3 w3-right-align  clrgray ft14 mgb10 "> 회원메일 : </label>
				<input type="text" name="mail" id="mail" class="w3-col s8   w3-margin-top mgl10 w3-input w3-border mgb10">
			</div>
			<div >
				<label for="tel" class="w3-col s3 w3-right-align  clrgray ft14 mgb10 "> 전화번호 : </label>
				<input type="text" name="tel" id="tel" class="w3-col s8   mgl10 w3-input w3-border mgb10">
			</div>
			<div >
				<label class="w3-col s3 w3-right-align clrgray ft14 mgb10 ">회원 성별 : </label>
			<div class="w3-col s8 mgl10 mgb10 w3-center">
				<div class="w3-half">
				<input type="radio" name="gen" id="mgen" class="w3-radio" value="M"> <label for="mgen" > 남자</label>
				</div>
				<div class="w3-half">
				<input type="radio" name="gen" id="fgen" class="w3-radio" value="F"> <label for="fgen" > 여자</label>
				</div>
				</div>
				</div>
			<div id="avtfr">
	            <label class="w3-col s3 w3-right-align clrgray ft14 mgb10">아바타 : </label>
	            <div class="w3-col s8 mgl10 mgb10 w3-center">
	               <div class="avtboxfr w3-center w3-margin-top" id="mavt">
	               <c:forEach var="idx" begin="1" end="3">
	                      <div class="avtbox">
	                         <label for="mavt${idx}">
	                            <img src="/cafe/img/avatar/img_avatar${idx}.png" class="w3-col avtimg">
	                         </label>
	                         <input type="radio" name="avt" id="mavt${idx}" value="${idx}">
	                      </div>
	                </c:forEach>
	                   </div>
	            </div>
            </div>       
                   <div class="avtboxfr w3-center w3-margin-top" id="favt">
               <c:forEach var="idx" begin="4" end="6">
                      <div class="avtbox">
                         <label for="favt${idx}">
                            <img src="/cafe/img/avatar/img_avatar${idx}.png" class="w3-col avtimg">
                         </label>
                         <input type="radio" name="avt" id="favt${idx}" value="${idx}">
                      </div>
                </c:forEach>
			</div>
		</form>
				<div class="w3-col s4 w3-padding w3-card-4 w3-button  w3-pink" id="rbtn">RISET</div>
				<div class="w3-col s4 w3-padding  w3-card-4 w3-button w3-green" id="hbtn">HOME</div>
				<div class="w3-col s4 w3-padding  w3-card-4 w3-button w3-red" id="jbtn">JOIN</div>
			</div>
</body>
</html>