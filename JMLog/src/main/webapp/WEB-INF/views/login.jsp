<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<div class="container center_div">
	<div class="row">
	<div class="col-sm-6 col-sm-offset-3">
	<form method="post" class="form-horizontal">
		<div class="form-group">
			<div class="row">
				<label for="email" class="col-sm-2 control-label ">이메일</label>
				<div class="col-xs-4">
      				<input type="email" class="form-control" name="email" id="email" placeholder="example@naver.com">
    			</div>
    		</div>
    	</div>
    	<div class="form-group">
    		<div class="row">
    			<label for="password" class="col-sm-2 control-label">비밀번호</label>
    			<div class="col-xs-4">
      				<input type="password" class="form-control" name="pw" id="password" placeholder="********">
    			</div>
    		</div>
  		</div>
  		<div class="form-group">
    		<div class="col-sm-offset-2 col-sm-10">
      			<div class="checkbox">
        			<label>
          				<input type="checkbox"> Remember me
        			</label>
      			</div>
    		</div>
  		</div>
  		<div class="form-group">
    		<div class="col-sm-offset-2 col-sm-10">
      			<button type="submit" class="btn btn-default">로그인</button>
    		</div>
  		</div>
		<div>
			<a>비밀번호 찾기</a>
		</div>
	</form>
	
	아직 회원이 아니신가요?<a href="${cpath }/join">회원가입</a>
	</div>
	</div>
</div>
</body>
</html>