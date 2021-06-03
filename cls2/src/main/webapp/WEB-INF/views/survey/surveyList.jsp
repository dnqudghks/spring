<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문조사 리스트 페이지</title>
<link rel="stylesheet" type="text/css" href="/cls2/css/w3.css">
<link rel="stylesheet" type="text/css" href="/cls2/css/user.css">
<script type="text/javascript" src="/cls2/js/jquery-3.6.0.min.js"></script>
<style type="text/css">
	.slist {
		cursor: pointer;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('.slist').click(function(){
			var title = $(this).children().eq(0).html();
			var tno = $(this).attr('id');
			
			$('#sino').val(tno);
			$('#title').val(title);
			
			// 폼태그 전송하고
			$('#frm').submit();
		});
	});
</script>
</head>
<body>
	<form method="POST" action="/cls2/survey/survey.cls" id="frm" name="frm">
		<input type="hidden" name="id" value="${SID}">
		<input type="hidden" name="sino" id="sino">
		<input type="hidden" name="title" id="title">
	</form>
	<div class="w3-content mxw750 w3-margin-top">
		<h1 class="w3-margin-top w3-padding w3-orange w3-card-4 w3-center">진행중인 설문조사</h1>
		<div class="w3-col w3-margin-top w3-padding">
<c:forEach var="data" items="${LIST}" varStatus="st">
			<h4 class="w3-col pdAll10 w3-text-grey w3-round-large w3-card-2 w3-center w3-border w3-border-amber slist" id="${data.sino}">
				${st.count}. <span class="title">${data.title}</span> - 
				<span class="ft12"><small><b>종료일 : ${data.edate}</b></small></span>
			</h4>
</c:forEach>
		</div>
	</div>
</body>
</html>