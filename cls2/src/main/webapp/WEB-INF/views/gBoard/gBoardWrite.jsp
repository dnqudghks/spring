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
<style type="text/css"></style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#hbtn').click(function(){
			$(location).attr('href', '/cls2/main.cls');
		});
		
		$('#wbtn').click(function(){
			// 할일
			// 입력된 데이터 읽고...
			var mno = $(document.frm.mno).val();
			var body = $('#body').val();
			if(!(mno && body)){
				// 이 경우는 반드시 입력되어야 할 태그가 비어있는 경우가 있으므로
				// 입력하도록 한다.
				alert('# 본문을 입력하세요!');
				return; // 함수실행 즉시 종료...
			}
			$('#frm').submit();
		});
	});
</script>
</head>
<body>
	<div class="w3-content mxw650 w3-margin-top">
		<h1 class="w3-green w3-center w3-padding w3-margin-bottom">방명록 작성</h1>
<c:if test="${not empty DATA.avatar}">
		<form method="POST" action="/cls2/gBoard/gBoardWriteProc.cls" name="frm" id="frm"
				class="w3-col w3-round-large w3-card-4 w3-margin-bottom w3-padding">
			<input type="hidden" name="mno" value="${DATA.mno}">
			<div class="w3-col box120 pdAll10 w3-border-right">
				<img src="/cls2/img/avatar/${DATA.avatar}" class="inblock avtBox100 w3-border w3-border-grey">
			</div>
			<div class="w3-rest w3-padding">
				<div class="w3-col w3-border-bottom">
					<span class="w3-text-left mgb10 ft10"><b>${SID}</b></span>
				</div>
				<div class="w3-col w3-margin-top">
					<textarea class="w3-input w3-border noresize" id="body" name="body" 
								placeholder="남기고싶은 글을 작성하세요!"></textarea>
				</div>
			</div>
		</form>
		
		<div class="w3-row w3-margin-top">
			<div class="w3-col m2 w3-button w3-green w3-card-4" id="hbtn">Home</div>
			<div class="w3-col m2 w3-button w3-blue w3-card-4 w3-right" id="wbtn">write</div>
		</div>
</c:if>
	</div>
</body>
</html>