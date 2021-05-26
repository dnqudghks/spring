<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Redirect View</title>
<script type="text/javascript" src="/cls2/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#frm').submit();
	});
</script>
</head>
<body>
	<form method="POST" action="${PATH}" name="frm" id="frm">
		<input type="hidden" name="nowPage" id="nowPage" value="${nowPage}" >
		<input type="hidden" name="msg" value="${MSG}" >
	</form>
</body>
</html>