<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<style type="text/css">
a { text-decoration: none; color: #000000; }

.profile {
	width: 40px;
	height: 40px;
	border-radius: 70%;	/* 테두리 원으로 */
	overflow: hidden;	/* 넘치는 부분 안보이게 */
}
.img {
	width: 100%;
	height: 100%;
	object-fit: cover;	 /* 비율 그대로 유지 */
}
.categorybox{
	margin: auto;
	margin-bottom: 5px;
	width: 300px;
	height: 30px;
}
#namebox{
	float: left;
}
#btnbox{
	float: right;
}
.addBtn{
	margin-bottom: 10px;
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<body>
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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
		var oldcate = catename;
		console.log('원래내용: ' + oldcate);
		console.log("수정내용 : " + updateCate);
		console.log('이메일 : ' + email);
		
		$.ajax({
			type:'GET',
			url: '${cpath}/setting/category/updateCategory?oldcate='+oldcate+'&idx='+idx+'&catename='+updateCate+'&email='+email,
			success: function(data){
				$('#cate' + idx).replaceWith('<div class="categorybox" id="cate'+idx+'"><span id="namebox">'+data+'</span><span id="btnbox"><button type="button" class="updateBtn" onclick="updateBtn('+idx+', '+catename+')">수정</button> <button type="button" class="deleteBtn" onclick="deleteBtn('+idx+')">삭제</button></span></div>')
			},
			error: function(error){
				console.log(error);
			}
		});
		
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

<header>
	<div class="container">
	<div class="row mt-2">
		<div class="col-md-8" style="margin-top: 10px"><h2><a href="${cpath }/">JMLog</a></h2></div>
		<c:choose>
			<c:when test="${not empty login }">		<!-- 로그인 되어있을 때 -->
				<div class="col-md-3 text-right" style="margin-top: 20px">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					<button type="button" class="btn btn-dark" style="margin-left: 5px; margin-right: 5px" onclick="location.href='${cpath}/write'">새글쓰기</button>
						
				</div>
				<div class="col-md-1 text-right" style="margin-top: 20px">
					<%-- <a href="#" class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" >Hello, ${login.nickname}! --%>
					<a href="#" class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" >
					<div class="profile" style="background: #BDBDBD; margin-right: 0px">
						<img class="img" src="${cpath }/${login.email}/getProfileImg">
					</div>
						<span class="caret"></span></a>
						<ul class="dropdown-menu justify-content-end" role="menu" aria-labelledby="dropdownMenu1">
							<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/${login.email}">내 로그</a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/setting">설정</a></li>
							<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/logout">로그아웃</a></li>
						</ul>
				</div>
			</c:when>
			<c:otherwise>	
				<div class="col-md-4 text-right" style="margin-top: 20px"><button type="button" class="btn btn-dark" onclick="location.href='${cpath}/login'">로그인</button></div>	<!-- 로그인 안 되어있을 때 -->
			</c:otherwise>
		</c:choose>
		
	</div>
	</div>
</header>

<nav>
<div class="container">
	<div class="row">
			<ol class="breadcrumb" style="margin-top: 20px; text-align: center">
				<li><a href="${cpath }/setting">프로필</a></li>
				<li><a href="${cpath }/setting/category">카테고리</a></li>
			</ol>
	</div>	
</div>
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
					<div class="categorybox" id="cate${category.idx }"><span id="namebox"><c:out value="${category.catename }" /></span><span id="btnbox"><button type="button" class="updateBtn btn btn-default btn-xs" onclick="updateBtn('${category.idx}', '${category.catename }')">수정</button> <button type="button" class="deleteBtn btn btn-default btn-xs" onclick="deleteBtn('${category.idx}')">삭제</button></span></div>
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