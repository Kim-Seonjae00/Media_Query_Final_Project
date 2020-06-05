<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/cd5c7a4640.js"
	crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>


<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/mypage.css">
<script>
</script>
<style>
#ordersList th {
	padding: 10px;
	text-align: left;
}

#ordersList td {
	font-weight: 300;
	padding: 10px;
	text-align: left;
}

#mypage_line_1 {
	height: 0px;
	border-bottom: 1px solid #ccc;
}

pre {
	text-align: left;
	padding: 20px;
}

#onum {
	background: #eee;
}

.reviewBtn {
	width: 160px;
	height: 40px;
	background-color: rgb(95, 0, 128);
	border: 1.5px solid rgb(95, 0, 128);
	border-radius: 50px;
	color: white;
	font-size: 17px;
	margin-left: 340px;
	-webkit-transition: background-color 0.2s;
	transition: background-color 0.2s;
}

.reviewBtn_Done, .reviewBtn:hover {
	width: 160px;
	height: 40px;
	background-color: white;
	border: 1.5px solid rgb(95, 0, 128);
	border-radius: 50px;
	color: rgb(95, 0, 128);
	font-size: 17px;
	margin-left: 340px;
}
</style>
<script>
	function ordersConfirm(onum){
		$.ajax({
			url:"startorderscalculate",
			type:"POST",
			cache:false,
			data:{onum:onum},
			async:false,
			success:function(data){
				console.log(data);
			},
			error:function(e){
				console.log("err : " + e);
			}
		});
		
		$.ajax({
			type:"post",
			url:"ordersconfirm",
			data:{onum:onum},
			dataType:"text",
			success:
				function(result){
				 if(result=="success"){
					 $("#reviewBtn"+onum).css("background-color","white");
					 $("#reviewBtn"+onum).css("border","1.5px solid rgb(95, 0, 128)");
					 $("#reviewBtn"+onum).css("color","rgb(95, 0, 128)");
					 $("#reviewBtn"+onum).html("주문확인완료");
					 $("#ostatus"+onum).html("조리중");
				 }
			},
			error:
				function(){
				console.log("통신실패");
			}
		});	
	}
</script>
</head>
<body>
	<jsp:include page="../storeProfile.jsp"></jsp:include>

	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
		<jsp:include page="../storeSideNav.jsp"></jsp:include>

		<div id="main">
			<span style="font-size: 20px;">주문내역</span>
			<div id="mypage_line_0"></div>
			<div id="ordersList">
				<c:forEach var="onum" items="${onumList}">
					<div id="order${onum}" class="onum">
						<c:choose>
							<c:when test="${ordersMap[onum].get(0).ostatus eq '확인중'}">
								<pre>주문번호      ${onum}<button
										onclick="ordersConfirm('${onum}')" id="reviewBtn${onum}"
										class="reviewBtn">주문확인</button>
								</pre>
							</c:when>
							<c:otherwise>
								<pre>주문번호      ${onum}<button id="reviewBtn${onum}"
										class="reviewBtn_Done" disabled>주문확인완료</button>
								</pre>
							</c:otherwise>
						</c:choose>
						<div id="mypage_line_1"></div>
						<table style="margin-left: auto; margin-right: auto">
							<tr>
								<th>주문상태</th>
								<td id="ostatus${onum}">${ordersMap[onum].get(0).ostatus}</td>
							</tr>
							<tr>
								<th>주문시간</th>
								<td>${ordersMap[onum].get(0).odate}</td>
							</tr>
							<tr>
								<th>상호명</th>
								<td>${ordersMap[onum].get(0).storename}</td>
							</tr>
							<tr>
								<th>메뉴</th>
								<td><c:forEach var="orders" items="${ordersMap[onum]}">${orders.menuname} ${orders.camount}개<br>
									</c:forEach></td>
							</tr>
							<tr>
								<th>결제수단</th>
								<td>${ordersMap[onum].get(0).opayway}</td>
							</tr>
							<tr>
								<th>주문주소</th>
								<td>${ordersMap[onum].get(0).oaddress}</td>
							</tr>
							<tr>
								<th>요청사항</th>
								<td>${ordersMap[onum].get(0).omessage}</td>
							</tr>
							<tr>
								<th>총 주문 금액</th>
								<td>${ordersMap[onum].get(0).ototalprice}원</td>
							</tr>
							
						</table>
						<div id="mypage_line_1"></div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>