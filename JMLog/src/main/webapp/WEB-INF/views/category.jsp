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
		
		var orderArr = $('#catename').length;
		// 카테고리 폼 저장 비활성화
		if(!'${category}'){ // 생성된 카테고리 div 아무것도 없을 때
			console.log('없다아앙');
			$('.saveBtn').prop("disabled",true);
		}
		
		// 카테고리 행 추가
		$('.add_order').click(function(){
			var $div = $('<div><input type="text" name="catename" value=""><button class="cancelBtn">취소</button></div>');
			
			$('#addCate').append($div);	// addCate란 id를 가진 폼에 태그 추가
			$('.saveBtn').prop("disabled",false);	// 카테고리 폼 저장 버튼 활성화
			
		});
		
		// 카테고리 행 삭제
		$('.cancelBtn').on('click', function(){	// 취소 버튼 클릭 시
			$(this).parent().remove();			// this(취소 버튼)의 부모요소인 div(해당 행) 삭제
			orderArr = $('input[name=catename]').length;
			if(orderArr==0) $('.saveBtn').prop("disabled",true);	//모든 행 삭제 시 카테고리 폼 저장 버튼 비활성화
		});
		
		// 생성 된 카테고리 폼 전송
		$('.saveBtn').click(function(){
			console.log('들어옴 : ' + $('input[name=catename]').length);
			var checkNull = false;
			$('input[name=catename]').each(function(idx){
				if(!$('input[name=catename]:eq('+idx+')').val()){
					alert('카테고리명을 입력해 주세요!');
					checkNull = true;
					return false;
				}
			});
			if(checkNull != true)
				$('form').submit();
		});
		
		$('.deleteBtn').click(function(){
			
		});
		
	});
	
	
	
</script>

	<div class="set_order">
		<div class="list_order">
			<div>
				전체보기
			</div>
			<form id="addCate" method="post" action="">
				<input type="hidden" name="email" value="${login.email }">
				<c:forEach var="category" items="${category }">
					<div>${category.catename }<button class="updateBtn">수정</button><button class="deleteBtn">삭제</button></div>
				</c:forEach>
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