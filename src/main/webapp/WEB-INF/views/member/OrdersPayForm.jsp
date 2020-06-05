<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script>
function onloadFn(){
	setAddressFn();
	locationFn();
}

function setAddressFn(){
	address = $(":input:radio[name=oaddress]:checked").val();
	
	addressList = address.split(" ");
	address = addressList[1]+" "+addressList[2]+" "+addressList[3];
	$("#searchAddress1").val(address);
}


function pointCheck(){
	var inputPoint = parseInt($("#usePoint").val());
	var maxPoint = parseInt('${member.mpoint}');
	if(inputPoint > maxPoint){
		$("#usePoint").val(maxPoint);
	}else if(inputPoint<0){
		$("#usePoint").val(0);
	}
}

function pointAllUse(){
	var point = '${member.mpoint}';
	var ototalprice=$("#ototalprice").val();
	console.log(ototalprice);
	console.log(point);
	if(parseInt(point)>parseInt(ototalprice)){
		$("#usePoint").val(ototalprice-5000);
	}else{
		$("#usePoint").val(point);
	}
}

function setFinalPrice(){
	var point = $("#usePoint").val();
	var price = $("#price").val();
	var couponNum=$("#useCoupon").val();
	var coupon=$("#discount"+couponNum).val();
	
	if(coupon == null){
		coupon = 0;
	}
	
	var paymentPrice = price-point-coupon;
	
	
	
	$("#ototalprice").val(paymentPrice);
	$("#point").val(point);
	$("#coupon").val(coupon);
}

function goPayment(){
	if(confirm("결제하시겠습니까?")){
		var distance = getDistanceFromLatLonInKm(document.getElementById("addressX0").value,document.getElementById("addressY0").value,document.getElementById("addressX1").value,document.getElementById("addressY1").value);
		alert("결제가 완료되었습니다.");
		
		var cnumList = document.getElementsByClassName("cnum");
		var cnums="";
		for(var i=0;i<cnumList.length;i++){
			cnums += String(cnumList[i].value)+" ";
		}
		
		var ototalprice = $("#ototalprice").val();
		var opayway = $("#payway").val();
		var oaddress = $(":input:radio[name=oaddress]:checked").val();
		var omessage = $("#omessage").val();
		var couponnum = $("#useCoupon").val();
		var mpoint = $("#point").val();
		var otime = Math.ceil(distance/500);
		location.href = "orderspay?cnum="+cnums+"&ototalprice="+ototalprice+"&opayway="+opayway+"&oaddress="+oaddress+"&omessage="+omessage+"&couponnum="+couponnum+"&mpoint="+mpoint+"&otime="+otime;
	}else{
		alert("결제가 취소되었습니다.");
	}
}

function selectPayway(payway){
	$(".paymentWay").css("backgroundColor","white");
	$(".paymentWay").css("color","rgb(95, 0, 128)");
	
	if(payway=="현장"){
		$("#paymentWayH").css("backgroundColor","rgb(95, 0, 128)");
		$("#paymentWayH").css("color","white");
	}else{
		$("#paymentWayM").css("backgroundColor","rgb(95, 0, 128)");
		$("#paymentWayM").css("color","white");
	}
	$("#payway").val(payway);
}

function selectCouponNum(couponNum){
	$("#selectCouponNum").val(couponNum);
}

</script>
<style>
.main{
 	width:900px;
 	margin:auto;
 	margin-top:40px;
 	margin-bottom:20px;
 }
 
 #payForm_line_0{
 	border-top : 1px solid black;
 	width:800px;
 	margin:auto;
 	margin-top:10px;
 	margin-bottom:10px;
 }
 .cartImg{
 	width:180px;
 	height:180px;
 }
 #cartList{
 	width:800px;
 	margin:auto;
 	margin-bottom:30px;
 }
 .cart{
 	width:900px;
 	margin:auto;
 }
 .line_0{
 	height:0px;
 	border-top:1px solid gray;
 	margin-bottom:10px;
 }
 
 .cartInfo{
 	padding:5px;
 	padding-left:50px;
 	padding-top:20px;
 	text-align:left;
 	font-weight:300;
 	width:600px;
 }
 .payInfo{
 	text-align:right;
 	font-weight:500;
 	font-size:20px;
 	width:600px;
 }
 #addressList{
 	width:850px;
 	margin:auto;
 	height:180px;
 	margin-top:10px;
 	padding:20px;
 	padding-top:0px;
 	text-align:center;
 }
 .address{
 	width:270px;
 	float:left;
 }
 .addresTable{
 	text-align:center;
 	width:270px;
 	font-weight:300;
 }
 .aflagRadio{
	width:17px;
	height:17px;
 }
 #orderInfo{
 	width:900px;
 	margin:auto;
 	padding:30px;
 	margin-top:0;
 	padding-bottom:0px;
 }
 #profileImg{
 	border-radius:50%;
	width:150px;
	height:150px;
	border:1px solid lightgray;
 }
  #usePoint{
  	width:100px;
  }
  
  input[type="number"]::-webkit-outer-spin-button,
  input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
