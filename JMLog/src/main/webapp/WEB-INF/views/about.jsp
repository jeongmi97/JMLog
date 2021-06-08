<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소개</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">

a { text-decoration: none !important; color: #000000; }

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
.content{
	text-align: center;
}	
</style>
</head>
<body>

<header>
	<div class="container">
	<div class="row mt-2">
		<div class="col-md-8 "><h2><a href="${cpath }">JMLog</a></h2></div>
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
			  <li><a href="${cpath }/${user.email}">글</a></li>
			  <li><a href="${cpath }/${user.email}/guestbook">방명록</a></li>
			  <li><a href="${cpath }/${user.email}/about">소개</a></li>
			</ol>
		</div>
	</div>
</nav>
<div class="container content">
	<c:choose>
		<c:when test="${empty content }">
			<div>
				<p>&nbsp;</p>
				<p>소개글이 아직 없습니다ㅠㅠ</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
			</div>
			<c:if test="${email eq login.email }">
				<div>
					<button class="saveBtn btn btn-default" data-toggle="modal" data-target="#writeAbout">소개 글 작성하기</button>
				</div>
			</c:if>
			
			<!-- 소개글 작성 모달 -->
			<div class="modal fade" id="writeAbout" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog" role="document"> 
					<div class="modal-content"> 
						<div class="modal-header"> 
							<h5 class="modal-title" id="staticBackdropLabel">소개글 작성</h5> 
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button> 
						</div> 
						<form method="POST">
							<div class="modal-body">
								<input type="hidden" name="email" value="${login.email }">	 
								<textarea class="form-control" rows="10" cols="60" name="content" style="border: none; resize: none;" placeholder="나를 소개해주세요"></textarea>
							</div> 
							<div class="modal-footer"> 
								<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button> <button type="submit" class="btn btn-success">작성하기</button> 
							</div> 
						</form>
					</div> 
				</div> 
			</div>
		</c:when>
		<c:otherwise>
			<div>
				<p>&nbsp;</p>
				<p><c:out value="${content }" /></p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
			</div>
			<c:if test="${email eq login.email }">
				<div>
					<button class="saveBtn btn btn-default" data-toggle="modal" data-target="#updateAbout">소개 글 수정하기</button>
				</div>
			</c:if>
			
			<!-- 소개글 수정 모달 -->
			<div class="modal fade" id="updateAbout" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog" role="document"> 
					<div class="modal-content"> 
						<div class="modal-header"> 
							<h5 class="modal-title" id="staticBackdropLabel">소개글 수정</h5> 
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button> 
						</div> 
						<form method="POST" action="${cpath }/${login.email}/about/update">
							<div class="modal-body">
								<input type="hidden" name="email" value="${login.email }">	 
								<textarea class="form-control" rows="10" cols="60" name="content" style="border: none; resize: none;" placeholder="소개글을 수정합니다">${content }</textarea>
							</div> 
							<div class="modal-footer"> 
								<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button> <button type="submit" class="btn btn-success">수정하기</button> 
							</div> 
						</form>
					</div> 
				</div> 
			</div>
		</c:otherwise>
	</c:choose>
</div>
</body>
</html>

