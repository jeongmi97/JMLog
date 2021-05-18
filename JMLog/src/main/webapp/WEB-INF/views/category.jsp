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
		if(!'${category}' || orderArr<1){ // 카테고리 아무 것도 없을 때 or 생성된 카테고리 div 아무것도 없을 때
			console.log('없다아앙');
			$('.saveBtn').prop("disabled",true);	// 저장버튼 비활성화
		}
		
		// 카테고리 행 추가
		$('.add_order').click(function(){
			// <div><input></div> 태그 생성
			var $div = $('<div><input type="text" name="catename" value=""><button type="button" class="cancelBtn">취소</button></div>');
			
			$('#addCate').append($div);	// addCate란 id를 가진 폼에 태그 추가
			$('.saveBtn').prop("disabled",false);	// 카테고리 폼 저장 버튼 활성화
			
		});
		
		// 카테고리 행 삭제
		$(document).on('click','.cancelBtn', function(){	// 취소 버튼 클릭 시
			$(this).parent().remove();			// this(취소 버튼)의 부모요소인 div(해당 행) 삭제
			orderArr = $('input[name=catename]').length;			// input 개수 확인
			if(orderArr==0) $('.saveBtn').prop("disabled",true);	// 모든 행 삭제 시 카테고리 폼 저장 버튼 비활성화
		});
		
		// 생성 된 카테고리 폼 전송
		$('.saveBtn').click(function(){
			console.log('들어옴 : ' + $('input[name=catename]').length);
			orderArr = $('input[name=catename]').length;
			var checkNull = false;		// input의 value값 비어져있는지 체크용
			$('input[name=catename]').each(function(idx){			// input 개수만큼 반복
				if(!$('input[name=catename]:eq('+idx+')').val()){	// input 값 비워져 있으면
					alert('카테고리명을 입력해 주세요!');					// 알림창 나타냄
					checkNull = true;								// 널체크 true 넣기
					return false;									// 반복문 종료
				}
			});
			if(checkNull != true && orderArr>=1)	// input이 1개이상 있고 널값을 가지지 않을 때
				$('form').submit();					// 폼 제출
		});
		
		
	});
	
	// 수정버튼 클릭 -> 수정모드 
	function updateBtn(idx, catename){
		console.log("수정버튼 : " + idx);
		console.log("카테고리 : " + catename);
		var catename = catename;
		// div만 있던 해당 카테고리 행을 input이 추가된 div로 바꾸기
		$('#cate' + idx).replaceWith('<div id="cate'+idx+'"><input type="text" name="cate'+idx+'" value="'+catename+'"><button type="button" onclick="cancelUpdate('+idx+','+catename+')">취소</button><button type="button" onclick="update('+idx+','+catename+')">확인</button></div>')
		
		
	};
	
	// 수정모드 -> 취소
	function cancelUpdate(idx,catename){
		// input이 있는 div 다시 원래 div로 바꾸기
		$('#cate' + idx).replaceWith('<div id="cate'+idx+'">'+catename+'<button type="button" class="updateBtn" onclick="updateBtn('+idx+', '+catename+')">수정</button><button type="button" class="deleteBtn" onclick="deleteBtn('+idx+')">삭제</button></div>')
	}
	
	// 수정모드 -> 저장
	function update(idx, catename){
		updateCate = $('input[name=cate'+idx+']').val();
		console.log("수정내용 : " + updateCate);
		var paramData = JSON.stringify({
			"idx": idx,
			"catename": updateCate
		});
		
		var headers = {"Content-Type": "application/json"
					,"X-HTTP-Method-Override": "POST"};
		
		$.ajax({
			type:'POST',
			url: '${cpath}/setting/category/updateCategory',
			headers: headers,
			data: paramData,
			contentType: "application/json",
			success: function(data){
				$('#cate' + idx).replaceWith('<div id="cate'+idx+'">'+data+'<button type="button" class="updateBtn" onclick="updateBtn('+idx+', '+catename+')">수정</button><button type="button" class="deleteBtn" onclick="deleteBtn('+idx+')">삭제</button></div>')
			},
			error: function(error){
				console.log(error);
			}
		})
		
	}
	
	// 카테고리 삭제
	function deleteBtn(idx){
		console.log("삭제버튼 : " + idx);
		
		$.ajax({
			type: 'GET',
			url: '${cpath}/setting/category/delCategory?idx=' + idx,
			success: function(data){
				$('div').remove('#cate' + idx);
			},
			error: function(error){
				console.log(error);
			}
		});
	};
	
	
</script>

	<div class="set_order">
		<div class="list_order">
			<div>
				전체보기
			</div>
			<form id="addCate" method="post" action="">
				<input type="hidden" name="email" value="${login.email }">
				<c:forEach var="category" items="${category }">
					<div id="cate${category.idx }">${category.catename }<button type="button" class="updateBtn" onclick="updateBtn('${category.idx}', '${category.catename }')">수정</button><button type="button" class="deleteBtn" onclick="deleteBtn('${category.idx}')">삭제</button></div>
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