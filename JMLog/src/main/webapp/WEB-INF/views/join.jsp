<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
<style type="text/css">
html, body{
	height: 100%
}	
h2{
	margin-bottom: 30px;
}
input{
	border-top: 0;
	border-left: 0;
	border-right: 0;
	width: 340px;
	height: 50px;
	margin-bottom: 10px;
}
p{
	margin: 0;
}
</style>
</head>
<body>
<div class="container h-100">
	<div class="row d-flex align-items-center h-100">
		<div class="col-sm-8" style="margin: auto; text-align: center">
			<h2>JMLog 회원가입</h2>
				<form method="post" style="display: inline-block;">
					<div style="text-align: left;"><small><strong>이메일</strong></small></div>
					<div><input type="text" id="email" name="email" placeholder="example@naver.com" required><br></div>
					<div class="alert alert-danger" id="idmsgAlert" role="alert">
					  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
					  <span class="sr-only">Error:</span>
					  <p id="idmsg"></p>
					</div>
					<div style="text-align: left;"><small><strong>비밀번호</strong></small></div>
					<input type="password" id="pw" name="pw" placeholder="비밀번호(영문자조합 8자이상)" required><br>
					<div class="alert alert-danger" id="pwmsgAlert" role="alert">
					  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
					  <span class="sr-only">Error:</span>
					  <p id="pwmsg"></p>
					</div>
					<input type="password" id="pwChk" name="pwChk" placeholder="비밀번호 재입력" required><br>
					<div class="alert alert-danger" id="cpwmsgAlert" role="alert">
					  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
					  <span class="sr-only">Error:</span>
					  <p id="cpwmsg"></p>
					</div>
					<div style="text-align: left;"><small><strong>닉네임</strong></small></div>
					<input type="text" id="nickname" name="nickname" placeholder="홍길동" required><br>
					<div class="alert alert-danger" id="nnamemsgAlert" role="alert">
					  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
					  <span class="sr-only">Error:</span>
					  <p id="nnamemsg"></p>
					</div>
					<button type="button" onclick="btnchk();" class="btn btn-dark btn-lg btn-block">가입하기</button>
				</form>
		</div>
	</div>
</div>
<script src="${cpath}/resources/js/join.js"></script>
</body>
</html>