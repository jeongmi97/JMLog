<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 수정</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/navStyle.css">
<style>
.upProfile{
	width: 130px;
	height: 130px;
	border-radius: 70%;
	overflow: hidden;
	background: #BDBDBD; 
	display: block; 
	margin: auto;
}
.upImg{
	width: 100%;
	height: 100%;
	object-fit: cover;
}
.row{ margin: auto; }
#nickname{
	width: 200px;
}
.imgbtn{
	width: 150px;
}
</style>
</head>
<body>
<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>
<nav>
	<%@ include file="/WEB-INF/views/include/settingNav.jsp" %>
</nav>

<div class="container">
	<div class="row text-center">
		<form method="POST" enctype="multipart/form-data" action="${capth }/setting">
		<div class="row">
			<div class="col-md-3 col-md-offset-3" style="border-right: 1px solid #A9A9A9;">
				<div class="upProfile">
					<c:choose>
						<c:when test="${login.imgtype != null }">
							<!-- img태그의 src 경로는 profileImg 가져오는 컨트롤러 호출함(/email/getProfileImg) -->
							<img class="img" src="${cpath }/${login.email}/getProfileImg">
						</c:when>
						<c:otherwise>
							<img class="img" src="${cpath }/resources/img/default.jpg">
						</c:otherwise>
					</c:choose>
				</div>
				<label class="imgBtn" for="profileimg"><a class="imgbtn btn btn-warning" role="button" style="margin-top: 20px;">이미지 업로드</a></label>
				<input type="file" id="profileimg" name="profileimg" style="display:none" accept="image/*"><br>	<!-- 이미지파일만 업로드 가능 -->
				<label><a class="imgbtn btn btn-default" id="delimg" href="#" role="button" >이미지 제거</a></label><br>
			</div>
			<div class="col-md-3 align-middle" style="margin-top: 60px;">
				<label for="nickname">닉네임</label>
				<input type="text" class="form-control center-block" id="nickname" name="nickname" value="${login.nickname }" required>
				<div class="alert alert-danger" id="nnamemsgAlert" role="alert">
				  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
				  <span class="sr-only">Error:</span>
				  <p id="nnamemsg"></p>
				</div>
				<br><br>
				<input type="hidden" id="email" name="email" value="${login.email }">
				<input type="hidden" id="imgChk" name="imgChk" value="yes">
			</div>
		</div>
			<div class="row" style="margin-top: 30px;">
				<button type="button" class="btn btn-danger" onclick="delUser();" style="margin-right: 10px;">회원탈퇴</button>
				<button id="saveBtn" type="submit" class="btn btn-dark">회원정보 수정</button>
			</div>
		</form>
	</div>
</div>
<script src="${cpath }/resources/js/setting.js"></script>
</body>
</html>