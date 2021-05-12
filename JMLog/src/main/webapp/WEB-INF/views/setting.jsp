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
<style>
.profile {
	width: 150px;
	height: 150px;
	border-radius: 70%;	/* 테두리 원으로 */
	overflow: hidden;	/* 넘치는 부분 안보이게 */
}
.image {
	width: 200;
	height: 200;
	/* object-fit: cover;	 비율 그대로 유지 */
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<body>
<script type="text/javascript">

	$(function(){
		
		// 닉네임 중복 확인 (수정필요)
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

<div class="profile" style="background: #BDBDBD;">
	<!-- img태그의 src 경로는 profileImg 가져오는 컨트롤러 호출함(/email/getProfileImg) -->
	<img class="img" src="${cpath }/${login.email}/getProfileImg">
</div>

<form method="POST" enctype="multipart/form-data" action="${capth }/setting">
	<input type="hidden" id="email" name="email" value="${login.email }">
	<label for="profileimg">파일 업로드</label>
	<input type="file" id="profileimg" name="profileimg"><br>
	<label for="nickname">닉네임</label>
	<input type="text" id="nickname" name="nickname" value="${login.nickname }" required>
	<p id="nnamemsg"></p>
	
	<input type="submit" value="회원정보 수정">
</form>
</body>
</html>