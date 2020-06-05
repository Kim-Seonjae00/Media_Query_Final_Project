<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function signOut() {
		location.href="logout";
	    var auth2 = gapi.auth2.getAuthInstance();
	    auth2.signOut().then(function () {
	      console.log('User signed out.');
	    });
	    auth2.disconnect();
	  }
	function searchFn() {
		var searchWord = document.getElementById("searchword").value;
		console.log(searchWord);
		location.href="searchmenu?searchWord="+searchWord;
	}

</script>
<style>
	.menu{
		margin-left: 400px;
		margin-right: 400px;
	}
	.menu a{
		text-align: center;
		width: 140px;
	    font-size: 20px;
	    font-weight: 600;
	    color: rgb(30, 30, 30);
	    display: inline-block;
	    margin: 20px;
	}
</style>
<style>
</style>
</head>
<body>
	<div class="topnav">
		<c:choose>
			<c:when test="${loginId eq null}">
        		<a href="memberjoinform"><div class="message">지금 가입하시고 5000원 할인쿠폰을 받아가세요! &nbsp;&nbsp; ></div></a>
        	</c:when>
        	<c:otherwise>
        		<a href="recommendlist"><div class="message">첫 주문하시고 5000원 할인쿠폰을 받아가세요! &nbsp;&nbsp; ></div></a>
        	</c:otherwise>
        </c:choose>
		    <div class="menu">
	            <a href="recommendlist" id="header1">맛집</a>
	            <a href="voucherlist?loginId=${sessionScope.loginId}" id="header1">요기서 Deal</a>			
	            <a href="main"><img src="resources/img/logo/로고2.png" id="logo"></a>
	            <c:choose>
	            	<c:when test="${loginId eq null}">
	            		<a href="memberloginform" id="header2">로그인</a>
	            		<a href="memberjoinform" id="header2">회원가입</a>
	            	</c:when>
	            	<c:when test="${loginId eq 'admin'}">
	            		<a href="memberlist?loginId=${sessionScope.loginId}" id="header2">관리자 페이지</a>
	            		<a href="#" onclick="signOut();" id="header2">로그아웃</a>
	            	</c:when>
	            	<c:when test="${loginId ne null}">
	            		<a href="myorderslist?mid=${sessionScope.loginId}" id="header2">마이페이지</a>
	            		<a href="#" onclick="signOut();" id="header2">로그아웃</a>
	            	</c:when>
	            </c:choose>
        	</div>
    </div>

    <div class="search">
        <input type="text" id="searchword" placeholder="먹고 싶은 메뉴 검색">
        <button onclick="searchFn()" id="searchbtn"><i class="fas fa-search"></i></button>
    </div>
</body>
</html>