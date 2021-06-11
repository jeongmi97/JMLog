<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/navStyle.css">
<style type="text/css">
.categorybox{
	margin: auto;
	margin-bottom: 5px;
	width: 300px;
	height: 30px;
}
#namebox{ float: left; }
#btnbox{ float: right; }
.addBtn{ margin-bottom: 10px; }
</style>
</head>
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
		$('#cate' + idx).replaceWith('<div class="categorybox" id="cate'+idx+'"><span id="namebox"><input type="text" name="cate'+idx+'" value="'+catename+'"></span><span id="btnbox"><button class="btn btn-default btn-xs" type="button" onclick="cancelUpdate('+idx+','+catename+')">취소</button> <button class="btn btn-default btn-xs" type="button" onclick="update('+idx+','+catename+')">확인</button></span></div>')
		
		
	};
	
	// 수정모드 -> 취소
	function cancelUpdate(idx,catename){
		// input이 있는 div 다시 원래 div로 바꾸기
		$('#cate' + idx).replaceWith('<div class="categorybox" id="cate'+idx+'"><span id="namebox">'+catename+'</span><span id="btnbox"><button type="button" class="updateBtn btn btn-default btn-xs" onclick="updateBtn('+idx+', '+catename+')">수정</button> <button type="button" class="deleteBtn btn btn-default btn-xs" onclick="deleteBtn('+idx+')">삭제</button></span></div>')
	}
	
	// 수정모드 -> 저장
	function update(idx, catename){
		var email = '${login.email}';
		var updateCate = $('input[name=cate'+idx+']').val();
		console.log("수정내용 : " + updateCate);
		console.log('이메일 : ' + email);
		
		var param = JSON.stringify({
			"oldcate": catename,
			"idx": idx,
			"catename": updateCate,
			"email": email
		});
		
		var headers = {"Content-Type" : "application/json"
			, "X-HTTP-Method-Override" : "POST"};
		
		$.ajax({
			type:'POST',
			url: '${cpath}/setting/category/updateCategory',
			data: param,
			headers: headers,
			contentType: 'application/json',
			success: function(data){
				$('#cate' + idx).replaceWith('<div class="categorybox" id="cate'+idx+'"><span id="namebox">'+data+'</span><span id="btnbox"><button type="button" class="updateBtn" onclick="updateBtn('+idx+', '+catename+')">수정</button> <button type="button" class="deleteBtn" onclick="deleteBtn('+idx+')">삭제</button></span></div>')
			},
			error: function(error){
				console.log(error);
			}
		});
		
	}
	
	// 카테고리 삭제
	function deleteBtn(idx, catename){
		console.log("삭제버튼 : " + idx);
		var email = '${login.email}';
		
		var param = JSON.stringify({
			"idx": idx,
			"cate": catename,
			"email": email
		});
		
		var headers = {"Content-Type" : "application/json"
			, "X-HTTP-Method-Override" : "POST"};
		
		$.ajax({
			type: 'POST',
			url: '${cpath}/setting/category/delCategory',
			data: param,
			headers: headers,
			contentType: 'application/json',
			success: function(data){
				$('div').remove('#cate' + idx);
			},
			error: function(error){
				console.log(error);
			}
		});
	};
	
	
</script>

<header>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>

<nav>
	<%@ include file="/WEB-INF/views/include/settingNav.jsp" %>
</nav>
<div class="container">
	<div class="set_order" style="text-align: center;">
		<div class="list_order">
			<div class="categorybox">
				분류 전체보기
			</div>
			<form id="addCate" method="post" action="">
				<input type="hidden" name="email" value="${login.email }">
				<c:forEach var="category" items="${category }">
					<div class="categorybox" id="cate${category.idx }"><span id="namebox"><c:out value="${category.catename }" /></span><span id="btnbox"><button type="button" class="updateBtn btn btn-default btn-xs" onclick="updateBtn('${category.idx}', '${category.catename }')">수정</button> <button type="button" class="deleteBtn btn btn-default btn-xs" onclick="deleteBtn('${category.idx}','${category.catename }')">삭제</button></span></div>
				</c:forEach>
			</form>
		</div>
		<div class="add_order">
			<input type="button" class="addBtn btn btn-default" value="카테고리 추가">
		</div>
		<div>
			<button class="saveBtn btn btn-default">저장</button>
		</div>
	</div>
</div>
</body>
</html>