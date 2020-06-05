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
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
<title>바우처 구매하기</title>
<style>	
.voucheraddbox{
	width:600px;
	margin:auto;
	border:0.5px solid;
	border-color: rgb(95, 0, 128);
	border-radius: 8px;
	padding:100px;
	text-align:center;
}
.voucherbuytable1 input{
	width:400px;
}
.voucherbuytable2 input{
	width:300px;
}
.voucherbuytable2 th{
	width:150px;
}
.voucherbuytable2 td{
	width:300px;
}
.btn{
  margin-top:20px;
  border: 2px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 14px 28px;
  font-size: 14px;
  cursor: pointer;
  width: 150px;
}
.btn:hover {
  background-color: rgb(95, 0, 128);
  color: white;
}
</style>
<script>
	function kakaopay() {
		location.href="kakaopay";
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
   
   	<div class="article">
   		<jsp:include page="sideMenu.jsp"></jsp:include>
		
	     <div id="main">
	     	<span style="font-size:20px;">바우처 구매하기</span>
	     	<div id="mypage_line_0">
			</div>
			<form action="voucherbuy" method="post" name="voucherbuy" class="voucheraddbox">
		    		<table class="voucherbuytable1">
		    		<tr>
		    			<th><h2 style="text-align:center;">구매정보</h2></th>
		    		</tr>
		    		<tr>
						<td><input type="text" value="${voucher.vname}" name="vname" readonly></td>
					</tr>
					<tr>
						<td><input type="text" value="${voucher.storename}" name="storename" readonly></td>
					</tr>
					<tr>
						<td><input type="text" value="${voucher.vprice}" name="vprice" class="inputbox" readonly></td>
					</tr>
					<tr>
						<td><input type="text" value="${voucher.vdate}" name="vdate" readonly></td>
					</tr>
					</table>
					<br>
					<table class="voucherbuytable2">
					<tr>
						<th colspan="2"><h2 style="text-align:center;">구매자 정보</h2></th>
					</tr>
					<tr>
						<th>구매자</th> 
						<td><input type="text" value="${member.mname}" name="mname" style="display:hidden;"></td>
					</tr>
					<tr>
						<th>이메일</th> 
						<td><input type="text" value="${member.memail}" name="memail" readonly></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" value="${member.mphone}" name="mphone" readonly></td>
					</tr>
					</table>
					<br><br><br>
					<input type="text" value="${member.mid}" name="mid" style="display:none;">
					<input type="submit" value="구매하기" class="btn">
			</form><br>
	     </div>
		
    </div>
    
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>