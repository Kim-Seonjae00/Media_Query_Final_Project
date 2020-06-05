<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/qrcode/jquery.min.js"></script>
<script type="text/javascript" src="resources/qrcode/qrcode.js"></script>
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
	.voucherqr{
		border: 1px solid #ddd;
		width: 300px;
		padding: 20px;
		margin-left: auto;
		margin-right: auto;
		text-align: center;
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
	     	<span style="font-size:20px;">바우처 상세조회</span>
	     	<div id="mypage_line_0"></div>
			   
			   
			    <div class="voucherqr">
					<table style="margin-left: auto; margin-right: auto">
						<tr>
							<td id="qrcode"></td>
						</tr>
		     			<tr>
		     				<td>${voucher.vnum}</td>
		     			</tr>
		     			<tr>
		     				<td>${voucher.storename}</td>
		     			</tr>
		     			<tr>
		     				<td>${voucher.vname}</td>
		     			</tr>
		     			<tr>
		     				<td>${voucher.vprice} 원</td>
		     			</tr>
		     			<tr>
		     				<td>${fn:substring(voucher.vdate,0,10)}까지</td>
		     			</tr>
			     	</table>
		    	</div>
    	</div>
    </div>
   	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>

<script type="text/javascript">
    var qrcode = new QRCode(document.getElementById("qrcode"), {
        text: "${voucher.vnum}",
        width: 128,
        height: 128,
        colorDark : "#000000",
        colorLight : "#ffffff",
        correctLevel : QRCode.CorrectLevel.H
    });
</script>
</html>