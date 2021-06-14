<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/navStyle.css">
<style type="text/css">
.categorybox{
	margin: auto;
	margin-bottom: 5px;
	width: 300px;
	height: 30px;
}
#namebox{ float: left; }
#btnbox{ float: right; }
.addBtn{ margin-bottom: 10px; }
</style>
</head>
<body>
<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>

<nav>
	<%@ include file="/WEB-INF/views/include/settingNav.jsp" %>
</nav>

<div class="container">
	<div class="set_order" style="text-align: center;">
		<div class="list_order">
			<div class="categorybox">
				분류 전체보기
			</div>
			<form id="addCate" method="post" action="">
				<input type="hidden" name="email" value="${login.email }">
				<c:forEach var="category" items="${category }">
					<div class="categorybox" id="cate${category.idx }"><span id="namebox"><c:out value="${category.catename }" /></span><span id="btnbox"><button type="button" class="updateBtn btn btn-default btn-xs" onclick="updateBtn('${category.idx}', '${category.catename }')">수정</button> <button type="button" class="deleteBtn btn btn-default btn-xs" onclick="deleteBtn('${category.idx}','${category.catename }')">삭제</button></span></div>
				</c:forEach>
			</form>
		</div>
		<div class="add_order">
			<input type="button" class="addBtn btn btn-default" value="카테고리 추가">
		</div>
		<div>
			<button class="saveBtn btn btn-default">저장</button>
		</div>
	</div>
</div>

<script src="${cpath }/resource/js/category.js"></script>
</body>
</html>