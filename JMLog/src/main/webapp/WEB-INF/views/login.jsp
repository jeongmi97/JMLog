<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

------------login------------

<form method="post">
	이메일<div><input type="text" name="email" placeholder="example@naver.com"></div>
	비밀번호<div><input type="password" name="pw" placeholder="********"></div>
	<div>
		<a>비밀번호 찾기</a>
	</div>
	<input type="submit" value="로그인">
</form>
<P><a href="${cpath }/join">회원가입하러가기</a></P>

</body>
</html>