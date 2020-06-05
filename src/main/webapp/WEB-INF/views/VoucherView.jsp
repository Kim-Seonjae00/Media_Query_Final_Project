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
.main{
	width:800px;
	text-align:left;
	margin:auto;
	background-color:white;
}

#voucherImg{
	width:800px;
	height:400px;
}
#voucherbox td{
	width:800px;
	height:50px;
	border:none;
	font-weight:500;
	text-align:left;
	padding:20px;
}
#voucherbox{
	padding-top:100px;
	padding-bottom:100px;
}
.btn{
  width:800px;
  height:60px;
  border: 2px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 14px 28px;
  font-size: 20px;
  cursor: pointer;
}
.btn:hover {
  background-color: rgb(95, 0, 128);
  color: white;
}
#voucherbox .price{
	font-size:25px;
	text-align:right;
	font-weight:700;
	border-bottom: 0.6px solid lightgray;
}
#voucherdesc{
	width:760px;
	height:auto;
}
</style>
<script>
	function voucherbuy(vname) {
		if('${sessionScope.loginId}' == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href="memberloginform";
		} else {			
			location.href="voucherbuyform?vname="+vname+"&loginId=${sessionScope.loginId}"
		}
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	
	<div class="article">
		<jsp:include page="sideMenu.jsp"></jsp:include>
		
		<div class="main">
			<span style="font-size: 20px;">요기서 Deal</span>
			<div id="mypage_line_0"></div>
			<table id="voucherbox">	
	     		<tr>
					<th><img src="resources/img/VoucherDP/${voucher.vimg}" id="voucherImg"></th>
				</tr>
				<tr>
					<td>[ ${voucher.storename} ]<br>
					${voucher.vname}</td>
	     		</tr>
	     		<tr>
	     			<td class="price"> ￦ ${voucher.vprice}</td>
	     		</tr>
	     		<tr>
	     			<td><img src="resources/img/VoucherDP/바우처설명.png" id="voucherdesc"></td>
	     		</tr>
	     		<tr>
					<th><button onclick="voucherbuy('${voucher.vname}')" class="btn">구매하기</button></th>
				</tr>
	     	</table>
		</div>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>