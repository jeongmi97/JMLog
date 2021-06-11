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

#replyBtn{ color: #A9A9A9; }

#nickname{ margin-bottom: 10px; }
</style>
</head>
<body>
<script type="text/javascript">
	
	$(function(){
		// 게시글 삭제
		$('#btnDel').click(function(){
			var idx = '${post.idx}';	// 게시글 번호
			
			var chk = confirm('삭제하시겠습니까?');	// 확인창 띄우기
			if(chk) location.href="${cpath}/delPost/"+idx;	// 확인 눌렀을 때 게시글 삭제
		})
		
		// 댓글 작성
		$(btnReply).click(function(){
			console.log('들어옴');
			if('${login.email}' == ''){		// 미로그인 상태에서 댓글 작성 시도 시 
				console.log('미로그인');
				alert('로그인이 필요합니다!');	// 로그인 필요 알림창 띄운뒤
				return;						// 댓글 작성 기능 수행 x
			}
			
			var comment = $('#comment').val().replace(/\n/g, "<br>");	
			
			if(comment == ''){				// 아무것도 입력하지 않은 채 작성 눌렀을 때
				alert('댓글을 입력해주세요!');
				return;
			}
			
			var paramData = JSON.stringify({
					"comment": comment,				// 댓글 내용
					"post_num": '${post.idx}',		// 게시글 번호
					"nickname": '${login.nickname}'	// 작성자 닉네임
			});
			
			var headers = {"Content-Type" : "application/json"
						, "X-HTTP-Method-Override" : "POST"};
			
			$.ajax({
				type:'POST',
				url: '${cpath}/${post.nickname}/${post.idx}/saveReply',
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
			htmls+='<p id="reply">' + $('#comment').val() + '</p>';
			htmls+='<div id="reply_date">' + nowTime + '</div>';
			htmls+='<div><span><a href="#" onclick="updateReply('+idx+')" id="replyBtn">수정</a></span><span id="replyBtn"> | </span>';
			htmls+='<span><a href="#" onclick="delReply('+idx+')" id="replyBtn">삭제</a></span></div>';
			htmls+='<hr></div>';
			
			$("#replyList").append(htmls);	// 댓글 리스트 영역에 추가
		};
		
	});
	
	// 댓글 삭제
	function delReply(idx){
		console.log('댓글 번호:' + idx);
		
		$.ajax({
			type: 'get',
			url: '${cpath}/${post.nickname}/${post.idx}/delReply?idx='+idx,
			success: function(data){
				console.log('삭제완료');
				$('div').remove('#reply'+idx);
				$('hr').remove('#reply'+idx);
			},
			error: function(error){
				console.log(error);
			}
		});
	};
	
	// 댓글 수정 버튼 눌렀을 때
	function updateReply(idx,comment){
		$('#reply'+idx+'actions').hide();	// 원래 댓글 내용 div 숨김
		comment = comment.replace("<br>", "\r\n");
		// 댓글 수정 폼 생성 후 표시
		var htmls='';
		htmls+='<div id="updateForm"><textarea class="form-control" id="updateComment" rows="5" cols="150" placeholder="댓글을 작성하세요" style="resize: none; " escapeXml="false">'+comment+'</textarea>';
		htmls+='<div><button class="btn btn-link btn-sm" id="cancle" onclick="cancle('+idx+');">취소</button>';
		htmls+='<button class="btn btn-link btn-sm" id="update" onclick="update('+idx+');">댓글 수정</button></div></div>';
		$('#reply'+idx).append(htmls);
	};
	
	// 댓글 수정 취소
	function cancle(idx){
		$('#updateForm').remove();	// 댓글 생성 폼 삭제
		$('#reply'+idx+'actions').show();	// 댓글 내용 화면에 표시
	};
	
	// 댓글 수정
	function update(idx){
		console.log($('#updateComment').val());
		var comment = $('#updateComment').val().replace(/\n/g, "<br>")	// 수정할 내용 값
		var paramData = JSON.stringify({
			"comment": comment,
			"idx": idx
		});
		
		var headers = {"Content-Type" : "application/json"
			, "X-HTTP-Method-Override" : "POST"};
		
		$.ajax({
			type:'POST',
			url: '${cpath}/${post.nickname}/${post.idx}/updateReply',
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
		});
	}
</script>

<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<hr>
</header>

<div class="container">
	<h2><strong>${post.title }</strong></h2><br>
	<div class="hgroup row">
		<div><span>${post.nickname }</span><span> | </span><span>${post.reporting_date }</span>
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
	<c:if test="${not empty login }">	<!-- 로그인 한 유저만 댓글 작성가능 -->
		<div class="row">
			<textarea class="form-control" rows="5" cols="150" id="comment" placeholder="댓글을 작성하세요" wrap="hard" required></textarea><br>
			<button id="btnReply">댓글 작성</button>
		</div>
	</c:if>
	<br>
	
	<!-- 댓글 리스트 -->
	
	<div class="row" id="replyList">
	<hr>
	<c:if test="${not empty reply }">	<!-- 댓글이 있을 때 -->
		<c:forEach items="${reply }" var="reply">
				<div id="reply${reply.idx }">
					<div id="nickname"><a href="${cpath }/reply/${reply.nickname}"><strong><c:out value="${reply.nickname }" /></strong></a></div>
					<div id="reply${reply.idx }actions">
						<p id="reply${reply.idx }comment"><c:out value="${reply.comment }" escapeXml="false" /></p>
						<div id="reply_date"><c:out value="${reply.reply_date }"/></div>
						<c:if test="${login.nickname eq reply.nickname }">
							<div>
								<span><a href="#" onclick="updateReply('${reply.idx}','${reply.comment }')" id="replyBtn">수정</a></span><span> | </span>
								<span><a href="#" onclick="delReply('${reply.idx}')" id="replyBtn">삭제</a></span>
							</div>
						</c:if>
					</div>
				</div>
					<hr id="reply${reply.idx }">
		</c:forEach>
	</c:if>
	</div>
</div>	
</body>
</html>