#paymentPrice input{
	border:none;
	width:90px;
	font-size:20px;
	
}
#point{
	text-align:right;
	padding-right:5px;
}
#coupon{
	text-align:right;
	padding-right:5px;
}
.orderheader{
	width:900px;
	margin:auto;
	text-align:center;
	padding:20px;
	padding-bottom:40px;
	padding-top:10px;
	border-bottom:1px solid lightgray;
}
.orderheader h1{
	font-size:40px;
	font-weight:500;
}
.orderheader h4{
	color: gray;
	font-weight:300;
}
.orderinfo{
	text-align:left;
	font-size:20px;
}
.payinfo{
	width:840px;
	margin:auto;
	padding:30px;
	text-align:center;
	padding-top:10px;
	border-bottom:1px solid lightgray;
}
.usecoupon{
	width: 200px;
	height:30px;
	font-size:15px;
}
#omessageDiv{
	border-top:1px solid lightgray;
}
.payinfo_left{
	text-align:left;
	width:180px;
	font-size:18px;
	font-weight:300;
}

.paymentWay{
	width:160px;
	height:40px;
	background-color:white;
	border:1px solid rgb(95, 0, 128);
	color:rgb(95, 0, 128);
	font-size:17px;
	-webkit-transition: background-color 0.2s;
  	transition: background-color 0.2s;
  	margin:-2px;
  	margin-top:20px;
}

.paymentWay:hover{
	width:160px;
	height:40px;
	background-color:rgb(95, 0, 128);
	border:1px solid rgb(95, 0, 128);
	color:white;
	font-size:17px;
}

#payment_btn{
	width:160px;
	height:40px;
	background-color:white;
	border:1px solid rgb(95, 0, 128);
	border-radius:50px;
	color:rgb(95, 0, 128);
	font-size:17px;
	-webkit-transition: background-color 0.2s;
  	transition: background-color 0.2s;
}

#payment_btn:hover{
	width:160px;
	height:40px;
	background-color:rgb(95, 0, 128);
	border:1px solid rgb(95, 0, 128);
	border-radius:50px;
	color:white;
	font-size:17px;
}
#paymentWayH{
	background-color:rgb(95, 0, 128);
	color:white;
}

