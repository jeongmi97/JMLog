<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
<body>

글쓰기=============

<form:form method="post" modelAttribute="post" action="${cpath }/write">
	<form:hidden path="idx"/>
	<input type="hidden" name="mode">
	
	<label for="title">제목</label><form:input path="title" type="text" name="title" id="title" /><br>
	<label for="content">내용</label><form:textarea path="content" name="content" id="content" /><br>
	
	<input type="submit" value="작성하기">
</form:form>

<script type="text/javascript">
	
	$(document).ready(function() {
		// 게시글 수정 시 입력 폼 셋팅
		var mode = '<c:out value="${mode}"/>';	// 게시글 모드 가져옴
		
		if(mode == 'edit'){	// 수정 모드일때
			$("input:hidden[name='idx']").val('<c:out value="${post.idx}"/>');
			$("input:hidden[name='mode']").val('<c:out value="${mode}"/>');
			$('#title').val('<c:out value="${post.title}"/>');
			$('#content').val('<c:out value="${post.content}"/>');

		}
	});
	
	ClassicEditor 
		.create( document.querySelector('#content' ) ) 
		.then( editor => { 
			console.log( editor ); 
		} ) 
		.catch( error => { 
			console.error( error ); 
		} );
	
</script>
</body>
</html>