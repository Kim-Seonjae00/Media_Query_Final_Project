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
	#bookingList th{
		border-bottom: 1px solid #eee; 
		padding : 10px;
	}
	#bookingList td{
		border-bottom: 1px solid #eee;
		font-weight: 300;
		padding : 10px;
	}
	#modifyBtn{
		width: 100px;
		border: 1px solid rgb(95, 0, 128);
		color: rgb(95, 0, 128);
		background: white;
		border-radius: 50px;
		margin: 5px;
		padding: 10px;
	}
	#cancelBtn{
		width: 100px;
		border: 1px solid rgb(95, 0, 128);
		color: white;
		background: rgb(95, 0, 128);
		border-radius: 50px;
		margin: 5px;
		padding: 10px;
	}
</style>
<script>
	function bookingConfirm(bnum, bconfirm){
		$.ajax({
			type:"post",
			url:"bookingconfirm",
			data:{bnum:bnum,bconfirm:bconfirm},
			dataType:"text",
			success:
				function(result){
				var confirmHtml = "";
				var buttonHtml = "";
				if(result=="ok"){
					confirmHtml = "<p style='color:green'>예약 수락</p>";
					buttonHtml = "<button id='cancelBtn' disabled>예약수락</button>";
				}else if(result=="no"){
					confirmHtml ="<p style='color:red'>예약 거절</p>";
					buttonHtml = "<button id='cancelBtn' disabled>예약거절</button>";
				}
				$("#bookingConfirm").html(confirmHtml);
				$("#booking_btn").html(buttonHtml);	
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
	     	<span style="font-size:20px;">예약 신청 내역</span>
	     	<div id="mypage_line_0"></div>
	     		<div id="bookingList">
	     			<table style="margin-left: auto; margin-right: auto">
	     			<tr>
	     				<th>예약번호</th>
	     				<th style="width: 150px;">가게</th>
	     				<th>예약자</th>
	     				<th>예약일</th>
	     				<th>시간</th>
	     				<th>인원</th>
	     				<th>예약상황</th>
	     				<th>수정/취소</th>
	     			</tr>
	     			<c:forEach var="booking" items="${bookingList}">
	     			<tr>
	     				<td>${booking.bnum}</td>
	     				<td>${booking.storename}</td>
	     				<td>${booking.bname}</td>
	     				<td>${fn:substring(booking.bdate,0,10)}</td>
	     				<td>${booking.btime}</td>
	     				<td>${booking.bpeople}명</td>
	     				<td id="bookingConfirm">
	     					<c:choose>
	     						<c:when test="${booking.bconfirm eq '1'}">
	     							<p style="color:green">예약수락</p>
	     						</c:when>
	     						<c:when test="${booking.bconfirm eq '2'}">
	     							<p style="color:red">예약거절</p>
	     						</c:when>
	     						<c:otherwise>
	     							<p style="color:red">요청 중</p>
	     						</c:otherwise>
	     					</c:choose>
	     				</td>
	     				<td id="booking_btn">
	     					<c:choose>
	     						<c:when test="${booking.bconfirm eq '0'}">
				     				<button onclick="bookingConfirm(${booking.bnum},1)" id="modifyBtn">수락</button><br>
				     				<button onclick="bookingConfirm(${booking.bnum},2)" id="cancelBtn">거절</button>
	     						</c:when>
	     						<c:when test="${booking.bconfirm eq '1'}">
	     							<button id='cancelBtn' disabled>예약수락</button>
	     						</c:when>
	     						<c:when test="${booking.bconfirm eq '1'}">
	     							<button id='cancelBtn' disabled>예약거절</button>
	     						</c:when>
	     					</c:choose>
	     				</td>
	     			</tr>
	     			</c:forEach>
	     			</table>
				</div>
	     </div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>