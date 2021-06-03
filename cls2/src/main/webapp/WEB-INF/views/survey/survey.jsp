<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Survey</title>
<link rel="stylesheet" type="text/css" href="/cls2/css/w3.css">
<link rel="stylesheet" type="text/css" href="/cls2/css/user.css">
<script type="text/javascript" src="/cls2/js/jquery-3.6.0.min.js"></script>
<style type="text/css">
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#hbtn").click(function(){
			$(location).attr('href', '/cls2/main.cls');
		});
		$("#lbtn").click(function(){
			$(location).attr('href', '/cls2/survey/survey.cls');
		});
		$('#rbtn').click(function(){
			document.frm.reset();
		});
		$('#sbtn').click(function(){
			// 만들어진 문제의 갯수를 꺼낸다.
			var arr = ${List}
			
			//선택한 라디오버튼의 갯수 꺼내고
			var el = $('[type="radio"]:checked');
			if(len != el.length){
				// 선택하지 않은 문항이 있는 경우
				alert('*** 선택하지 않은 문항이 있습니다.');
				return;
			}
			//제출 버튼을 클릭하는 순간 선택된 태그들만 name 속성값을 qnolist로 변경한다
			// name 속성값을 qnolist로 변경한다
			$('[type="radid"]:checked').attr('type', 'checked').attr('name','qnolist');
			$('#frm').submit();
		});
		
	});
</script>
</head>
<body>
	<form method="POST" action="/cls2/survey/surveyProc.cls" id="frm" name="frm">
	
	<div class="w3-content mxw750 w3-margin-top">
		<h1 class="w3-blue w3-padding w3-center w3-margin-top">${TITLE}</h1>
		<div class="w3-col w3-margin-top w3-padding">
<c:forEach var="data" items="${LIST}" varStatus="st">
			<div class="w3-margin-top w3-padding">
				<h3 class="" id="${data.qno}">${st.count}. ${data.body}</h3>
				<div class="pdl50">
		<c:forEach var="sub" items="${data.list}">
					<h5 class="">
						${sub.exno}) 
						<span>
							<input type="radio" name="${data.qno}" value="${sub.qno}">
						</span> 
						${sub.ex}
					</h5>
		</c:forEach>
				</div>
			</div>
</c:forEach>
			
		</div>
		
		<!-- 버튼 만들기 -->
		<div class="w3-col w3-margin-top w3-margin-bottom w3-card-4">
			<div class="w3-quarter w3-button w3-green" id="hbtn">home</div>
			<div class="w3-quarter w3-button w3-blue" id="lbtn">설문조사</div>
			<div class="w3-quarter w3-button w3-purple" id="rbtn">reset</div>
			<div class="w3-quarter w3-button w3-orange" id="sbtn">제출</div>
		</div>
	</div>
	</form>
</body>
</html>