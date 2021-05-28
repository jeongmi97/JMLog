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
		// 게시글 삭제
		$(btnDel).click(function(){
			var idx = '${post.idx}';	// 게시글 번호
			
			var chk = confirm('삭제하시겠습니까?');	// 확인창 띄우기
			if(chk) location.href="${cpath}/delPost/"+idx;	// 확인 눌렀을 때 게시글 삭제
		})
		
		// 댓글 작성
		$(btnReply).click(function(){
			console.log('들어옴');
			var comment = $('#comment').val();	
			
			var paramData = JSON.stringify({
					"comment": comment,				// 댓글 내용
					"post_num": '${post.idx}',		// 게시글 번호
					"nickname": '${login.nickname}'	// 작성자 닉네임
			});
			
			var headers = {"Content-Type" : "application/json"
						, "X-HTTP-Method-Override" : "POST"};
			
			$.ajax({
				type:'POST',
				url: '${cpath}/${post.email}/${post.idx}/saveReply',
				headers: headers,
				data: paramData,
				contentType: "application/json",
				success: function(idx) {
					if(idx != 0){	// 댓글 정상적으로 insert 되면 댓글 추가 메소드 실행
						listReply(idx);
					}
				},
				error: function(error){
					console.log(error);
				}
			});
		});
		
		// 작성한 댓글 추가
		function listReply(idx){
			var date = new Date();
			var nowTime = date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate(); // 댓글 작성 시간 구하기 yyyy-mm-dd
			console.log('지금 시간 : ' + nowTime);
			var htmls = '';
			htmls+='<div id="reply'+idx+'"><div id="nickname">' + '${login.nickname}' + '</div>';
			htmls+='<div><span><a href="#" onclick="updateReply('+idx+')">수정</a></span>'
			htmls+='<span><a href="#" onclick="delReply('+idx+')">삭제</a></span></div>'
			htmls+='<p id="reply">' + $('#comment').val() + '</p>';
			htmls+='<div id="reply_date">' + nowTime + '</div>';
			htmls+='</div>';
			
			$("#replyList").append(htmls);	// 댓글 리스트 영역에 추가
		};
		
	});
	
	// 댓글 삭제
	function delReply(idx){
		console.log('댓글 번호:' + idx);
		
		$.ajax({
			type: 'get',
			url: '${cpath}/${post.email}/${post.idx}/delReply?idx='+idx,
			success: function(data){
				console.log('삭제완료');
				$('div').remove('#reply'+idx);
			},
			error: function(error){
				console.log(error);
			}
		});
	};
	
	// 댓글 수정 버튼 눌렀을 때
	function updateReply(idx,comment){
		$('#reply'+idx+'actions').hide();	// 댓글 다 없애고 수정 할 때 예외사항 처리하기
		var htmls='';
		htmls+='<div id="updateForm"><textarea id="updateComment" placeholder="댓글을 작성하세요">'+comment+'</textarea>';
		htmls+='<div><button id="cancle" onclick="cancle('+idx+');">취소</button>';
		htmls+='<button id="update" onclick="update('+idx+');">댓글 수정</button></div></div>';
		$('#reply'+idx).append(htmls);
	};
	
	// 댓글 수정 취소
	function cancle(idx){
		$('#updateForm').hide();
		$('#reply'+idx+'actions').show();
	};
	
	// 댓글 수정
	function update(idx){
		console.log($('#updateComment').val());
		var comment = $('#updateComment').val()	// 수정할 내용 값
		var paramData = JSON.stringify({
			"comment": comment,
			"idx": idx
		});
		
		var headers = {"Content-Type" : "application/json"
			, "X-HTTP-Method-Override" : "POST"};
		
		$.ajax({
			type:'POST',
			url: '${cpath}/${post.email}/${post.idx}/updateReply',
			headers: headers,
			data: paramData,
			contentType: "application/json",
			success: function(idx){
				if(idx != 0){	// 댓글 정상적으로 insert 되면 댓글 추가 메소드 실행
					$('#reply'+idx+'comment').text(comment);	// 수정한 내용으로 표시
					cancle(idx);
				}
			},
			error: function(error){
				console.log(error);
			}
		})
	}
</script>

	포스트화면<br>
	${post.title }<br>
	${post.content }<br>
	<div>
		<div><span>${post.email }</span><span> | </span><span>${post.reporting_date }</span><span> |</span></div>
		<!-- 로그인한 사용자와 글 작성자가 같을 때 수정/삭제 버튼 보이게 -->
		<c:if test="${login.email eq post.email }">	
			<div><span><a href="${cpath }/editPost?idx=${post.idx}&mode=edit">수정</a></span> | <span><input type="button" value="삭제" id="btnDel"></span></div>
		</c:if>
	</div>
	
	<!-- 댓글 작성 폼 -->
	<div>
		<textarea rows="5" cols="50" id="comment" placeholder="댓글을 작성하세요"></textarea><br>
		<button id="btnReply">댓글 작성</button>
	</div><br>
	
	<!-- 댓글 리스트 -->
	
	<div id="replyList">
	<hr>
	<c:if test="${not empty reply }">	<!-- 댓글이 있을 때 -->
		<c:forEach items="${reply }" var="reply">
				<div id="reply${reply.idx }">
					<div id="nickname"><c:out value="${reply.nickname }" /></div>
					<div id="reply_date"><c:out value="${reply.reply_date }"/></div>
					<div id="reply${reply.idx }actions">
					<div>
						<span><a href="#" onclick="updateReply('${reply.idx}','${reply.comment }')">수정</a></span>
						<span><a href="#" onclick="delReply('${reply.idx}')">삭제</a></span>
					</div>
					<p id="reply${reply.idx }comment"><c:out value="${reply.comment }" /></p>
					</div>
					
				</div>
				<hr>
		</c:forEach>
	</c:if>
	</div>
	
</body>
</html>