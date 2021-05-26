<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/cls2/css/w3.css">
<link rel="stylesheet" type="text/css" href="/cls2/css/w3-colors-flat.css">
<link rel="stylesheet" type="text/css" href="/cls2/css/user.css">
<script type="text/javascript" src="/cls2/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/cls2/js/w3color.js"></script>
<style type="text/css">
	.mbtn {
		cursor: pointer;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#hbtn').click(function(){
			$(location).attr('href', '/cls2/main.cls');
		});
		
		$('.mbtn').click(function(){
			/*
			// 선택된 태그와의 관계로 선택서 데이터 읽어오는 방법
			var sno = $(this).children().eq(0).html();
			*/
			
			// 선택된 태그의 속성을 읽어서 처리하는 방법
			var sno = $(this).attr('id');
			$('#mno').val(sno);
			$('#frm').submit();
		});
	});
</script>
</head>
<body>
	<form method="POST" action="/cls2/member/memberInfo.cls" id="frm" name="frm">
		<input type="hidden" name="mno" id="mno" >
	</form>
	
	<div class="w3-content mxw700 w3-center w3-margin-top">
		<h1 class="w3-green w3-margin-top w3-margin-bottom w3-round-large w3-card-4">회원 리스트</h1>
		<div class="w3-col w3-card-4 w3-round-large w3-padding w3-margin-bottom">
			<div class="w3-col w3-margin-top w3-flat-turquoise w3-border w3-border-teal">
				<div class="w3-col m2 w3-border-right w3-border-teal">회원번호</div>
				<div class="w3-col m3 w3-border-right w3-border-teal">회원이름</div>
				<div class="w3-col m2 w3-border-right w3-border-teal">성별</div>
				<div class="w3-col m5">가 입 일</div>
			</div>
			
			<%-- 회원리스트 --%>
<c:forEach var="data" items="${LIST}" varStatus="st">
	<c:if test="${LIST.size() eq st.count}">
			<div class="w3-col w3-border-left w3-border-right w3-border-bottom w3-margin-bottom w3-border-teal w3-hover-blue mbtn" id="${data.mno}">
	</c:if>
	<c:if test="${LIST.size() ne st.count}">
			<div class="w3-col w3-border-left w3-border-right w3-border-bottom w3-border-teal w3-hover-blue mbtn" id="${data.mno}">
	</c:if>
				<div class="w3-col m2 w3-border-right w3-border-teal">${data.mno}</div>
				<div class="w3-col m3 w3-border-right w3-border-teal">${data.name}</div>
				<div class="w3-col m2 w3-border-right w3-border-teal">${(data.gen eq 'M') ? '남자' : '여자'}</div>
				<div class="w3-col m5">${data.sdate}</div>
			</div>
</c:forEach>
		</div>
		
		<div class="w3-col w3-margin-top w3-card-4 w3-button w3-blue w3-hover-aqua w3-round-large" id="hbtn">Home</div>
	</div>
</body>
</html>