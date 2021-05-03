<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.nickname }</title>

<style>
	header#header { width:1700px; margin:0 auto; background: #fdd; }
	div#wrap { width:1200px; margin:0 auto; text-align: center; background:#ddd; }
	nav#nav { background: #dfd; }
	section#container { background: #ddf; }
		div.content { background: #eee; }
		aside#aside { background: #fff; }
	footer#footer { background: #ffe; }
	
	div#warp, header#header, nav#nav,
    section#container, div.content, aside#aside,
    footer#footer { padding:10px; }
    
    div.headerLeft { width:50%; float: lefft; }
    div.headerRight { width:50%; float: right; }
    div.profile	{ float: right; }
    
    nav#nav ul { margin:0; padding:0; list-style:none; display: inline-block; }
    nav#nav ul li { background:#eee; padding:10px; display:inline-block; }
    
    div.content { width: 850px; float:right; }
    aside#aside { width: 270px; float:left; }
    
    section#container::after { content:""; display:block; clear:both; }
    
    @media screen and (max-width: 910px){
    	div#wrap { width:calc(100% - 20px); }
    	div.content { width:clac(100% - 20px - 240px - 20px); }
    	aside#aside { width:220px; }
    }
    
    @media screen and (max-width: 650px) {
    	div.content,
    	aside#aside { width:calc(100% - 20px); float:none; }
	}
    
    a { text-decoration: none; color: #000000; }
    
</style>
</head>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<body>

<script type="text/javascript">
	// 이전 버튼 이벤트
	function prev(page, range, rangeSize){
		var page = ((range)-2 * rangeSize) + 1;	// 무조건 이전 페이지 범위의 가장 앞 페이지로 이동하기 위해 처리
		var range = range - 1; 
		
		// email?page=page&range=range
		var url = '${cpath}/${user.email}?page='+ page + '&range=' + range;
		
		location.href = url;
	}
	
	// 페이지 번호 클릭
	function pagination(page, range, rangeSize){
		var url = '${cpath}/${user.email}?page='+ page + '&range=' + range;
		
		location.href = url;
	}
</script>

<header id="header">
	<div>
		<div class="headerLeft">
			<a href="${cpath }/${user.email}">${user.nickname }.Log</a>
		</div>
		<div class="headerRight">
			<a href="">검색</a>
			<button type="button" onclick="location.href='${cpath}/write'">새글쓰기</button>
			<div class="setting"><a href="${cpath }/setting">설정</a></div>
		</div>
	</div>
</header>

<div id="wrap">

<nav id="nav">
	<ul>
	<!-- user로 받을 필요 있는지 확인하기 -->
		<li><a href="${cpath }/${user.email}">글</a></li>
		<li><a href="${cpath }/${user.email}/guestbook">방명록</a></li>
		<li><a href="${cpath }/${user.email}/about">소개</a></li>
	</ul>
</nav>

<section id="container">
	<aside id="aside">
		<a href="${cpath }/${user.email}">전체보기(${fn:length(uBoard) })</a>
	</aside>
	
	<div class="content">
		글 목록<br><br>
		<c:forEach items="${uBoard}" var="uBoard"> 
			<div><a href="${cpath }/${user.email}/${uBoard.idx }"><c:out value="${uBoard.title } " /></a></div>
			<div><c:out value="${uBoard.content } " /></div>
			<div><c:out value="${uBoard.reporting_date }" /></div><br>
		</c:forEach>
		<!-- 페이징 -->
	<div id="paginationBox">
			<!-- 이전 버튼 -->
			<c:if test="${pagination.prev}">
				<span>
					<button onclick="prev(${pagination.page},${pagination.range },${pagination.rangeSize })">Prev</button>
				</span>
			</c:if>
			
			<!-- 페이지 -->
			<c:forEach begin="${pagination.startPage }" end="${pagination.endPage }" var="idx">
					<a href="#" onclick="pagination(${idx}, ${pagination.range }, ${pagination.rangeSize })"> ${idx }</a>
			</c:forEach>
			
			<!-- 다음 버튼 -->
			<c:if test="${pagination.next }">
				<span>
					<button onclick="next(${pagination.range}, ${pagination.range }, ${pagination.rangeSize })">Next</button>
				</span>
			</c:if>
	</div>
	</div>
	
</section>

<footer id="footer">
	footer
</footer>

</div>

</body>
</html>