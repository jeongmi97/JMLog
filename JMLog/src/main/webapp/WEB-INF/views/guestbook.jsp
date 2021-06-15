<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestbook</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/navStyle.css">
<style type="text/css">
#guestbookForm{ margin-bottom: 30px; }
#guest_date{
	margin-top: 10px;
	color: #A9A9A9;
}
hr{
	margin-top: 10px;
	margin-bottom: 10px;
}
p{
	margin-top: 20px;
	margin-bottom: 20px;
}
.guestbookbox{
	padding: 0;
	margin-bottom: 30px;
}
</style>
</head>
<body>

<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>
<nav>
	<%@ include file="/WEB-INF/views/include/mainNav.jsp" %>
</nav>

<div class="container" id="guestbookForm">
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<h2>Guestbook</h2>
			<br>
			<form method="POST" id="insertForm" action="${cpath }/${user.nickname}/guestbook">
				<input type="hidden" name="email" value="${user.email }">
				<input type="hidden" name="nickname" value="${login.nickname }">
				<fieldset>
					<div class="row">
						<textarea  class="form-control" id="content" rows="5" name="content" placeholder="소중한 글을 입력해주세요" style="resize: none;" warp="hard"></textarea>
					</div>
					<br>
					<div class="row">
						<button class="btn" id="insertBtn" type="button">작성하기</button>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</div>

<div class="container" id="guestbookList" style="padding: 0">
	<c:if test="${not empty guestbook }">
		<c:forEach items="${guestbook }" var="guestbook">
			<div class="guestbookbox col-md-6 col-md-offset-3" id="guest${guestbook.idx }">
				<div id="nickname"><a href="${cpath }/reply/${guestbook.nickname}"><strong><c:out value="${guestbook.nickname }" /></strong></a></div>
				<div id="guest_date"><c:out value="${guestbook.guest_date }"/></div>
				<div id="guest${guestbook.idx }actions">
					<hr>
					<p id="guest${guestbook.idx }content"><c:out value="${guestbook.content }" escapeXml="false" /></p>
					<c:if test="${login.nickname eq guestbook.nickname }">
						<div>
							<span><a href="#" data-toggle="modal" data-target="#updateGuest" data-test="${guestbook.content }">수정</a></span><span> | </span>
							<span><a href="javascript:;" onclick="delGuest('${guestbook.idx}')" id="replyBtn">삭제</a></span>
						</div>
					</c:if>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>
<!-- 소개글 수정 모달 -->
<div class="modal fade" id="updateGuest" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog" role="document"> 
		<div class="modal-content"> 
			<div class="modal-header"> 
				<h5 class="modal-title" id="staticBackdropLabel">방명록 수정</h5> 
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button> 
			</div> 
			<form method="POST" action="${cpath }/${user.email}/guestbook/update">
				<div class="modal-body">
					<input type="hidden" name="email" value="${user.email }">
					<input type="hidden" name="nickname" value="${login.nickname }"> 
					<textarea class="form-control" rows="10" cols="60" id="updateContent" name="content" style="border: none; resize: none;" placeholder="방명록을 수정합니다" warp="hard"></textarea>
				</div> 
				<div class="modal-footer"> 
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button> <button type="button" id="updateBtn" class="btn btn-success">수정하기</button> 
				</div> 
			</form>
		</div> 
	</div> 
</div>

<script src="${cpath }/resources/js/guestbook.js"></script>
</body>
</html>