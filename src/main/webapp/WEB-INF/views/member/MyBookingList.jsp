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
	function modifyFn(bnum){
		location.href="bookingmodifyform?mid=${sessionScope.loginId}&bnum="+bnum;
	}
	function deleteFn(bnum){
		if(confirm("해당 예약을 취소하시겠습니까?")){
		$.ajax({
			type: "post",
			url: "bookingcancel",
			data: {"bnum": bnum},
			dataType: "text",
			success: function(result){
				console.log("통신 성공");
				if(result == "OK"){
					alert("예약이 취소되었습니다.");
					location.href="mybookinglist?mid=${sessionScope.loginId}";
				}else{
					alert("예약취소 오류");
				}
			},
			error: function(){
				console.log("통신 실패!");
			}
		});
		}else{
			location.href="mybookinglist?mid=${sessionScope.loginId}";
		}
	}
</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../memberProfile.jsp"></jsp:include>
	
	<div class="article">
	
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	    <jsp:include page="../memberSideNav.jsp"></jsp:include>
	     
	     <div id="main">
	     	<span style="font-size:20px;">예약목록</span>
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
	     				<td>
	     					<c:choose>
	     						<c:when test="${booking.bconfirm ne '0'}">
	     							<p style="color:green">예약 완료</p>
	     						</c:when>
	     						<c:otherwise>
	     							<p style="color:red">요청 중</p>
	     						</c:otherwise>
	     					</c:choose>
	     				</td>
	     				<td><button onclick="modifyFn(${booking.bnum})" id="modifyBtn">수정</button><br>
	     				<button onclick="deleteFn(${booking.bnum})" id="cancelBtn">취소</button></td>
	     			</tr>
	     			</c:forEach>
	     			</table>
				</div>
	     	</div>
		</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>