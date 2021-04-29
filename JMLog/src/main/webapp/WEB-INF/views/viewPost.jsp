<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title }</title>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<body>
<script type="text/javascript">
	
	$(function(){
		console.log('${post.idx}');
		// 게시글 삭제
		$(btnDel).click(function(){
			var idx = '${post.idx}';
			
			var chk = confirm('삭제하시겠습니까?');
			if(chk) location.href="${cpath}/delPost/"+idx;
		})
		
		// 댓글 작성
		$(btnReply).click(function(){
			console.log('들어옴');
			var comment = $('#comment').val();
			
			var paramData = {
					"comment": comment,
					"post_num": '${post.idx}',
					"nickname": '${login.nickname}'
			};
			
			$.ajax({
				type:'POST',
				url: '${cpath}/${post.email}/${post.idx}/saveReply',
				data: JSON.stringify(paramData),
				contentType: "application/json",
				success: function(data) {
					if(data == 1){
						listReply();
					}
				},
				error: function(error){
					console.log(error);
				}
			});
		});
		
		function listReply(){
			var date = new Date();
			var nowTime = date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate(); // 댓글 작성 시간 구하기 yyyy-mm-dd
			
			var htmls = '';
			htmls+='<div><div id="nickname">' + '${login.nickname}' + '</div>';
			htmls+='<p id="reply">' + $('#comment').val() + '</p>';
			htmls+='<div id="reply_date">' + nowtime + '</div>';
			htmls+='</div>';
			
			$("#lastLine").prepend(htmls);
		};
		
	});
	
</script>

	포스트화면<br>
	${post.title }<br>
	${post.content }<br>
	<div>
		<div><span>${post.email }</span><span> | </span><span>${post.reporting_date }</span><span> |</span></div>
		<div><span><a href="${cpath }/editPost?idx=${post.idx}&mode=edit">수정</a></span> | <span><input type="button" value="삭제" id="btnDel"></span></div>
	</div>
	
	<!-- 댓글 작성 폼 -->
	<div>
		<textarea rows="5" cols="50" id="comment" placeholder="댓글을 작성하세요"></textarea><br>
		<button id="btnReply">댓글 작성</button>
	</div><br>
	
	<!-- 댓글 리스트 -->
	<c:if test="${not empty reply }">	// 댓글이 있을 때
	<div>
		<c:forEach items="${reply }" var="reply">
				<div>
					<div id="nickname"><c:out value="${reply.nickname }" /></div>
					<p id="reply"><c:out value="${reply.comment }" /></p>
					<div id="reply_date"><c:out value="${reply.reply_date }"/></div>
				</div>
				<hr>
		</c:forEach>
	</div>
	</c:if>
	<hr id="lastLine">
	
</body>
</html>