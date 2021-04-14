<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
</head>
<body>
글쓰기=============

<form method="post">
	<label for="title">제목</label><input type="text" name="title" /><br>
	<label for="content">내용</label><textarea name="content"></textarea><br>
	
	<input type="submit" value="작성하기">
</form>
</body>
</html>