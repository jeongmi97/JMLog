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

<script type="text/javascript">
	
	// 이메일 & 비밀번호 정규표현식
	const patternEmail = RegExp(/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/);
	const patternPw = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/);	// 영문자 숫자 조합 8자 이상
	
	var btnChk = ['n', 'n', 'n', 'n'];
	
	$(document).ready(function(){
		
	
	$('.alert').hide();
		
	// 이메일 정규표현식 확인 & 중복체크
	$('#email').blur(function() {
		const email = $('#email').val();
		console.log(email);
		var idmsg = $('#idmsg');
		
		if(email == ''){	// 이메일 미입력 시
			idmsg.text("이메일을 입력해주세요");
			return;
		}else if(!patternEmail.test(email)){	// 이메일 정규표현식에 맞지 않을 때
			idmsg.text("이메일 형식에 맞게 입력해주세요");
			btnChk[0] = 'n';
			console.log('chkkkk : ' + btnChk[0]);
			$('#idmsgAlert').show();
			return;
		}else{		// 이메일 정규표현식에 맞을 경우 ajax를 통해 계정 중복 테스트
			$.ajax({
				// 데이터를 get 방식으로 url에 붙여 전송
				type: "GET",
				url: 'emailCheck?email='+email,
				success: function(data){
					// return값을 int값으로 받아와 select된 계정이 1개 이상이면 사용중인 계정
					if(data > 0){
						idmsg.text('이미 사용중인 계정입니다');
						$('#idmsgAlert').show();
						btnChk[0] = 'n';
					}else{
						$('#idmsgAlert').hide();
						btnChk[0] = 'y';
						console.log('chkkkk : ' + btnChk[0]);
					}
				}
			})
		}
	});
	
	// 비밀번호 정규표현식 확인
	$('#pw').blur(function(){
		const pw = $('#pw').val();
		var pwmsg = $('#pwmsg');
		
		if(pw == ''){
			pwmsg.text("비밀번호를 입력해주세요");
			return;
		}else if(!patternPw.test(pw)){
			pwmsg.text("영문 대소문자, 숫자를 조합한 8자 이상");
			$('#pwmsgAlert').show();
			btnChk[1] = 'n';
			return;
		}else{
			$('#pwmsgAlert').hide();
			btnChk[1] = 'y';
		}
	});
	
	// 비밀번호 확인
	$('#pwChk').blur(function(){
		const pw = $('#pw').val();
		const pwChk = $('#pwChk').val();
		var cpwmsg = $('#cpwmsg');
		
		if(pwChk == ''){
			cpwmsg.text("비밀번호 확인을 입력해주세요");
			return;
		}else if(pw != pwChk){
			cpwmsg.text("비밀번호가 일치하지 않습니다");
			$('#cpwmsgAlert').show();
			btnChk[2] = 'n';
			return;
		}else{
			$('#cpwmsgAlert').hide();
			btnChk[2] = 'y';
		}
	});
	
	// 닉네임 중복확인
	$('#nickname').blur(function() {
		const nickname = $('#nickname').val();
		var nnamemsg = $('#nnamemsg');
		
		if(nickname == ''){
			nnamemsg.text("닉네임을 입력해주세요")
			return;
		}else{
			$.ajax({
				type: 'GET',
				url: 'nicknameChk?nickname=' + nickname,
				success: function(data) {
					if(data > 0){
						nnamemsg.text('이미 사용중인 닉네임입니다');
						$('#nnamemsgAlert').show();
						btnChk[3] = 'n';
					}else{
						$('#nnamemsgAlert').hide();
						btnChk[3] = 'y';
					}
				}
			})
		}
	});
	
	});
	
	// 인풋값들이 제약조건에 모두 성립 시 가입하기 버튼 활성화
	function btnchk(){	
		var check = 'y';
		for(var i=0; i<4; i++){
			if(btnChk[i] == 'n')
				check = 'n';
		}
		if(check == 'y')
			$('form').submit();
		else{
			alert('입력정보를 확인해주세요!');
			return;
		}
		
	}
</script>

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
</body>
</html>