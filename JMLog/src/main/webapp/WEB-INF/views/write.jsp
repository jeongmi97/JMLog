<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="${cpath }/resources/css/navStyle.css">
<style type="text/css">
#title{
	border-top: 0;
	border-left: 0;
	border-right: 0;
	width: 1140px;
	height: 45px;
	margin-top: 20px;
	margin-bottom: 20px;
	font-size: 20pt;
}
#category{
	width: 170px;
	height: 30px;
}
#lock_post{ margin-right: 8px; }
</style>
</head>

<body>

<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<hr>
</header>

<div class="container">
	<form:form method="post" modelAttribute="post" action="${cpath }/write">
		<form:hidden path="idx"/>	<!-- 포스트 번호 -->
		<form:hidden path="nickname" value="${login.nickname }"/>	<!-- 작성자 닉네임 -->
		<input type="hidden" name="mode" value="${mode }">	<!-- 신규 생성 & 수정 확인 값 -->
		
		<!-- 카테고리 선택 -->
		<form:select path="cate" id="category">
			<option value="nocate">카테고리</option>
			<form:options items="${category }" itemLabel="catename" itemValue="catename"/>
		</form:select>
		<form:input path="title" type="text" name="title" id="title" placeholder="제목을 입력하세요" required="required"/>
		<form:textarea path="content" class="summernote" name="content" id="content" rows="40" required="required" /><br>
		<form:checkbox path="lock_post" value="y" name="lock_post" id="lock_post"/><label for="lock_post">비공개</label>
		<input type="submit" value="작성하기">
	</form:form>
</div>

<script src="${cpath}/resources/js/write.js"></script>
</body>
</html>