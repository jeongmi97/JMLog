<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="cpath" value="${pageContext.request.contextPath }" />
<html>
<head>
<title>Insert title here</title>

<!-- 부트스트랩 -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<style type="text/css">

a { text-decoration: none !important; color: #000000; }

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

ul{
	list-style: none;
}
.navi{
	float: left;
	font-size: 20px;
	margin-right: 20px;
}
.thumbnail{
	height: 250px;
}
</style>
</head>
<body>
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script> -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>	

<script type="text/javascript">
/*var  page = 2;
	
	$(function (){
		//페이지 로드 시 데이터 가져온뒤 page 증가
		getList(page);
		page++;
	});
	
	$(window).scroll(function(){
		// 스크롤이 최하단으로 내려가면 리스트 조회한 뒤 page 증가
		if($(window).scrollTop() >= $(document).height() - $(window).height()){
			getList(page);
			page++;
		}
	});
	
	function getList(page){
		
		var headers = {"Content-Type": "application/json"
			,"X-HTTP-Method-Override": "POST"};
		
		$.ajax({
			type: 'POST',
			dataType: 'json',
			data: {"page", page},
			url: 'home/getBoard',
			headers: headers,
			succes: function(result){
				var addList = '';
				for(var i=0; i<data.length; i++){
					addList +=
				}
				
			}
		})
	} */
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
		  		<li class="navi" id="latest"><a href="#">최신</a></li>
			</ul>
		</div>
	</div>
</nav>
<div class="container">
	<c:forEach var="post" items="${postList }" varStatus="status">
		<div class="row">
			<c:forEach var="i" begin="${status.index }" end="${status.index + 2 }" step="1">
				<div class="col-sm-4 col-md-4">
				    <div class="thumbnail">
				    	<div class="caption">
				        	<h3><c:out value="${post[i].title }" /></h3>
				        	<p>...</p>
		      			</div>
		      		</div>
		    	</div>
			</c:forEach>
		</div>
	</c:forEach>
</div>
<footer>
	
</footer>

</body>
</html>
