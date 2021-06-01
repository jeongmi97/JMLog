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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<style>
    
a { text-decoration: none; color: #000000; }
    
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
</style>
</head>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<body>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>	

<script type="text/javascript">
	// 이전 버튼 이벤트
	function prev(page, range, rangeSize){
		var page = ((range)-2 * rangeSize) + 1;	// 무조건 이전 페이지 범위의 가장 앞 페이지로 이동하기 위해 처리
		var range = range - 1; 
		
		// email?page=page&range=range
		var url = '${cpath}/${user.email}?page='+ page + '&range=' + range + '&category=${nowCate}';
		
		location.href = url;
	}
	
	// 페이지 번호 클릭
	function pagination(page, range, rangeSize){
		var url = '${cpath}/${user.email}?page='+ page + '&range=' + range + '&category=${nowCate}';
		
		location.href = url;
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

<div class="container">
	<div class="row">
		<div class="col-md-3">
			<a href="${cpath }/${user.email}">전체보기 (${fn:length(uBoard) })</a><br><hr>
			<c:forEach items="${category }" var="category">
				<a href="${cpath }/${user.email}?category=${category.catename }"><c:out value="${category.catename }"/> (<c:out value="${category.catecnt }"/>)</a><br>
			</c:forEach>
		</div>
		<div class="col-md-9">
			<c:choose>
				<c:when test="${nowCate eq 'nocate' }">
					<div><strong>All</strong></div><hr>
				</c:when>
				<c:otherwise>
					<div><c:out value="${nowCate }"></c:out></div><hr>
				</c:otherwise>
			</c:choose>
			<div class="content">
				<c:forEach items="${uBoard}" var="uBoard"> 
					<div><a href="${cpath }/${user.email}/${uBoard.idx }"><h3><c:out value="${uBoard.title } " /></h3></a></div>
					<div style="table-layout:fixed"><c:out value="${uBoard.content } " escapeXml="false"/></div>
					<div><c:out value="${uBoard.reporting_date }" /></div><br>
					<hr>
				</c:forEach>
				<!-- 페이징 -->
				<div style="text-align: center">
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
		</div>
	</div>
</div>


<footer id="footer">
	footer
</footer>

</div>

</body>
</html>