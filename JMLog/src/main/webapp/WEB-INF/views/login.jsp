<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<title>Insert title here</title>
<style>
	
</style>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<div class="container">
	<div class="row">
	<div class="col-sm-6" style="margin: auto; text-align: center">
	<form method="post" action="${cpath }/login" style="display: inline-block;">
      	<input type="email" class="form-control" name="email" id="email" placeholder="이메일">
      	<input type="password" class="form-control" name="pw" id="password" placeholder="비밀번호">
        <label><input type="checkbox" name="useCookie"> 로그인 유지</label>
        <div>
      	<button type="submit" class="btn btn-default">로그인</button>
      	</div>
		<div>
			<a>비밀번호 찾기</a>
		</div>
	</form>
	<br>
	아직 회원이 아니신가요?<a href="${cpath }/join">회원가입</a>
	</div>
	</div>
</div>
</body>
</html>