<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>JMLog</title>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/home.css">
</head>
<body>

<script type="text/javascript">

var loading = false;	// 중복실행 여부
var  page = 2;			// 불러올 페이지
	
	$(function(){
		
	/* // 무한스크롤
	$(window).scroll(function(){
		var scroll = $(window).scrollTop(); //스크롤의 현재 위치
		var docHeight = $(document).height() //도큐먼트 높이로 고정
		var winHeight = $(window).height() //윈도우창 높이 가변
		
		if(scroll == docHeight - winHeight){
			console.log($(window).scrollTop());
			console.log('doc height : ' + $(document).height());
			console.log('win height : ' + $(window).height());
			getList();
			page++;
		}
	});
	
	function getList(){
		console.log('page :' + page );
		$.ajax({
			type: 'get',
			url: 'home/getBoardList?page='+page,
			dataType: 'json',
			succes: function(data){
				console.log('성공');
				if(data != null){
					for(var i in data){
						$('#postContainer').append('<div>추가됨</div>');
					}
				}
				
				loading = false;	// 실행 가능 상태
			},
			error: function(error){
				console.log(error);
			}
		});
	}; */
	
	});
</script>
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
	<div class="container" style="margin-top: 40px; margin-bottom: 30px;">
		<div class="row">
			<ul>
		  		<li class="navi" id="popular"><strong><a href="${cpath }" style="color: #6A5ACD	;">인기</a></strong></li>
		  		<li class="navi" id="latest"><a href="${cpath }/newlist">최신</a></li>
			</ul>
		</div>
	</div>
</nav>
<div id="postContainer" class="container">
	<c:forEach var="post" items="${postList }" varStatus="status">
		<c:if test="${status.count == 1 || status.count % 3 == 1}">
			<div class="row">
		</c:if>
			<div class="col-sm-4 col-md-4">
				<div class="thumbnail">
					<div class="caption">
				    	<h3 class="title"><a href="${cpath }/${post.email}/${post.idx}"><c:out value="${post.title }" escapeXml="false" /></a></h3>
				    	<hr>
				        <p>
				        	<c:out value="${post.content }" escapeXml="false" />
				        </p>
		      		</div>
		      	</div>
		    </div>
		<c:if test="${status.count % 3 == 0}">
			</div>
		</c:if>
	</c:forEach>
</div>
<footer>
	
</footer>

</body>
</html>
