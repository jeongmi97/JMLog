<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<body>

<script type="text/javascript">
	
	// 이메일 & 비밀번호 정규표현식
	const patternEmail = RegExp(/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/);
	const patternPw = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/);
	
	
	
	
	$(document).ready(function(){
	
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
			return;
		}else{		// 이메일 정규표현식에 맞을 경우 ajax를 통해 계정 중복 테스트
			$.ajax({
				// 데이터를 get 방식으로 url에 붙여 전송
				type: "GET",
				url: 'emailCheck?email='+email,
				success: function(data){
					// return값을 int값으로 받아와 select된 계정이 1개 이상이면 사용중인 계정
					data > 0 ? idmsg.text('이미 사용중인 계정입니다') : idmsg.hide()
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
			return;
		}else{
			pwmsg.hide();
		}
	});
	
	// 비밀번호 확인
	$('#pwChk').blur(function(){
		const pw = $('#pw').val();
		const pwChk = $('#pwChk').val();
		var cpwmsg = $('#cpwmsg');
		
		if(pwChk == ''){
			cpwmsg.text("비밀번호 확인을 입력해주세요")
			return;
		}else if(pw != pwChk){
			cpwmsg.text("비밀번호가 일치하지 않습니다")
			return;
		}else{
			cpwmsg.hide();
		}
	});
	
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
					data > 0 ? nnamemsg.text('이미 사용중인 닉네임입니다') : nnamemsg.hide()
				}
			})
		}
	});
	
	});
</script>

<form method="post">
	<label for="email">이메일</label><br>
	<input type="text" id="email" name="email" placeholder="example@naver.com" required><br>
	<p id="idmsg"></p>
	
	<label for="pw">비밀번호</label><br>
	<input type="password" id="pw" name="pw" placeholder="********" required><br>
	<p id="pwmsg"></p> 
	
	<label for="pwChk">비밀번호 확인</label><br>
	<input type="password" id="pwChk" name="pwChk" placeholder="********" required><br>
	<p id="cpwmsg"></p>
	
	<label for="nickname">닉네임</label><br>
	<input type="text" id="nickname" name="nickname" placeholder="홍길동" required><br>
	<p id="nnamemsg"></p>
	
	<input type="submit" value="가입하기">
</form>

</body>
</html>