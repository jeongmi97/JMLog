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
}
.upImg{
	width: 100%;
	height: 100%;
	object-fit: cover;
}
.row{ margin: auto; }
</style>
</head>
<body>
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
		
		$('.alert').hide();
		
		// 닉네임 중복 확인 (수정필요)
		$('#nickname').blur(function() {
			const nickname = $('#nickname').val();
			var nnamemsg = $('#nnamemsg');
			var loginnickname = '${login.nickname}';
			
			if(nickname == ''){
				nnamemsg.text("닉네임을 입력해주세요!")
				$('#nnamemsgAlert').show();
				return;
			}else if(nickname != loginnickname){
				$.ajax({
					type: 'GET',
					url: 'nicknameChk?nickname=' + nickname,
					success: function(data) {
						console.log('넘어온 닉네임 : ' + data);
						if(data == ''){
							$('#nnamemsgAlert').hide();
							$('#saveBtn').prop("disabled",false);
						}else{
							nnamemsg.text('이미 사용중인 닉네임입니다!');
							$('#nnamemsgAlert').show();
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
					$('.img').attr('src', 'resources/img/default.jpg');
				}
			});
		});
	})
	
	// 회원 탈퇴
	function delUser(){
		var delconfirm = confirm('정말 탈퇴하시겠습니까?');
		if(delconfirm == true){		// 확인 눌렀을 때 탈퇴 기능 수행
			
		}else{						// 취소 눌렀을 때 되돌아가기
			return;
		}
	}
	
</script>
<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>
<nav>
	<%@ include file="/WEB-INF/views/include/settingNav.jsp" %>
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
					<img class="img" src="${cpath }/resources/img/default.jpg">
				</c:otherwise>
			</c:choose>
		</div>
		
		<form method="POST" enctype="multipart/form-data" action="${capth }/setting">
			<input type="hidden" id="email" name="email" value="${login.email }">
			<input type="hidden" id="imgChk" name="imgChk" value="yes">
			<label class="imgBtn" for="profileimg"><a>이미지 업로드</a></label>
			<input type="file" id="profileimg" name="profileimg" style="display:none" accept="image/*"><br>	<!-- 이미지파일만 업로드 가능 -->
			<label><a id="delimg" href="#" style="color: #6A5ACD;">이미지 제거</a></label><br>
			<label for="nickname">닉네임</label>
			<input type="text" id="nickname" name="nickname" value="${login.nickname }" required>
			<div class="alert alert-danger" id="nnamemsgAlert" role="alert">
			  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
			  <span class="sr-only">Error:</span>
			  <p id="nnamemsg"></p>
			</div>
			<br><br>
			<button type="button" class="btn btn-danger" onclick="delUser();" style="margin-right: 10px;">회원탈퇴</button>
			<button id="saveBtn" type="submit" class="btn btn-dark">회원정보 수정</button>
		</form>
	</div>
</div>
</body>
</html>