<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script>
function goMain(){
	location.href="main";
}
function countMinus(cnum){
	var count = parseInt($("#count"+cnum).val())-1;
	var menuPrice = parseInt($("#menuPrice"+cnum).text().slice(0,-1).replace(",",""));
	if(count<1){
		count=1;
	}
	
	$.ajax({
		type:"post",
		url:"updatecamount",
		data:{"cnum":cnum,"camount":count},
		dataType:"text",
		success:
		function(result){
			if(result != "success"){				
				alert("장바구니 저장에 실패하였습니다.");				
			}
		},
		error:
			function(){
			console.log("통신실패");
		}
	});
	
	var amount=count*menuPrice;
	$("#count"+cnum).val(count);
	$("#cartPrice"+cnum).val(amount)
	$("#cartAmount"+cnum).text(amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"원");
}

function countPlus(cnum){
	var count = parseInt($("#count"+cnum).val())+1;
	var menuPrice = parseInt($("#menuPrice"+cnum).text().slice(0,-1).replace(",",""));
	
	$.ajax({
		type:"post",
		url:"updatecamount",
		data:{"cnum":cnum,"camount":count},
		dataType:"text",
		success:
		function(result){
			if(result != "success"){				
				alert("장바구니 저장에 실패하였습니다.");				
			}
		},
		error:
			function(){
			console.log("통신실패");
		}
	});
	
	var amount=count*menuPrice;
	$("#count"+cnum).val(count);
	$("#cartPrice"+cnum).val(amount)
	$("#cartAmount"+cnum).text(amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"원");
}

$(function(){
	$("#cartAllChecked").click(function(){
		if($("#cartAllChecked").prop("checked")){
			$("input[type=checkbox]").prop("checked",true);
		}else{
			$("input[type=checkbox]").prop("checked",false);
		}		
	});
});



function goPayment(){
	var checkedCart = new Array();
	var ordersList = "";
	var ototalPrice = 0;
	var sid = $("#sid").val();
	$("input[class=check]:checked").each(function() {
		var test = $(this).val();
		if(test != null){
			checkedCart.push(test);
			ototalPrice = ototalPrice + parseInt($("#cartPrice"+test).val());			
		}
	});
	console.log(ototalPrice);
	
	if(checkedCart.length==0){
		alert("구매하실 상품을 선택해주세요.");
	}else if(ototalPrice<15000){
		alert("최소 주문 금액은 15,000원입니다.");
	}else{
		for(var i=0;i<checkedCart.length;i++){
			ordersList += checkedCart[i]+" ";
		}
	location.href="orderspayform?ordersList="+ordersList+"&mid=${sessionScope.loginId}&sid="+sid;
	}
}

function cartDelete(cnum){
	if(confirm("정말로 삭제하실건가요?")){
		alert("삭제되었습니다.");
		location.href="cartdelete?mid=${sessionScope.loginId}&cnum="+cnum;
	}else{
		alert("취소되었습니다.");
	}
}
</script>

<style>
.cartheader{
	width:900px;
	margin:auto;
	text-align:center;
	padding-bottom:50px;
	border-bottom:1px solid gray;
}
.cartheader h4{
	color: gray;
	font-weight:300;
}
.cartheader h1{
	font-size:40px;
}
.cartList {
	width:900px;
	margin:auto;
	padding-top:20px;
}
.cartImg {
	width: 70px;
	height: 70px;
	padding-left:10px;
}
.count {
	width: 45px;
	padding-left:15px;
	margin:-4px;
	border:none;
}
.cartnumber{
	width:60px;
}
.cartName{
	width:320px;
	padding-left:30px;
}
.cartTable th{
	padding-bottom:17px;
	border-bottom:0.7px solid lightgray;
}
.cartTable td{
	font-weight:300;
	padding-top:5px;
	padding-bottom:5px;
}
.cartPrice{
	width:100px;
}
.cartAmount{
	width:100px;
}
.btnbox{
	width:900px;
	margin:auto;
	padding-top:20px;
	border-top:0.7px solid lightgray;
}
.count_btn{
	width:25px;
	height:18px;
	font-size:13px;
	text-align:center;
	padding-bottom:20px;
}
.delbtn{
	border:0.7px solid lightgray;
	background-color:white;
	color:gray;
	padding:8px;
	border-radius:5px;
}
.delbtn:hover{
	border:0.7px solid lightgray;
	background-color: lightgray;
	color:white;
	padding:8px;
}
.cartManage{
	width:100px;
}
.orderbtn{
	width:180px;
	height:40px;
	background-color:rgb(95, 0, 128);
	border:none;
	color:white;
	margin-bottom:30px;
	margin-top:30px;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
		<div class="cartList">
			<c:choose>
				<c:when test="${cartList[0].cnum eq null}">
					<div style="height:100px"></div>
					<i class="fas fa-shopping-cart" style="font-size:70px;"></i><br>
					장바구니에 담긴 상품이 없습니다.<br>
					<button onclick="goMain()">홈으로 가기</button>
					<div style="height:100px"></div>
				</c:when>
				<c:otherwise>
					<div class="cartheader">	
						<h1>장바구니</h1>
						<h4>주문하실 상품명 및 수량을 정확하게 확인해주세요.</h4>
					</div>
					<table class="cartTable">
						<tr>
							<th class="cartnumber">번호</th>
							<th class="cartChecked"><input type="checkbox" id="cartAllChecked" checked="checked"></th>
							<th class="cartName" colspan="2">상품명</th>
							<th class="cartPrice">판매가</th>
							<th class="cartCount">수량</th>
							<th class="cartAmount">주문금액</th>
							<th class="cartManage">주문관리</th>
						</tr>
						<c:forEach var="cart" items="${cartList}" varStatus="i">
							<tr id="cart${cart.cnum}">
								<td class="cartnumber">${i.count}</td>
								<td class="cartChecked"><input type="checkbox" class="check" checked="checked" value="${cart.cnum}"></td>
								<td class="cartImg"><img src ="resources/img/menuImage/${menuMap[cart.menunum].menuimg}" class="cartImg"></td>
								<td class="cartName" style="text-align:left;">${cart.menuname}</td>
								<td class="menuPrice" id="menuPrice${cart.cnum}"><fmt:formatNumber value="${cart.menuprice}" type="number"/>원</td>
								<td style="text-align:right;" class="cartPlus">
	    							<button class="count_btn" id="count_minus" onclick="countMinus('${cart.cnum}')">-</button>
	    							<input type="number" class="count" id="count${cart.cnum}" value="${cart.camount}" readonly>
	    							<button class="count_btn" id="count_plus" onclick="countPlus('${cart.cnum}')">+</button> 
	    						</td>
								<td class="cartAmount" id="cartAmount${cart.cnum}"><fmt:formatNumber value="${cart.menuprice*cart.camount}" type="number"/>원</td>
								<td><button onclick="cartDelete(${cart.cnum})" class="delbtn">삭제하기</button></td>
							</tr>
							<input value="${cart.menuprice * cart.camount}" id="cartPrice${cart.cnum}" style="display:none;">
							<input value="${menuMap[cart.menunum].sid}" style="display:none" id="sid">
						<div class="cartline"></div>
						</c:forEach>
					</table>
					<div class="btnbox">
					<button onclick="goPayment()" class="orderbtn">주문하기</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>