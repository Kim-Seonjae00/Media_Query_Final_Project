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
#voucherbox{
	padding-top:20px;
	padding-bottom:20px;
}
#voucherImg{
	width:800px;
	height:400px;
}
#voucherbox td{
	text-align:left;
	width:800px;
	height:50px;
	color:gray;
	font-weight:500; 
	font-size:15px;
	padding:15px;
}
#alert{
	background-color:rgb(243,243,243);
	padding:20px;
	border-radius:25px;
	text-align:center;
	font-weight:300;
}
#voucherbox th{
	width:800px;
}
.main{
	width:800px;
	text-align:left;
	margin:auto;
	background-color:white;
}
#voucherbox .price{
	font-size:25px;
	text-align:right;
	font-weight:700;
}
</style>

</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	
	<div class="article">
		<jsp:include page="sideMenu.jsp"></jsp:include>
		
		<div class="main">
			<span style="font-size: 20px;">요기서Deal</span>
			<div id="mypage_line_0"></div>
	     	<c:forEach var="voucherList" items="${voucherList}">
			<table id="voucherbox">
	     		<tr>
					<th><a href="voucherview?vname=${voucherList.vname}"><img src="resources/img/VoucherDP/${voucherList.vimg}" id="voucherImg"></a></th>
				</tr>
				<tr>
					<td>[ ${voucherList.storename} ]<br>
					${voucherList.vname}</td>
	     		</tr>
	     		<tr>
	     			<td class="price"> ￦ ${voucherList.vprice}</td>
	     		</tr>
	     		<tr>
	     			<td id="alert"> [ 본 바우처는 해당 매장에서만 사용이 가능합니다. ]</td>
	     		</tr>
	     	</table>
	     	</c:forEach>
	     	<br><br><br>
		</div>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>