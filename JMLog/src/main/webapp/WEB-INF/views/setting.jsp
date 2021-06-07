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
.upProfile{
	width: 130px;
	height: 130px;
	border-radius: 70%;
	overflow: hidden;
}
.upImg{
	width: 100%;
	height: 100%;
	object-fit: cover;
}
.row{
	margin: auto;
}
#nnamemsg{
	color: #B22222;
}
</style>
</head>
<body>
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>	
<script type="text/javascript">

	$(function(){
		
		/* $(document).ready(function(){
			var loginimg = '${login.profileimg}';
			console.log('이미지체크::::' + loginimg);
			if(loginimg == '')
				$('.img').attr('src', '/resources/img/default.png');
			else
				$('.img').attr('src', '${cpath }/${login.email}/getProfileImg');
		}); */
		
		// 닉네임 중복 확인 (수정필요)
		$('#nickname').blur(function() {
			const nickname = $('#nickname').val();
			var nnamemsg = $('#nnamemsg');
			var loginnickname = '${login.nickname}';
			
			if(nickname == ''){
				$('#nnamemsg').html("닉네임을 입력해주세요!")
				return;
			}else if(nickname != loginnickname){
				$.ajax({
					type: 'GET',
					url: 'nicknameChk?nickname=' + nickname,
					success: function(data) {
						data > 0 ? $('#nnamemsg').html('이미 사용중인 닉네임입니다!') : $('#nnamemsg').html('')
								$('#saveBtn').prop("disabled",false);
						if(data > 0){
							$('#nnamemsg').html('이미 사용중인 닉네임입니다!');
							$('#saveBtn').prop("disabled",false);
						}else{
							$('#nnamemsg').html('');
							$('#saveBtn').prop("disabled",true);
						}
					}
				})
			}
		});
		
		// 프로필 이미지 선택 미리보기
		$('#profileimg').on("change", function(){
			var file = $(this).prop('files')[0];
			console.log('files : ' + file);
			console.log('선택 : ' + $('#profileimg').val());
			if($('#profileimg').val() == '')
				$('#imgChk').val('no');		// 파일 선택 취소했을 때 프로필 사진 안바뀌게 no 전해줌
			console.log('imgchk : ' + $('#imgChk').val());
			blobURL = window.URL.createObjectURL(file);
			$('.img').attr('src', blobURL);
		});
		
		// 프로필 이미지 제거
		$('#delimg').click(function(){
			console.log('이미지 제거 클릭');
			$.ajax({
				type: 'GET',
				url: 'delimg?email=' + '${login.email}',
				success: function(){
					$('.img').attr('src', 'resources/img/default.png');
				}
			});
		});
	})
	
</script>
<header>
	<div class="container">
	<div class="row mt-2">
		<div class="col-md-8" style="margin-top: 10px"><h2><a href="${cpath }/">JMLog</a></h2></div>
				<div class="col-md-3 text-right" style="margin-top: 20px">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					<button type="button" class="btn btn-dark" style="margin-left: 5px; margin-right: 5px" onclick="location.href='${cpath}/write'">새글쓰기</button>
				</div>
				<div class="col-md-1 text-right" style="margin-top: 20px">
					<%-- <a href="#" class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" >Hello, ${login.nickname}! --%>
					<a href="#" class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" >
					<div class="profile" style="background: #BDBDBD; margin-right: 0px">
						<c:choose>
							<c:when test="${login.profileimg != null }">
								<!-- img태그의 src 경로는 profileImg 가져오는 컨트롤러 호출함(/email/getProfileImg) -->
								<img class="img" src="${cpath }/${login.email}/getProfileImg">
							</c:when>
							<c:otherwise>
								<img class="img" src="${cpath }/resources/img/default.png">
							</c:otherwise>
						</c:choose>
					</div>
						<span class="caret"></span></a>
						<ul class="dropdown-menu justify-content-end" role="menu" aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/${login.email}">내 로그</a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/setting">설정</a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/logout">로그아웃</a></li>
						</ul>
				</div>
		
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
	</div>	
</nav>
	<div class="container">
		<div class="row" style="text-align: center;">
			<div class="upProfile" style="background: #BDBDBD; display: block; margin: auto;">
				<c:choose>
					<c:when test="${login.profileimg != null }">
						<!-- img태그의 src 경로는 profileImg 가져오는 컨트롤러 호출함(/email/getProfileImg) -->
						<img class="img" src="${cpath }/${login.email}/getProfileImg">
					</c:when>
					<c:otherwise>
						<img class="img" src="${cpath }/resources/img/default.png">
					</c:otherwise>
				</c:choose>
			</div>
			
			<form method="POST" enctype="multipart/form-data" action="${capth }/setting">
				<input type="hidden" id="email" name="email" value="${login.email }">
				<input type="hidden" id="imgChk" name="imgChk" value="yes">
				<label class="imgBtn" for="profileimg"><a>이미지 업로드</a></label>
				<input type="file" id="profileimg" name="profileimg" style="display:none" accept="image/*"><br>	<!-- 이미지파일만 업로드 가능 -->
				<label><a id="delimg" href="#">이미지 제거</a></label><br>
				<label for="nickname">닉네임</label>
				<input type="text" id="nickname" name="nickname" value="${login.nickname }" required>
				<p id="nnamemsg"></p>
				
				<button id="saveBtn" type="submit" class="btn btn-dark">회원정보 수정</button>
			</form>
		</div>
	</div>

</body>
</html>