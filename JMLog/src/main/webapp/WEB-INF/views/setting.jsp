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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<style>
a { text-decoration: none; color: #000000; }

.profile {
	width: 40px;
	height: 40px;
	border-radius: 70%;	/* 테두리 원으로 */
	overflow: hidden;	/* 넘치는 부분 안보이게 */
}
.img {
	width: 100%;
	height: 100%;
	object-fit: cover;	 /* 비율 그대로 유지 */
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>	
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
<header>
	<div class="container">
	<div class="row mt-2">
		<div class="col-md-8" style="margin-top: 10px"><h2><a href="${cpath }/">JMLog</a></h2></div>
		<c:choose>
			<c:when test="${not empty login }">		<!-- 로그인 되어있을 때 -->
				<div class="col-md-3 text-right" style="margin-top: 20px">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					<button type="button" class="btn btn-dark" style="margin-left: 5px; margin-right: 5px" onclick="location.href='${cpath}/write'">새글쓰기</button>
						
				</div>
				<div class="col-md-1 text-right" style="margin-top: 20px">
					<%-- <a href="#" class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" >Hello, ${login.nickname}! --%>
					<a href="#" class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" >
					<div class="profile" style="background: #BDBDBD; margin-right: 0px">
						<img class="img" src="${cpath }/${login.email}/getProfileImg">
					</div>
						<span class="caret"></span></a>
						<ul class="dropdown-menu justify-content-end" role="menu" aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/${login.email}">내 로그</a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/setting">설정</a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/logout">로그아웃</a></li>
						</ul>
				</div>
			</c:when>
			<c:otherwise>	
				<div class="col-md-4 text-right" style="margin-top: 20px"><button type="button" class="btn btn-dark" onclick="location.href='${cpath}/login'">로그인</button></div>	<!-- 로그인 안 되어있을 때 -->
			</c:otherwise>
		</c:choose>
		
	</div>
	</div>
</header>
<nav>
	<div class="container">
		<div class="row">
			<ol class="breadcrumb" style="margin-top: 20px; text-align: center">
				<li><a href="${cpath }/setting">프로필</a></li>
				<li><a href="${cpath }/setting/category">카테고리</a></li>
			</ol>
		</div>	
		<div class="profile" style="background: #BDBDBD;">
			<!-- img태그의 src 경로는 profileImg 가져오는 컨트롤러 호출함(/email/getProfileImg) -->
			<img class="img" src="${cpath }/${login.email}/getProfileImg">
		</div>
		
		<form method="POST" enctype="multipart/form-data" action="${capth }/setting">
			<input type="hidden" id="email" name="email" value="${login.email }">
			<!-- 이미지 아닌 파일 예외처리하기 -->
			<label class="imgBtn" for="profileimg">이미지 업로드</label>
			<input type="file" id="profileimg" name="profileimg" style={{display:none}}><br>
			<label for="nickname">닉네임</label>
			<input type="text" id="nickname" name="nickname" value="${login.nickname }" required>
			<p id="nnamemsg"></p>
			
			<input type="submit" value="회원정보 수정">
		</form>
	</div>
</nav>
</body>
</html>