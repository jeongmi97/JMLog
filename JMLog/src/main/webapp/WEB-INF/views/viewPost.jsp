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
span{
	margin-right: 10px;
}
#delPost{
	margin-left: 10px;
}
#btnReply{
	width: 160px;
	height: 50px;
	border-width: thin;
	border-color: #DCDCDC;
	background-color: white;
}

textarea {
	box-shadow: none;
}
.hgroup{
	margin-bottom: 60px;
}
#comment{
	resize: none;
}
#reply_date{
	color: #A9A9A9;
}
#replyBtn{
	color: #A9A9A9;
}
#nickname{
	margin-bottom: 10px;
}
</style>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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
		});
	}
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
	<hr>
</header>

<div class="container">
	<h2><strong>${post.title }</strong></h2><br>
	<div class="hgroup">
		<div><span>${post.email }</span><span> | </span><span>${post.reporting_date }</span>
			<!-- 로그인한 사용자와 글 작성자가 같을 때 수정/삭제 버튼 보이게 -->
			<c:if test="${login.email eq post.email }">	
				<span> |</span><span><a href="${cpath }/editPost?idx=${post.idx}&mode=edit">수정</a></span> | <span id="delPost"><a id="btnDel" href="#">삭제</a></span>
			</c:if>
		</div>
		<hr>
	</div>
	<div class="cgroup">
		<p>${post.content }</p>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<hr>
	</div>
	
	<!-- 댓글 작성 폼 -->
	<div>
		<textarea rows="5" cols="150" id="comment" placeholder="댓글을 작성하세요"></textarea><br>
		<button id="btnReply">댓글 작성</button>
	</div>
	<br>
	
	<!-- 댓글 리스트 -->
	
	<div id="replyList">
	<hr>
	<c:if test="${not empty reply }">	<!-- 댓글이 있을 때 -->
		<c:forEach items="${reply }" var="reply">
				<div id="reply${reply.idx }">
					<div id="nickname"><a href="${cpath }/reply/${reply.nickname}"><strong><c:out value="${reply.nickname }" /></strong></a></div>
					<div id="reply${reply.idx }actions">
					<p id="reply${reply.idx }comment"><c:out value="${reply.comment }" /></p>
					<div id="reply_date"><c:out value="${reply.reply_date }"/></div>
					<c:if test="${login.nickname eq reply.nickname }">
						<div>
							<span><a href="#" onclick="updateReply('${reply.idx}','${reply.comment }')" id="replyBtn">수정</a></span><span id="replyBtn"> | </span>
							<span><a href="#" onclick="delReply('${reply.idx}')" id="replyBtn">삭제</a></span>
						</div>
					</c:if>
					</div>
					<hr>
				</div>
		</c:forEach>
	</c:if>
	</div>
</div>	
</body>
</html>