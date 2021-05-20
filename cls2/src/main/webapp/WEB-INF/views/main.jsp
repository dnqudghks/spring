<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cls Main</title>
<link rel="stylesheet" type="text/css" href="/cls2/css/w3.css">
<link rel="stylesheet" type="text/css" href="/cls2/css/user.css">
<script type="text/javascript" src="/cls2/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/cls2/js/w3color.js"></script>
<style type="text/css"></style>
<script type="text/javascript">
	$(document).ready(function(){
		// 태그라이브러리 테스트 버튼 이벤트 처리
		$('#libbtn1').click(function(){
			// 할일
			// 1. 넘겨야할 데이터 form 태그에 추가해주고
			$('#frm').append('<input type="hidden" name="code" value="taglib">');
			// 2. 보내질 주소 셋팅하고
			$('#frm').attr('action', '/cls2/j05/addMember.cls');
			// 3. 폼태그 전송하고
			$('#frm').submit();
		});
		// jQuery 처리 테스트 버튼 이벤트 처리
		$('#libbtn2').click(function(){
			// 할일
			// 1. 넘겨야할 데이터 form 태그에 추가해주고
			$('#frm').append('<input type="hidden" name="code" value="jquery">');
			// 2. 보내질 주소 셋팅하고
			$('#frm').attr('action', '/cls2/j05/addMember.cls');
			// 3. 폼태그 전송하고
			$('#frm').submit();
		});
		
		// login 버튼 클릭 이벤트 처리
		$('#login').click(function(){
			// 폼을 전송하는 방법
			$('#frm').attr('action', '/cls2/member/login.cls');
			$('#frm').submit();
		});
		
		/* 로그아웃버튼 이벤트 처리 */
		$('#logout').click(function(){
			$(location).attr('href', '/cls2/member/logout.cls');
		});
		
		/* 회원가입버튼 이벤트처리 */
		$('#join').click(function(){
			$(location).attr('href', '/cls2/member/join.cls');
		});
		
		$('#myInfo').click(function(){
			$(document.frm).attr('action', '/cls2/member/myInfo.cls');
			$(document.frm).submit();
		});
		
		$('.cafeMBtn').click(function(){
			// 어떤 버튼이 클릭되었는지 확인하고
			var tid = $(this).attr('id');
			var url = '';
			switch(tid){
			case 'clsLogin':
				url = '/cls2/member/login.cls';
				break;
			case 'clsJoin':
				url = '/cls2/member/join.cls';
				break;
			case 'clsLogout':
				url = '/cls2/member/logout.cls';
				break;
			case 'clsMyInfo':
				url = '/cls2/member/myInfo.cls';
				break;
			case 'membList':
				url = '/cls2/member/memberList.cls';
				break;
			case 'gboard':
				url = '/cls2/gboard/gBoardList.cls';
				break;
			case 'reboard':
				url = '/cls2/reBoard/reBoardList.cls';
				break;
			case 'board':
				url = '/cls2/board/board.cls';
				break;
			}
			
			$(location).attr('href', url);
		});
	});
</script>
</head>
<body>
	<!-- 데이터 전송용 form tag -->
	<form method="POST" id="frm" name="frm">
	</form>
	
	<div class="w3-content mxw700 w3-center w3-margin-top">
		<h1 class="w3-margin-top w3-blue w3-card-4 w3-padding">CLS Project</h1>
		<div class="w3-margin-top">
			
			<!-- 수업 예제 링크 버튼 추가 장소 -->
			<div class="w3-col w3-padding w3-border-bottom">
				<h4 class="w3-col s4 w3-text-grey">Member Request</h4>
				<div class="w3-col s8">
		<c:if test="${empty SID }">
					<div class="w3-col w3-deep-purple w3-margin-bottom w3-button cafeMBtn" id="cafeLogin">
						<h4>Cafe Login</h4>
					</div>
					<div class="w3-col w3-blue w3-margin-bottom w3-button cafeMBtn" id="cafeJoin">
						<h4>Cafe Join</h4>
					</div>
		</c:if>
		<c:if test="${not empty SID }">
					<div class="w3-col w3-purple w3-margin-bottom w3-button cafeMBtn" id="cafeMyInfo">
						<h4>Cafe 내 정보보기</h4>
					</div>
					<div class="w3-col w3-deep-purple w3-margin-bottom w3-button cafeMBtn" id="cafeLogout">
						<h4>Cafe 로그아웃</h4>
					</div>
					<div class="w3-col w3-blue w3-margin-bottom w3-button cafeMBtn" id="membList">
						<h4>회원 목록 보기</h4>
					</div>
		</c:if>
				</div>
			</div>
			
			<!-- 방명록 링크 버튼 추가 장소 -->
			<div class="w3-col w3-padding w3-border-bottom">
				<h4 class="w3-col s4 w3-text-grey">방명록</h4>
				<div class="w3-col s8">
					<div class="w3-col w3-blue w3-margin-bottom w3-button cafeMBtn" id="gboard">
						<h4>방명록리스트</h4>
					</div>
				</div>
			</div>
			
			<!-- 댓글게시판 링크 버튼 추가 장소 -->
			<div class="w3-col w3-padding w3-border-bottom">
				<h4 class="w3-col s4 w3-text-grey">댓글게시판</h4>
				<div class="w3-col s8">
					<div class="w3-col w3-cyan w3-margin-bottom w3-button cafeMBtn" id="reboard">
						<h4>댓글게시판 리스트</h4>
					</div>
				</div>
			</div>
			
			<!-- 파일게시판 링크 버튼 추가 장소 -->
			<div class="w3-col w3-padding w3-border-bottom">
				<h4 class="w3-col s4 w3-text-grey">파일게시판</h4>
				<div class="w3-col s8">
					<div class="w3-col w3-green w3-margin-bottom w3-button cafeMBtn" id="board">
						<h4>파일게시판 리스트</h4>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>