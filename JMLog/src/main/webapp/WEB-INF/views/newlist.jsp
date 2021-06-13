<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>JMLog</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/home.css">
</head>
<body>

<script type="text/javascript">
//이전 버튼 이벤트
function prev(page, range, rangeSize){
	var page = ((range)-2 * rangeSize) + 1;	// 무조건 이전 페이지 범위의 가장 앞 페이지로 이동하기 위해 처리
	var range = range - 1; 
	
	// email?page=page&range=range
	var url = '${cpath}/newlist?page='+ page + '&range=' + range;
	
	location.href = url;
}

// 페이지 번호 클릭
function pagination(page, range, rangeSize){
	var url = '${cpath}/newlist?page='+ page + '&range=' + range;
	
	location.href = url;
}

//다음 버튼 이벤트
function fn_next(page, range, rangeSize) {
	var page = parseInt((range * rangeSize)) + 1;
	var range = parseInt(range) + 1;

	var url = '${cpath}/newlist?page='+ page + '&range=' + range;

	location.href = url;
}
</script>
<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>
<nav>
	<div class="container" style="margin-top: 40px; margin-bottom: 30px;">
		<div class="row">
			<ul>
		  		<li class="navi" id="popular"><a href="${cpath }/">인기</a></li>
		  		<li class="navi" id="latest"><strong><a href="${cpath }/newlist" style="color: #6A5ACD;">최신</a></strong></li>
			</ul>
		</div>
	</div>
</nav>
<div id="postContainer" class="container">
	<div class="content">
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
	<!-- 페이징 -->
	<div class="paging" style="text-align: center;">
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


</body>
</html>
