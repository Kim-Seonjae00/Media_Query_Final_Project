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
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/mypage.css">

<style>
	#couponList th{
		padding : 10px;
		text-align: left;
	}
	#couponList td{
		font-weight: 300;
		padding : 10px;
		text-align: left;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../memberProfile.jsp"></jsp:include>
	
	<div class="article">
	
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	    <jsp:include page="../memberSideNav.jsp"></jsp:include>
	     
	     <div id="main">
	     	<span style="font-size:20px;">쿠폰목록</span>
	     	<div id="mypage_line_0"></div>
	     		<div id="couponList">
	     			<c:forEach var="coupon" items="${couponList}">
	     			<table style="margin-left: auto; margin-right: auto; border: 1px solid #eee; margin: 10px;">
	     			<tr>
	     				<th colspan="2" style="background-color: #eee;">[${coupon.couponnum}] ${coupon.couponname}</th>
	     			</tr>
	     			<tr>
	     				<th>사용가능 금액</th>
	     				<td>제한 없음</td>
	     			</tr>
						<th>할인금액</th>
						<td>${coupon.discount} 원</td>
	     			<tr>
	     				<th>사용기간</th>
	     				<td>${coupon.issuedate} ~ ${coupon.enddate}
	     			</tr>
	     			</table>
	     			</c:forEach>
				</div>
	     	</div>
		</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>