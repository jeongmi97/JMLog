<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>JMLog</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
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
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
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
				    	<h3 class="title"><a href="${cpath }/${post.nickname}/${post.idx}"><c:out value="${post.title }" escapeXml="false" /></a></h3>
				    	<label>
				    		<a href="${cpath }/${post.nickname}"><span style="color: #848482;">by </span><span><c:out value="${post.nickname }" /></span></a>
				    	</label>
				    	<span style="color: #848482;"><c:out value="${post.reporting_date }"/></span>
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
