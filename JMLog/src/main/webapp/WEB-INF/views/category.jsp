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
		
		var orderArr = $('input[name="catename"]').length;
		// 카테고리 폼 저장 비활성화
		if(orderArr="undefiend"){ // 생성된 카테고리 div 아무것도 없을 때
			console.log('없다아앙');
			$('.saveBtn').prop("disabled",true);
		}
		
		/* $(document).on('DOMNodeInserted','form',function(){
			if(orderArr="undefiend"){
				$('.saveBtn').prop("disabled",true);
			}
			else{
				$('.saveBtn').prop("disabled",false);
			}
		}); */
		
		// 카테고리 행 추가/삭제
		$('.add_order').click(function(){
			var $div = $('<div><input type="text" "name="catename"><button class="cancelBtn">취소</button></div>');
			
			$('#addCate').append($div);	// addCate란 id를 가진 폼에 태그 추가
			$('.saveBtn').prop("disabled",false);	// 카테고리 폼 저장 버튼 활성화
			
			$('.cancelBtn').on('click', function(){	// 취소 버튼 클릭 시
				$(this).parent().remove();			// this(취소 버튼)의 부모요소인 div(해당 행) 삭제
				if(orderArr="undefiend") $('.saveBtn').prop("disabled",true);	//모든 행 삭제 시 카테고리 폼 저장 버튼 비활성화
			});
		});
		
		// 생성 된 카테고리 폼 전송
		$('.saveBtn').click(function(){
			console.log('들어옴');
			var orders = new Array(orderArr);
			orders = $('input[name="catename"]').values;
			console.log('orders1 : ' + oreders[0]);
			for(var i=0; i<orderArr; i++){
				if(!orders[i])
					alert('카테고리명을 입력해 주세요!');
				else
					$('form').submit();
			}
			
		/* 	else if(orderArr != 0){
				var orders = new Array(orderArr);
				for(var i=0; i<orders; i++){
					orders[i] = 
				}
				$('form').submit();
			}
			else{
				console.log("000000000");
			} */
			
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