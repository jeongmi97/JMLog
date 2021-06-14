<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title }</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/navStyle.css">
<style type="text/css">
span{ margin-right: 10px; }

#delPost{ margin-left: 10px; }

#btnReply{
	width: 160px;
	height: 50px;
	border-width: thin;
	border-color: #DCDCDC;
	background-color: white;
}

textarea { box-shadow: none; }

.hgroup{ margin-bottom: 60px; }

#comment{ resize: none; }

#reply_date{ color: #A9A9A9; }

.replyBtn{ color: #A9A9A9; }

#nickname{ margin-bottom: 10px; }
</style>
</head>
<body>

<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<hr>
</header>

<div class="container">
	<h2><strong>${post.title }</strong></h2><br>
	<div class="hgroup row">
		<div><span><a href="${cpath }/${post.nickname}">${post.nickname }</a></span><span> | </span><span>${post.reporting_date }</span>
			<!-- 로그인한 사용자와 글 작성자가 같을 때 수정/삭제 버튼 보이게 -->
			<c:if test="${login.nickname eq post.nickname }">	
				<span> |</span><span><a href="${cpath }/editPost?idx=${post.idx}&mode=edit">수정</a></span> | <span id="delPost"><a id="btnDel" href="#">삭제</a></span>
			</c:if>
		</div>
		<hr>
	</div>
	<div class="cgroup row">
		<p>${post.content }</p>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<hr>
	</div>
	
	<!-- 댓글 작성 폼 -->
	<div class="row">
		<textarea class="form-control" rows="5" cols="150" id="comment" placeholder="댓글을 작성하세요" wrap="hard" required></textarea><br>
		<button id="btnReply">댓글 작성</button>
	</div>
	<br>
	
	<!-- 댓글 리스트 -->
	<div class="row" id="replyList">
	<hr>
	<c:if test="${not empty reply }">	<!-- 댓글이 있을 때 -->
		<c:forEach items="${reply }" var="reply">
				<div id="reply${reply.idx }">
					<div id="nickname"><a href="${cpath }/reply/${reply.nickname}"><strong><c:out value="${reply.nickname }" /></strong></a></div>
					<div id="reply${reply.idx }actions">
						<p id="reply${reply.idx }comment"><c:out value="${reply.comment }" escapeXml="false" /></p>	<!-- 화면에 그대로 나오는 태그를 제거하기 위해 escapeXml에 false값을 준다 -->
						<div id="reply_date"><c:out value="${reply.reply_date }"/></div>
						<!-- 로그인중인 유저와 댓글 작성자가 같으면 수정, 삭제 버튼 보이게 함 -->
						<c:if test="${login.nickname eq reply.nickname }">	
							<div>
								<!-- 댓글 수정과 삭제 시 js 함수를 호출하여 처리한다 -->
								<span><a class="replyBtn" href="#" onclick="updateReply('${reply.idx}','${reply.comment }')" id="replyBtn${reply.idx }">수정</a></span><span> | </span>
								<span><a class="replyBtn" href="#" onclick="delReply('${reply.idx}')">삭제</a></span>
							</div>
						</c:if>
					</div>
				</div>
				<hr id="reply${reply.idx }">
		</c:forEach>
	</c:if>
	</div>
</div>	
<script src="${cpath }/resources/js/viewPost.js"></script>
</body>
</html>