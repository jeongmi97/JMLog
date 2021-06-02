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

html, body{
	height: 100%
}

#email{
	border-top: 0;
	border-left: 0;
	border-right: 0;
	width: 340px;
	height: 50px;
	margin-bottom: 10px;
}

#password{
	border-top: 0;
	border-left: 0;
	border-right: 0;
	width: 340px;
	height: 50px;
	margin-bottom: 10px;
}

button{
	margin-bottom: 10px;
}
input{
	box-shadow: none;
}
</style>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<div class="container h-100">
	<div class="row d-flex align-items-center h-100">
	<div class="col-sm-6" style="margin: auto; text-align: center">
	<h2>JMLog</h2>
	<form method="post" action="${cpath }/login" style="display: inline-block;">
      	<div><input type="email" name="email" id="email" placeholder="이메일" required></div>
      	<div><input type="password" name="pw" id="password" placeholder="비밀번호" required></div>
        <label><input type="checkbox" name="useCookie"> 로그인 유지</label>
        <div>
      	<button type="submit" class="btn btn-dark btn-lg btn-block">로그인</button>
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