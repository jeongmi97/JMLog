<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">

	const patternPw = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/);
	
	$(function(){
		
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
		
		// 닉네임 중복 확인
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
	})
	
</script>
설정============

<div>
	<a href="${cpath }/setting">프로필</a>
	<a href="${cpath }/setting/category">카테고리</a>
</div>

<form method="POST">
	<input type="hidden" id="email" value="${login.email }">
	<label for="nickname">닉네임</label>
	<input type="text" id="nickname" value="${login.nickname }">
	<p id="nnamemsg"></p>
	<label for="oldPw">현재 비밀번호</label>
	<input type="password" id="oldPw"><br>
	<label for="oldPw">새 비밀번호</label>
	<input type="password" id="pw">
	<p id="pwmsg"></p> 
	<label for="oldPw">새 비밀번호 확인</label>
	<input type="password" id="pwChk">
	<p id="cpwmsg"></p>
	
	<input type="submit" value="회원정보 수정">
</form>
</body>
</html>