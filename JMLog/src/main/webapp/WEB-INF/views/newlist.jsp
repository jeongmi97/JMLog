<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>JMLog</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/home.css">
</head>
<body>

<script type="text/javascript">

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
<div class="container">
	<c:forEach var="post" items="${postList }" varStatus="status">
		<c:if test="${status.count == 1 || status.count % 3 == 1}">
			<div class="row">
		</c:if>
			<div class="col-sm-4 col-md-4">
				<div class="thumbnail">
					<div class="caption">
				    	<h3 class="title"><c:out value="${post.title }" escapeXml="false" /></h3>
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
<%-- <div class="container">
	<c:forEach var="post" items="${postList }" varStatus="status">
		<div class="row">
			<c:if test="${status.index % 3 == 0}">
				한줄
				<div class="row">
			</c:if>
					<div class="col-sm-4 col-md-4">
						<div class="thumbnail">
							<div class="caption">
								<c:out value="${status.index }" />
						    	<h3><c:out value="${post.title }" /></h3>
						        <p><c:out value="${post.content }" /></p>
				      		</div>
				      	</div>
				    </div>
		    <c:if test="${status.index != 0 && status.index % 3 == 0}">
				</div>
			</c:if>
		</div>
	</c:forEach>
</div> --%>

<footer>
	
</footer>

</body>
</html>
