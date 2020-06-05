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
</style>
</head>
<body>
	 <div id="sideNav">
	     	<span style="font-size:20px;">ADMIN PAGE</span>
	     	<div id="mypage_line_0"></div>
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>회원관리</td></tr>
		     	<tr><td>&emsp;<a href="memberlist?loginId=${sessionScope.loginId}" class="navList">회원목록</a></td></tr>
		     	<tr><td>&emsp;<a href="memberblacklist?loginId=${sessionScope.loginId}" class="navList">블랙리스트</a></td></tr>
	     	</table>
	     	
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>업체관리</td></tr>
		     	<tr><td>&emsp;<a href="adminstorelist?loginId=${sessionScope.loginId}" class="navList">업체목록</a></td></tr>
		     	<tr><td>&emsp;<a href="storeaddlist?loginId=${sessionScope.loginId}" class="navList">음식점신청리스트</a></td></tr>
		     	<tr><td>&emsp;<a href="storeblacklist?loginId=${sessionScope.loginId}" class="navList">블랙리스트</a></td></tr>
	     	</table>
	     	
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>리뷰관리</td></tr>
		     	<tr><td>&emsp;<a href="reportreviewlist?loginId=${sessionScope.loginId}" class="navList">신고리뷰목록</a></td></tr>
	     	</table>
	     	
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>공지사항관리</td></tr>
		     	<tr><td>&emsp;<a href="adminnoticelist?loginId=${sessionScope.loginId}" class="navList">공지사항목록</a></td></tr>
		     	<tr><td>&emsp;<a href="noticeform?loginId=${sessionScope.loginId}" class="navList">공지사항등록</a></td></tr>
	     	</table>
	     	
	     	<table class="sideNav_list">
		     	<tr class="sideNav_list_category"><td>바우처관리</td></tr>
		     	<tr><td>&emsp;<a href="adminvoucherlist?loginId=${sessionScope.loginId}" class="navList">바우처목록</a></td></tr>
		     	<tr><td>&emsp;<a href="voucheraddform?loginId=${sessionScope.loginId}" class="navList">바우처등록</a></td></tr>
	     	</table>
	     	
	     </div>
</body>
</html>