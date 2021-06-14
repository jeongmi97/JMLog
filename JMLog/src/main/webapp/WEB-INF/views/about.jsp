<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소개</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/navStyle.css">
<style type="text/css">
.content{ text-align: center; }	
</style>
</head>
<body>
<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>
<nav>
	<%@ include file="/WEB-INF/views/include/mainNav.jsp" %>
</nav>
<div class="container content">
	<c:choose>
		<c:when test="${empty content }">	<!-- 소개글 없을 때 -->
			<div>
				<p>&nbsp;</p>
				<p>소개글이 아직 없습니다ㅠㅠ</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
			</div>
			<!-- 로그인 유저와 블로그 주인이 같을 때 작성 가능 하도록 -->
			<c:if test="${user.nickname eq login.nickname }">
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
								<input type="hidden" name="nickname" value="${login.nickname }">	 
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
		<c:otherwise>	<!-- 소개글 있을 때 -->
			<div>
				<p>&nbsp;</p>
				<p><c:out value="${content }" /></p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
			</div>
			<!-- 로그인 유저와 블로그 주인이 같을 때 수정 가능 하도록 -->
			<c:if test="${user.nickname eq login.nickname }">
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
						<form method="POST" action="${cpath }/${login.nickname}/about/update">
							<div class="modal-body">
								<input type="hidden" name="nickname" value="${login.nickname }">	 
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

