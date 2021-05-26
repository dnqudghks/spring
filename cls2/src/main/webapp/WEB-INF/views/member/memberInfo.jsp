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
	label {
		font-size: 14pt;
	}
	
	.avtimg {
		display: inline-block;
		width: 100px;
		height: auto;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#hbtn').click(function(){
			// addMember.jsp 페이지로 돌려보낸다.
			$(location).attr('href', '/cls2/main.cls');
		});
		
		$('#ebtn').click(function(){
			$(location).attr('href', '/cls2/member/myInfoEdit.cls');
		});
	});
</script>
</head>
<body>

	<div class="w3-content mxw650 w3-center">
	<c:if test="${DATA.gen eq 'M'}">
		<h1 class="w3-green w3-padding w3-card-4 w3-round-large">
			<c:if test="${SID eq DATA.id}">
				내 정보
			</c:if>
			<c:if test="${SID ne DATA.id}">
				회원 정보
			</c:if>
		</h1>
	</c:if>
	<c:if test="${DATA.gen eq 'F'}">
		<h1 class="w3-pink w3-padding w3-card-4 w3-round-large">
			<c:if test="${SID eq DATA.id}">
				내 정보
			</c:if>
			<c:if test="${SID ne DATA.id}">
				회원 정보
			</c:if>
		</h1>
	</c:if>
		<div id="frm">
			<div class="w3-col w3-margin-top w3-card-4 w3-padding w3-round-large">
				<div class="w3-col pdt10 w3-margin-top">
					<label class="w3-col m3 w3-right-align w3-text-grey">회원번호 : </label>
					<span id="mno" class="w3-col m8 mgl20 pdl20">${DATA.mno}</span>
				</div>
				<div class="w3-col pdt10 w3-margin-top">
					<label class="w3-col m3 w3-right-align w3-text-grey">회원이름 : </label>
					<span id="name" class="w3-col m8 mgl20 pdl20">${DATA.name}</span>
				</div>
				<div class="w3-col w3-margin-top">
					<label class="w3-col m3 w3-right-align w3-text-grey">아이디 : </label>
					<span id="id" class="w3-col m8 mgl20 pdl20">${DATA.id}</span>
				</div>
				<div class="w3-col pdt10 w3-margin-top">
					<label class="w3-col m3 w3-right-align w3-text-grey">메일주소 : </label>
					<span id="mail" class="w3-col m8 mgl20 pdl20">${DATA.mail}</span>
				</div>
				<div class="w3-col pdt10 w3-margin-top">
					<label class="w3-col m3 w3-right-align w3-text-grey">전화번호 : </label>
					<span id="tel" class="w3-col m8 mgl20 pdl20">${DATA.tel}</span>
				</div>
				<div class="w3-col w3-margin-top">
					<label class="w3-col m3 w3-right-align w3-text-grey">회원성별 : </label>
					<span id="gen" class="w3-col m8 mgl20 pdl20">${DATA.gen eq 'M' ? '남자' : '여자'}</span>
				</div>
				<div class="w3-col pdt10 w3-margin-top">
					<label class="w3-col m3 w3-right-align w3-text-grey">가 입 일 : </label>
					<span id="sdate" class="w3-col m8 mgl20 pdl20">${DATA.sdate}</span>
				</div>
					
				<div class="w3-col w3-margin-top w3-margin-bottom">
					<label class="w3-col m3 w3-right-align w3-text-grey">아바타 : </label>
					<div class="w3-col m8 mgl20 pdl20">
						<img src="/cls2/img/avatar/${DATA.savename}" 
								class="w3-border w3-border-grey w3-card-2 avtimg" id="avtimg${DATA.ano}">
					</div>
				</div>
			</div>
		</div>
		<div class="w3-col w3-margin-top w3-card-4 showFr">

<c:if test="${SID ne DATA.id}">
	<c:if test="${DATA.gen eq 'M'}">
			<div class="w3-col w3-padding w3-green w3-hover-lime" id="hbtn">
	</c:if>
	<c:if test="${DATA.gen eq 'F'}">
			<div class="w3-col w3-padding w3-purple w3-hover-pink" id="hbtn">
	</c:if>
				home
			</div>
</c:if>
<c:if test="${SID eq DATA.id}">
	<c:if test="${DATA.gen eq 'M'}">
			<div class="w3-half w3-padding w3-green w3-hover-lime w3-button" id="hbtn">
	</c:if>
	<c:if test="${DATA.gen eq 'F'}">
			<div class="w3-half w3-padding w3-purple w3-hover-pink w3-button" id="hbtn">
	</c:if>
				home
			</div>
			<div class="w3-half w3-blue w3-button w3-hover-aqua" id="ebtn">정보수정</div>
</c:if>

		</div>
	</div>
</body>
</html>