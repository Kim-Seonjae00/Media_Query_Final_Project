<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/adminpage.css">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;500;700&display=swap" rel="stylesheet">
<title>Insert title here</title>
<style>
#profilebox td{
	width:200px;
	font-weight:300;
	padding-top:5px;
	padding-bottom:5px;
	border-top:0.7px solid lightgray;
}
#profilebox th{
	width:200px;
	padding-bottom:20px;
}
#profile{
	width:80px;
	height:80px;
}
.btn{
  border-radius:20px;
  border: 1.3px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
.btn:hover {
  border-radius:20px;
  border: 1.3px solid;
  background-color: rgb(95, 0, 128);
  color: white;
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
#profileimg{
	width:180px;
	height:150px;
}
</style>
<script>
	function voucherdelete(vnum) {
		location.href="voucherdelete?vnum="+vnum+"&loginId=${sessionScope.loginId}";
	}
</script>
</head>
<body>
	<jsp:include page="../adminProfile.jsp"></jsp:include>
	
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
		<jsp:include page="../adminSideNav.jsp"></jsp:include>
		<div id="main">
			<span style="font-size: 20px;">바우처 목록</span>
			<div id="mypage_line_0"></div>
			<table id="profilebox">
	     		<tr>
	     			<th style="width:200px;">DP이미지</th><th>일련번호</th><th>업체명</th><th>사용기한</th><th>가격</th><th>삭제</th>
	     		</tr>
	     	<c:forEach var="voucherList" items="${voucherList}">
	     		<tr>
					<td><img src="resources/img/VoucherDP/${voucherList.vimg}" id="profileimg"></td>
	     			<td>${voucherList.vnum}</td>
	     			<td>${voucherList.storename}</td>
	     			<td>${voucherList.vdate}</td>
	     			<td>${voucherList.vprice}원</td>
	     			<td><button onclick="voucherdelete('${voucherList.vnum}')" class="btn">삭제</button></td>
	     		</tr>
	     	</c:forEach>
	     	</table>
		</div>
	</div>

	
</body>
</html>