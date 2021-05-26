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
	span.h25 {
		line-height: 50%;
	}
	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('.datafr .w3-hover-lime').css('cursor', 'pointer').odd().addClass('w3-light-grey');
		$('.datafr > div').last().addClass('w3-margin-bottom');
		$('.w3-button').click(function(){
			var tid = $(this).attr('id');
			var url = '';
			switch(tid){
			case 'hbtn':
				url = '/cafe/main.cafe';
				break;
			case 'lbtn':
				url = '/cafe/member/login.cafe';
				break;
			case 'jbtn':
				url = '/cafe/member/join.cafe';
				break;
			case 'wbtn':
				url = '/cafe/board/boardWrite.cafe';
				break;
			case 'outbtn':
				url = '/cafe/member/logout.cafe';
				break;
			}
			$(location).attr('href', url);
		});
		
		$('.w3-button.pbtn').click(function(){
			var pno = $(this).html();
			
			if(pno == 'pre'){
				pno = '${PAGE.startCont - 1}';
			} else if(pno == 'next'){
				pno = '${PAGE.endCont + 1}';
			}
			
			$('#nowPage').val(pno);
			$('#frm').submit();
		});
		
		$('.list').click(function(){
			// 선택된 태그의 아이디값에서 두번째 자리에서부터 마지막까지 잘라서 꺼내보자.
			// 	예 ] 	id="l100001"	==> 100001
			var tno = $(this).attr('id').substring(1);
			// 추출한 글번호를 폼태그의 입력태그에 셋팅해주고
			$('#bno').val(tno);
			
			// 폼태그가 전송될 주소를 셋팅하고
			$('#frm').attr('action', '/cafe/board/boardDetail.cafe');
			
			// 폼태그를 전송한다.
			$('#frm').submit();
		});
	});
</script>
</head>
<body>
	<form method="POST" action="/cafe/board/board.cafe"  id="frm" name="frm">
		<input type="hidden" name="nowPage" id="nowPage" value="${PAGE.nowPage}"> <!-- 현재페이지 전송용 || 이동페이지 전송용 -->
		<input type="hidden" name="bno" id="bno"> <!-- 글번호 전송용태그 -->
	</form>
	<div class="w3-content mxw700 w3-margin-top w3-padding">
		<div class="w3-col w3-card-4 w3-margin-top w3-margin-bottom">
			<h1 class="w3-green w3-padding w3-center mg0">게시판 리스트</h1>
			<div class="w3-bar w3-lime h25">
				<span class="w3-col w100 h25 w3-lime w3-hover-green w3-button" id="hbtn">home</span>
		<c:if test="${empty SID}">
				<span class="w3-col w100 h25 w3-lime w3-hover-light-green w3-button w3-right" id="lbtn">login</span>
				<span class="w3-col w100 h25 w3-lime w3-hover-amber w3-button w3-right" id="jbtn">join</span>
		</c:if>
		<c:if test="${not empty SID}">
				<span class="w3-col w100 h25 w3-lime w3-hover-deep-orange w3-button w3-right" id="wbtn">write</span>
				<span class="w3-col w100 h25 w3-lime w3-hover-orange w3-button w3-right" id="outbtn">logout</span>
		</c:if>
			</div>
		</div>
		
		<div class="w3-col w3-margin-top w3-padding w3-card-4 datafr">
			<div class="w3-col w3-margin-top">
				<span class="w3-col w150 w3-center w3-green w3-border-right w3-border-sand">글번호</span>
				<span class="w3-col w250 w3-center w3-green w3-border-right w3-border-sand">글제목</span>
				<span class="w3-col w100 w3-center w3-green w3-border-right w3-border-sand">작성자</span>
				<div class="w3-rest w3-center w3-green w3-border-right w3-border-sand">작성일</div>
			</div>
			<!-- 데이터 -->
	<c:forEach var="data" items="${LIST}">
			<div class="w3-col w3-border-left w3-border-right w3-border-bottom w3-hover-lime list" id="l${data.bno}">
				<span class="w3-col w150 w3-center w3-border-right">${data.bno}</span>
				<span class="w3-col w250 w3-center w3-border-right">${data.title}</span>
				<span class="w3-col w100 w3-center w3-border-right">${data.id}</span>
				<div class="w3-rest w3-center">${data.sdate}</div>
			</div>
	</c:forEach>
	<c:if test="${empty LIST}">
			<div class="w3-col w3-padding">
				<h2 class="w3-text-grey w3-center">입력된 데이터가 없습니다!</h2>
			</div>
	</c:if>
		</div>
		
		<!-- 페이징 처리 -->
		<div class="w3-center w3-margin-bottom">
			<div class="w3-bar w3-border w3-round w3-margin-top">
	<c:if test="${PAGE.startPage == 1}">
				<span class="w3-bar-item w3-grey">pre</span>
	</c:if>
	<c:if test="${PAGE.startPage != 1}">
				<span class="w3-bar-item w3-button w3-hover-lime pbtn">pre</span>
	</c:if>
<c:forEach var="page" begin="${PAGE.startPage}" end="${PAGE.endPage}">
	<c:if test="${PAGE.nowPage == page}">
				<span class="w3-bar-item w3-button w3-hover-lime w3-green pbtn">${page}</span>
	</c:if>
	<c:if test="${PAGE.nowPage != page}">
				<span class="w3-bar-item w3-button w3-hover-lime pbtn">${page}</span>
	</c:if>
</c:forEach>
	<c:if test="${PAGE.endPage == PAGE.totalPage}">
				<span class="w3-bar-item w3-grey">next</span>
	</c:if>
	<c:if test="${PAGE.endPage != PAGE.totalPage}">
				<span class="w3-bar-item w3-button w3-hover-lime pbtn">next</span>
	</c:if>
			</div>
		</div>
		
	</div>
</body>
</html>