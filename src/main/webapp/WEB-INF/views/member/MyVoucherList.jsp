<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	#voucherList td{
		padding : 20px;
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
	     	<span style="font-size:20px;">바우처 구매내역</span>
	     	<div id="mypage_line_0"></div>
	     		<div id="voucherList">
	     			<table style="margin-left: auto; margin-right: auto">
		     			
		     			<c:forEach var="voucher" items="${voucherList}">
		     			<tr>
		     				<td>${voucher.vnum}</td>
		     				<td>${voucher.storename}</td>
		     				<td><a href="myvoucherview?vnum=${voucher.vnum}&mid=${sessionScope.loginId}">${voucher.vname}</a></td>
		     				<td>${voucher.vprice} 원</td>
		     				<td>${fn:substring(voucher.vdate,0,10)}까지</td>
		     			</tr>
		     			</c:forEach>
	     			</table>
				</div>
     	</div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>