</style>
</head>
<body onload="onloadFn();">
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
		<div style="display:none">
	     <jsp:include page="../KakaoMap.jsp"></jsp:include>
	     </div>
	     <div class="main">
	     	<div class="orderheader">
	     		<h1>주문서</h1>
	     		<h4>주문하실 상품명 및 수량을 정확하게 확인해주세요.</h4>
	     	</div>
	     	<div class="orderinfo">
	     		<h4>상품정보</h4>
	     	</div>
	     	<div id="cartList">
	     		<c:set var = "sum" value = "0" />
	     		<c:forEach var="cart" items="${cartList}" varStatus="i">
					<div class="cart" id="cart${cart.cnum}">
						<input type="text" class="cnum" id="cnum${cart.cnum}" value="${cart.cnum}" style="display:none;">
						<table>
							<tr>
								<td rowspan="4"><img src ="resources/img/menuImage/${menuMap[cart.menunum].menuimg}" class="cartImg"></td>
								<td class="cartInfo">${cart.menuname}(${cart.storename})</td>
							</tr>
							<tr>
								<td class="cartInfo">가격 <fmt:formatNumber value="${cart.menuprice}" type="number"/> 원</td>
							</tr>
							<tr>
								<td class="cartInfo">수량 ${cart.camount} 개</td>
							</tr>
							<tr> 
								<td class="payInfo">금액<fmt:formatNumber value="${cart.menuprice*cart.camount}" type="number"/> 원</td>
							</tr>
						</table>
					</div>
					<c:set var= "sum" value="${sum+(cart.menuprice*cart.camount)}"/>					
	     		</c:forEach>
	     	</div>
	     	<div class="orderinfo" style="border-top:1px solid lightgray;">
	     		<h4>주소 정보</h4>
	     	</div>
	     	<div id="addressList">
				<c:forEach var="address" items="${addressList}">
					<div class="address">
						<table class="addresTable">
							<tr>
								<td>
									<c:choose>
										<c:when test="${address.aflag eq 1}">
											<input type="radio" name="oaddress" checked="checked" class="aflagRadio" value="${address.apostcode} ${address.adrs1}${address.adrs3}${address.adrs2}${address.adrs4}" onclick="onloadFn();">		
										</c:when>
										<c:otherwise>
											<input type="radio" name="oaddress" class="aflagRadio" value="${address.apostcode} ${address.adrs1} ${address.adrs3} ${address.adrs2} ${address.adrs4}" onclick="onloadFn();">
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
			     			<tr>
			     				<td>${address.apostcode}</td>
			     			</tr>
			     			<tr>
			     				<td>${address.adrs1} ${address.adrs3}</td>
			     			</tr>
			     			<tr>
			     				<td>${address.adrs2}</td>
			     			</tr>
			     			<tr>
			     				<td>${address.adrs4}</td>
			     			</tr>
		     			</table>
					</div>
	     		</c:forEach>
			</div>
			<div id="orderInfo">
				<div id="omessageDiv">
					<h4 style="font-size:20px;">요청사항</h4>
					<textarea id="omessage"style="width:600px; height:100px; resize:none; padding-top:5px;"></textarea>
				</div><br><br>
				<div class="orderinfo" style="border-top:1px solid lightgray;">
	     			<h4>결제 정보</h4>
	     		</div>
				<div class="payinfo">
					<c:forEach var="coupon" items="${couponList}">
						<input id="discount${coupon.couponnum}" value="${coupon.discount}" style="display:none;">
					</c:forEach>
					<table style="margin:auto;">
						<tr>
							<td class="payinfo_left">사용가능한 쿠폰</td>
							<td><select id="useCoupon" onchange="setFinalPrice()"class="usecoupon">
									<option value="0" selected>선택</option>
									<c:forEach var="coupon" items="${couponList}">
										<option value="${coupon.couponnum}">${coupon.couponname}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td class="payinfo_left">사용가능한 포인트</td>
							<td><fmt:formatNumber value="${member.mpoint}" type="number"/>P</td>
						</tr>
						<tr>
							<c:set var="mpoint" value="a${member.mpoint}"/>
							<td class="payinfo_left">사용할 포인트</td>
							<td><input type="number" id="usePoint" onKeydown="pointCheck()" onblur="pointCheck()" maxLength="${fn:length(mpoint)-1}" value="0"/>
							<button onclick="pointAllUse()">전체사용</button><button onclick="setFinalPrice()">포인트 사용</button></td>
						</tr>
					</table>
					<button class="paymentWay" id="paymentWayH"onclick="selectPayway('현장')">현장결제</button>
					<button class="paymentWay" id="paymentWayM" onclick="selectPayway('미리')">미리결제</button>
				<input id="payway" value="현장" style="display:none;">
				</div>
			</div>
				
			
			<div id="paymentPrice" style="margin:auto; margin-top:30px; margin-bottom:40px; width:840px;">
				<h4 style="font-size:20px;">총 결제 금액</h4>
				<input type="number" id="price" value="${sum}" readonly> - <input type="number" id="point" value="0" readonly>(포인트)
				 - <input type="number" id="coupon" value="0" readonly>(쿠폰) = <input type="number" id="ototalprice" value="${sum}" readonly>원
			</div>
			<button id="payment_btn" onclick="goPayment()">결제하기</button>
	     </div>
	</div>
	<div style="height:20px;"></div>
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>