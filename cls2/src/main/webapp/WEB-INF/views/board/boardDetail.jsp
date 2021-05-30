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
	label.ft14 {
		line-height: 200%;
	}
	
</style>
<script type="text/javascript">
	
	$(document).ready(function(){
		$('#hbtn').click(function(){
			location.href = '/cls2/main.cls';
		});
		
		$('#lbtn').click(function(){
			$('#frm').submit();
		});
		
		$('#ebtn').click(function(){
			if(confirm('수정작업을 진행할까요?')){
				$('#frm').attr('action', '/cls2/board/boardEdit.cls');
				$('#frm').submit();
			}
		});
		
	});
</script>
</head>
<body>
	
	<form method="POST" action="/cls2/board/board.cls" id="frm" name="frm">
		<input type="hidden" name="nowPage" id="nowPage" value="${nowPage}">
		<input type="hidden" name="bno" id="bno" value="${DATA.bno}">
	</form>
	
	<div class="w3-content mxw700 w3-margin-top w3-padding">
		<h1 class="w3-purple w3-padding w3-center w3-card-4 w3-margin-top w3-margin-bottom">${DATA.id} 님 글 상세보기</h1>

		<div class="w3-col w3-padding w3-margin-bottom w3-card-4">
			<div class="w3-col w3-margin-top pdb10 w3-border-bottom w3-border-light-grey">
				<label class="w3-col w150 w3-center w3-text-grey ft14">작성자</label>
				<div class="w3-rest pdr30">
					<label class="w3-rest w3-input w3-round w3-border w3-text-blue ft14">${DATA.id}</label>
				</div>
			</div>
			<div class="w3-col w3-margin-top pdb10 w3-border-bottom w3-border-light-grey">
				<label class="w3-col w150 w3-center w3-text-grey ft14">작성일</label>
				<div class="w3-rest pdr30">
					<label class="w3-rest w3-input w3-round w3-border w3-text-blue ft14">${DATA.sdate}</label>
				</div>
			</div>
			<div class="w3-col w3-margin-top pdb10 w3-border-bottom w3-border-light-grey">
				<label class="w3-col w150 w3-center w3-text-grey ft14">글제목</label>
				<div class="w3-rest pdr30">
					<label class="w3-rest w3-input w3-round w3-border w3-text-blue ft14">${DATA.title}</label>
				</div>
			</div>
			<div class="w3-col w3-margin-top pdb10 w3-border-bottom w3-border-light-grey">
				<label class="w3-col w150 w3-center w3-text-grey ft14">첨부파일</label>
				<div class="w3-rest pdr30">
					<div class="w3-col w3-margin-top w3-center pdAll10">
			<c:if test="${empty LIST}">
				첨부파일 없음
			</c:if>
			<c:forEach var="data" items="${LIST}">
						<div class="inblock box120 pdAll10 mgl10 w3-border w3-broder-grey w3-card">
							<div class="w3-col imgBox100">
								<img class="w3-col img100" src="/cls2/img/upload/${data.savename}">
							</div>
						</div>
			</c:forEach>
					</div>
				</div>
			</div>
			<div class="w3-col w3-margin-top w3-margin-bottom pdb10 w3-border-bottom w3-border-light-grey">
				<label class="w3-col w150 w3-center w3-text-grey ft14">글내용</label>
				<div class="w3-rest pdr30">
					<div class="w3-col w3-contatiner w3-input w3-round w3-border">${DATA.ebody}</div>
				</div>
			</div>
		</div>
		
		<!-- 버튼 태그 -->
		<div class="w3-col w3-margin-top w3-card-4">
<c:if test="${SID eq DATA.id}">
			<div class="w3-third w3-green w3-hover-lime w3-button" id="hbtn">home</div>
			<div class="w3-third w3-blue w3-hover-pink w3-button" id="lbtn">List</div>
			<div class="w3-third w3-orange w3-hover-red w3-button" id="ebtn">edit</div>
</c:if>
<c:if test="${SID ne DATA.id}">
			<div class="w3-half w3-green w3-hover-lime w3-button" id="hbtn">home</div>
			<div class="w3-half w3-blue w3-hover-pink w3-button" id="lbtn">List</div>
</c:if>
		</div>
	</div>
</body>
</html>