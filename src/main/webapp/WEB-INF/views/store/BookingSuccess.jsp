<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/mypage.css">
<link rel="stylesheet" href="resources/css/storeview.css">
    <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">
<script>
	function goMain(){
		location.href="main";
	}
	function bookingList(){
		location.href="mybookinglist?mid=${sessionScope.loginId}"
	}
</script>
<style>
	#bookingSuccess{
		padding: 20px;
	}
</style>

</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
    
    <div id="top_profile" style="margin-bottom:30px;">
		<div id="top_profile_img"><!--프로필 사진 -->
			<c:choose>
				<c:when test="${store.simg ne null}">
					<img src="resources/img/Profile/${store.simg}" id="profileImg">
				</c:when>
				<c:otherwise>
					<img src="resources/img/logo/로고2.png" id="profileImg">
				</c:otherwise>
			</c:choose>
		</div>
		
		<div id="top_profile_contents"><!--프로필 내용-->
			<span style="font-size: 35px; font-weight:500;">${store.storename}</span>
			<span style="color:gray;">${store.scategory}</span><br>
			<div style="text-align:left; margin-top:10px; font-weight:400">
				<span style="color:gray;">연락처</span> ${store.sphone}<br>
				<span style="color:gray;">주소</span> ${store.spostcode} ${store.sadrs1} ${store.sadrs2} ${store.sadrs3} ${store.sadrs4}<br>
				<span style="color:gray;">최소주문금액</span> 15,000원<br>
				<span style="color:gray;">배달예상시간</span>
			</div> 
		</div>
	</div>
	<div id="bookingSuccess">
		<h2>'${store.storename}' 의 예약이 완료되었습니다.</h2>
		<button onclick="goMain()">홈으로</button>
		<button onclick="bookingList()" id="bookingBtn">예약내역</button>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>