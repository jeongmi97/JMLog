<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	header#header { width:1700px; margin:0 auto; background: #fdd; }
	div#wrap { width:1200px; margin:0 auto; background:#ddd; }
	nav#nav { background: #dfd; }
	section#container { background: #ddf; }
		div.content { background: #eee; }
		aside#aside { background: #fff; }
	footer#footer { background: #ffe; }
	
	div#warp, header#header, nav#nav,
    section#container, div.content, aside#aside,
    footer#footer { padding:10px; }
    
    nav#nav ul { margin:0; padding:0; list-style:none; }
    nav#nav ul li { background:#eee; padding:10px; display:inline-block; }
    
    div.content { width: 850px; float:right; }
    aside#aside { width: 270px; float:left; }
    
    section#container::after { content:""; display:block; clear:both; }
    
    @media screen and (max-width: 910px){
    	div#wrap { width:calc(100% - 20px); }
    	div.content { width:clac(100% - 20px - 240px - 20px); }
    	aside#aside { width:220px; }
    }
    
    @media screen and (max-width: 650px) {
    	div.content,
    	aside#aside { width:calc(100% - 20px); float:none; }
	}
    
</style>
</head>
<body>

<header id="header">
	<c:out value="${user.nickname }"/>.Log
</header>
<div id="wrap">

<nav id="nav">
	<ul>
		<li>글</li>
		<li>방명록</li>
		<li>소개</li>
	</ul>
</nav>

<section id="container">
	<div class="content">
		본문
	</div>
	<aside id="aside">
		전체보기
	</aside>
</section>

<footer id="footer">
	footer
</footer>

</div>

</body>
</html>