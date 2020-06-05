<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.navList{
		font-weight: 400;
	}
	.navList:hover{
		color: gray;
		font-size: 18px;
	}
</style>
</head>
<body>
	<div id="sideNav">
	     	<span style="font-size:20px;">MY PAGE</span>
	     	<div id="mypage_line_0"></div>
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>나의 주문 정보</td></tr>
		     	<tr><td>&emsp;<a href="myorderslist?mid=${sessionScope.loginId}" class="navList">주문내역</a></td></tr>
		     	<tr><td>&emsp;<a href="mybookinglist?mid=${sessionScope.loginId}" class="navList">예약내역</a></td></tr>
		     	<tr><td>&emsp;<a href="myvoucherlist?mid=${sessionScope.loginId}" class="navList">바우처 구매내역</a></td></tr>
	     	</table>
	     	
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>나의 쿠폰</td></tr>
		     	<tr><td><a href="couponlist?mid=${sessionScope.loginId}" class="navList">&emsp;쿠폰목록</a></td></tr>
	     	</table>
	     	
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>나의 회원정보</td></tr>
		     	<tr><td><a href="membermodify?mid=${sessionScope.loginId}" class="navList">&emsp;회원정보 수정</a></td></tr>
		     	<tr><td><a href="myaddresslist?mid=${sessionScope.loginId}" class="navList">&emsp;배달 주소록</a></td></tr>
		     	<tr><td><a href="myreviewlist?mid=${sessionScope.loginId}" class="navList">&emsp;리뷰내역</a></td></tr>
		     	<tr><td><a href="memberdeleteform?mid=${sessionScope.loginId}" class="navList">&emsp;회원탈퇴</a></td></tr>
	     	</table>
	     </div>
</body>
</html>