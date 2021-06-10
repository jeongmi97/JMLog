<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestbook</title>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
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
<script type="text/javascript">
	
	$(function(){
		
		// 작성 버튼 클릭 시
		$('#insertBtn').on('click', function(){	
			var email = '${user.email}';
			var nickname = '${login.nickname}';
			var content = $('#content').val().replace(/\n/g, "<br>");	// DB에 줄바꿈 내용까지 저장 되도록 태그 치환하여 넣기
			$('#content').val(content);
			
			
			if('${login.email}' == ''){	// 미로그인상태에서 방명록 작성 기능 x
				alert('로그인이 필요합니다!');
				return;
			}else if(content == ''){	// 아무것도 입력하지 않은 채 작성 눌렀을 때
				alert('글을 입력해주세요!');
				return;
			}else
				$('#insertForm').submit();		// 조건 만족 시 폼 전송
		});
		
		$('#updateBtn').on('click', function(){
			var content = $('#updateContent').val().replace(/\n/g, "<br>");
			$('#content').val(content);
			
			if(content == ''){	// 아무것도 입력하지 않은 채 작성 눌렀을 때
				alert('글을 입력해주세요!');
				return;
			}else
				$('form').submit();		// 조건 만족 시 폼 전송
		});
		
		$('#updateGuest').on('show.bs.modal', function(e){	// 모달 호출 버튼 눌렀을 때
			var content = $(e.relatedTarget).data('test');	// 호출 버튼에 넣어놓은 값 가져옴(원래 방명록 내용)
			console.log('====='+content);
			$('#updateContent').val(content.replace("<br>", "\r\n")); // <br> 태그 치환 후 textarea에 넣어줌
		});
	});
	
	function delGuest(idx){
		$.ajax({
			type: 'get',
			url: '${cpath}/${user.email}/guestbook/delGuest?idx=' + idx,
			success: function(){
				$('div').remove('#guest' + idx);
			}
		});
	}
</script>	

<header>
	<div class="container">
	<div class="row mt-2">
		<div class="col-md-8 "><h2><a href="${cpath }/">JMLog</a></h2></div>
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

<div class="container" id="guestbookForm">
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<h2>Guestbook</h2>
			<br>
			<form method="POST" id="insertForm" action="${cpath }/${user.email}/guestbook">
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
</body>
</html>