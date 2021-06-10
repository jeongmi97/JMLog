<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="${cpath }/resources/css/navStyle.css">
<style type="text/css">
#title{
	border-top: 0;
	border-left: 0;
	border-right: 0;
	width: 1140px;
	height: 45px;
	margin-top: 20px;
	margin-bottom: 20px;
	font-size: 20pt;
}
#category{
	width: 170px;
	height: 30px;
}
#lock_post{ margin-right: 8px; }
</style>
</head>

<body>
<script type="text/javascript">
	
	$(document).ready(function() {
		
		console.log('모드: ' + $('#mode').val());
		
		$('.summernote').summernote({
			height: 300,	// 에디터 높이
			lang: "ko-KR",	// 에디터 한글 설정
			focus : true,	// 에디터에 커서 이동
			toolbar: [
				// 글꼴 설정
			    ['fontname', ['fontname']],
			    // 글자 크기 설정
			    ['fontsize', ['fontsize']],
			    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    // 글자색
			    ['color', ['forecolor','color']],
			    // 글머리 기호, 번호매기기, 문단정렬
			    ['para', ['ul', 'ol', 'paragraph']],
			    // 줄간격
			    ['height', ['height']],
			    // 그림첨부, 링크만들기
			    ['insert',['picture','link']],
			    // 코드보기, 확대해서보기, 도움말
			    ['view', ['codeview', 'help']]
			  ],
			  // 추가한 글꼴
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
			 // 추가한 폰트사이즈
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']    
		});
		
		// 게시글 수정 시 입력 폼 셋팅
		var mode = '<c:out value="${mode}"/>';	// 게시글 모드 가져옴
		
		if(mode == 'edit'){	// 수정 모드일때
			$("input:hidden[name='idx']").val('<c:out value="${post.idx}"/>');
			$("input:hidden[name='mode']").val('<c:out value="${mode}"/>');
			$('#title').val('<c:out value="${post.title}"/>');
			$('#content').val('<c:out value="${post.content}"/>');

		}
		
	});
	
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

<div class="container">
	<form:form method="post" modelAttribute="post" action="${cpath }/write">
		<form:hidden path="idx"/>
		<form:hidden path="email" value="${login.email }"/>
		<input type="hidden" name="mode" value="${mode }">
		
		<form:select path="cate" id="category">
			<option value="nocate">카테고리</option>
			<form:options items="${category }" itemLabel="catename" itemValue="catename"/>
		</form:select>
		<form:input path="title" type="text" name="title" id="title" placeholder="제목을 입력하세요" required="required"/>
		<form:textarea path="content" class="summernote" name="content" id="content" rows="40" required="required" /><br>
		<form:checkbox path="lock_post" value="y" name="lock_post" id="lock_post"/><label for="lock_post">비공개</label>
		<input type="submit" value="작성하기">
	</form:form>
</div>

</body>
</html>