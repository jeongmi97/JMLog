<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<style type="text/css">

a{ text-decoration: none; color: #000000; }

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

#lock_post{
	margin-right: 8px;
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
<body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>	
<script type="text/javascript">
	
	$(document).ready(function() {
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

<div class="container">
	<form:form method="post" modelAttribute="post" action="${cpath }/write">
		<form:hidden path="idx"/>
		<form:hidden path="email" value="${login.email }"/>
		<input type="hidden" name="mode">
		
		<form:select path="cate" id="category">
			<option value="nocate">카테고리</option>
			<form:options items="${category }" itemLabel="catename" itemValue="catename"/>
		</form:select>
		<form:input path="title" type="text" name="title" id="title" placeholder="제목을 입력하세요" />
		<form:textarea path="content" name="content" id="content" rows="40" /><br>
		<form:checkbox path="lock_post" value="y" name="lock_post" id="lock_post"/><label for="lock_post">비공개</label>
		<input type="submit" value="작성하기">
	</form:form>
</div>
<script src="/resources/js/ckeditor.js"></script>

</body>
</html>