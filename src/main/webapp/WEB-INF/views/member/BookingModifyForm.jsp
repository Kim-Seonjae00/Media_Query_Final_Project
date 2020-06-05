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
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../memberProfile.jsp"></jsp:include>
	
	<div class="article">
	
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	    <jsp:include page="../memberSideNav.jsp"></jsp:include>
	     
	     <div id="main">
	     	<span style="font-size:20px;">예약 수정</span>
	     	<div id="mypage_line_0">
	     		<form action="bookingmodify?mid=${sessionScope.loginId}&bnum=${booking.bnum}" method="post">
					<table style="margin-left:auto; margin-right:auto">
						<tr>
							<th style="font-size: 25px;" colspan="2">예약</th>
						</tr>
						<tr>
							<th>예약자</th>
							<td><input type="text" name="bname" id="bname" value="${booking.bname}"></td>		
						</tr>
						<tr>
							<th>예약일자</th>
							<td><input type="date" name="bdate" id="bdate" value="${booking.bdate}"></td>
						</tr>
						<tr>
							<th>예약시간</th>
							<td>
								<select name="btime" id="btime">
									<option value="${booking.btime}">${booking.btime}</option>
									<option value="12:00">12:00</option>
									<option value="12:30">12:30</option>
									<option value="13:00">13:00</option>
									<option value="13:30">13:30</option>
									<option value="14:00">14:00</option>
									<option value="14:30">14:30</option>
									<option value="15:00">15:00</option>
									<option value="15:30">15:30</option>
									<option value="16:00">16:00</option>
									<option value="16:30">16:30</option>
									<option value="17:00">17:00</option>
									<option value="17:30">17:30</option>
									<option value="18:00">18:00</option>
									<option value="18:30">18:30</option>
									<option value="19:00">19:00</option>
									<option value="19:30">19:30</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>예약인원</th>
							<td>
								<select name="bpeople" id="bpeople">
									<option value="${booking.bpeople}">${booking.bpeople}</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
								</select>
							</td>
						</tr>
					</table>
					<input type="submit" id="modifyBtn" value="수정하기"> 
				</form>
	     	</div>
	     </div>
	</div>
	
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>