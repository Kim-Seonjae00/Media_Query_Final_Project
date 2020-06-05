<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/cd5c7a4640.js"
	crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap"rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
	
</head>
<body >
	<div id="top_profile">
		<div id="top_profile_img">
			<c:choose>
				<c:when test="${member.mimg ne null}"><img src="resources/img/Profile/${member.mimg}" id="profileImg"></c:when>
				<c:when test="${member.mimg eq null}"><img src="resources/img/logo/로고2.png" id="profileImg"></c:when>
			</c:choose>
		</div>
		
		<div id="top_profile_contents" style="text-align:left;">
			<span style="font-size: 35px; font-weight:500;">${member.mnickname}님</span>
			${member.mgrade}<br><br>
			<table id="top_profile_contents_table">
				<tr id="on">
					<td>주문내역</td>
					<td>총 주문금액</td>
					<td>포인트</td>
					<td>쿠폰</td>
				</tr>
				<tr id="under">
					<td>${ordersCount}</td>
					<td>${member.mtotalprice} 원</td>
					<td>${member.mpoint} P</td>
					<td>${couponCount}</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>