<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	#storeConfirm:hover{
		color:rgb(255, 122, 107);
	}
	</style>
</head>

<body>
<div id="sideNav">
	     	<span style="font-size:20px;">STORE PAGE</span>
	     	<div id="mypage_line_0"></div>
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>가게 주문 정보</td></tr>
		     	<tr><td>&emsp;<a href="storepage?sid=${sessionScope.storeId}" class="navList">가게 주문내역</a></td></tr>
		     	<tr><td>&emsp;<a href="storebookinglist?sid=${sessionScope.storeId}" class="navList">가게 예약내역</a></td></tr>
	     	</table>
	     	
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>가게 리뷰 정보</td></tr>
		     	<tr><td><a href="storereviewlist?sid=${sessionScope.storeId}" class="navList">&emsp;가게 리뷰 내역</a></td></tr>
	     	</table>
	     	
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>가게 메뉴 관리</td></tr>
		     	<tr><td><a href="menulist?sid=${sessionScope.storeId}" class="navList">&emsp;가게 메뉴 내역</a></td></tr>
	     	</table>
	     	
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>가게 정보</td></tr>
		     	<tr><td><a href="storemodifyform?sid=${sessionScope.storeId}" class="navList">&emsp;가게 정보수정</a></td></tr>
		     	<tr><td><a href="storedeleteform?sid=${sessionScope.storeId}" class="navList">&emsp;회원탈퇴</a></td></tr>
	     	</table>
	     	
		     <a href="storeconfirmform?sid=${sessionScope.storeId}" id="storeConfirm">음식점 등록 신청</a>
		     <div style="height:40px;"></div>
	     	
	     </div>
</body>
</html>
