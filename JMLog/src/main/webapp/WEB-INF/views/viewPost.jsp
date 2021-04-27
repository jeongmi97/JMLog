<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	포스트화면<br>
	${post.title }<br>
	${post.content }<br>
	<div>
		<div><span>${post.email }</span><span> | </span><span>${post.reporting_date }</span><span> |</span></div>
		<div><span><a href="">수정</a></span> | <span><a href="">삭제</a></span></div>
	</div>
</body>
</html>