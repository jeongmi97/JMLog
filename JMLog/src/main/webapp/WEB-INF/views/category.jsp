<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<body>
<script type="text/javascript">

	$(function(){
		$('.add_order').click(function(){
			var $div = $('<div><input type="text" name="catename" required></input></div>');
			
			$('#addCate').append($div);
		});
		
		$('.saveBtn').click(function(){
			$('form').submit();
		});
	})
	
</script>

	<div class="set_order">
		<div class="list_order">
			<div>
				전체보기
			</div>
			<form id="addCate" method="post" action="">
				<input type="hidden" name="email" value="${login.email }">
			</form>
		</div>
		<div class="add_order">
			<label>
				카테고리 추가
				<input type="button" class="addBtn" value="카테고리 추가">
			</label>
		</div>
		<div>
			<button class="saveBtn">저장</button>
		</div>
	</div>

</body>
</html>