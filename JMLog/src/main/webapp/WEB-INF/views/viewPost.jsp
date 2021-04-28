<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.title }</title>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<body>
<script type="text/javascript">
	
	$(function(){
		$(btnDel).click(function(){
			var idx = '<c:out value="${post.idx}"/>';
			
			var chk = confirm('삭제하시겠습니까?');
			if(chk) location.href="${cpath}/delPost/"+idx;
		})
	});
	
</script>

	포스트화면<br>
	${post.title }<br>
	${post.content }<br>
	<div>
		<div><span>${post.email }</span><span> | </span><span>${post.reporting_date }</span><span> |</span></div>
		<div><span><a href="${cpath }/editPost?idx=${post.idx}&mode=edit">수정</a></span> | <span><input type="button" value="삭제" id="btnDel"></span></div>
	</div>
</body>
</html>