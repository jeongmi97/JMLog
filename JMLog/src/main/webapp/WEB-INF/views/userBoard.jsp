<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.nickname }</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/navStyle.css">
<style>
#reportDate{ margin-top: 20px; }

</style>
</head>

<body>
<script type="text/javascript">
	// 이전 버튼 이벤트
	function prev(page, range, rangeSize){
		var page = ((range)-2 * rangeSize) + 1;	// 무조건 이전 페이지 범위의 가장 앞 페이지로 이동하기 위해 처리
		var range = range - 1; 
		
		// email?page=page&range=range
		var url = '${cpath}/${user.nickname}?page='+ page + '&range=' + range + '&category=${nowCate}';
		
		location.href = url;
	}
	
	// 페이지 번호 클릭
	function pagination(page, range, rangeSize){
		var url = '${cpath}/${user.nickname}?page='+ page + '&range=' + range + '&category=${nowCate}';
		
		location.href = url;
	}
</script>

<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>

<nav>
	<%@ include file="/WEB-INF/views/include/mainNav.jsp" %>
</nav>

<div class="container">
	<div class="row">
		<div class="col-md-3">
			<a href="${cpath }/${user.nickname}">전체보기 (${fn:length(uBoard) })</a><br><hr>
			<c:forEach items="${category }" var="category">
				<a href="${cpath }/${user.nickname}?category=${category.catename }"><c:out value="${category.catename }"/> (<c:out value="${category.catecnt }"/>)</a><br>
			</c:forEach>
		</div>
		<div class="col-md-9">
			<c:choose>
				<c:when test="${nowCate eq 'nocate' }">
					<div><strong>All</strong></div><hr>
				</c:when>
				<c:otherwise>
					<div><strong><c:out value="${nowCate }" /></strong></div><hr>
				</c:otherwise>
			</c:choose>
			<div class="content">
				<c:forEach items="${uBoard}" var="uBoard"> 
					<div><a href="${cpath }/${user.email}/${uBoard.idx }"><h3><c:out value="${uBoard.title } " /></h3></a></div>
					<div style="table-layout:fixed"><c:out value="${uBoard.content } " escapeXml="false"/></div>
					<div class="text-dark" style="color: #A9A9A9;" id="reportDate"><c:out value="${uBoard.reporting_date }" /> | <c:out value="${uBoard.hit }"/>회조회</div>
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
</footer>

</div>

</body>
</html>