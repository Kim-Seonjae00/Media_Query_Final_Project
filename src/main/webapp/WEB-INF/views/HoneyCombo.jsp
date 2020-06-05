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
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;500;700&display=swap" rel="stylesheet">
<title>Insert title here</title>
<style>
.hero-image {
  background-image: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.5)), url("resources/img/recommend/PIXNIO-1578669-5307x3538.jpg");
  height: 400px;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  position: relative;
  margin-bottom:10px;
}
.hero-image2 {
  background-image: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.5)), url("resources/img/recommend/PIXNIO-1578669-5307x3538.jpg");
  height: 200px;
  width:245px;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  position: relative;
  margin-bottom:20px;
 }
.hero-text {
  text-align: center;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: white;
}

.hero-text button {
  border: none;
  outline: 0;
  display: inline-block;
  padding: 10px 25px;
  color: black;
  background-color: #ddd;
  text-align: center;
  cursor: pointer;
}

.hero-text button:hover {
  background-color: #555;
  color: white;
}

.btn1{
	width:160px;
	height:40px;
	background-color:rgb(95, 0, 128);
	border:1.5px solid rgb(95, 0, 128);
	border-radius:50px;
	color:white;
	font-size:17px;
	margin-top:35px;
	margin-left:15px;
	margin-right:15px;
}
.btn1:hover{
	width:160px;
	height:40px;
	background-color:white;
	border:1.5px solid rgb(95, 0, 128);
	border-radius:50px;
	color:rgb(95, 0, 128);
	font-size:17px;
}

#icons i{
	font-size:30px;
	padding-top:19px;
	border:1px solid lightgray;
	width:70px;
	height:70px;
	border-radius:50%;
}
#ordersStatus{
	margin:auto;
	margin-top:35px;
}

#ordersStatus td{
	width:100px;
}

.honeyCombo{
	width:900px;
	margin:auto;
	margin-bottom:10px;
}

</style>
<script>
	function goMain(){
		location.href="main";		
	}
	
	function goOrderList(){
		location.href="myorderslist?mid=${sessionScope.loginId}";
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	
	<div class="article">
		<jsp:include page="sideMenu.jsp"></jsp:include>
		<div id="main">
			<div style="border:1px solid #ddd; padding: 30px; border-radius:25px; width:900px; margin:auto; margin-bottom:20px;">
				<span style="font-size:25px;">주문이 신청되었습니다.</span><br>
				<span style="font-size:25px;">주문 승인 후 <strong>${otime+5}분 이내에</strong> 도착할 예정입니다.</span>
				<table id="ordersStatus">
					<tr id="icons">
						<td><i class="fas fa-ellipsis-h" style="background-color:rgb(232,223,240); border:1px solid rgb(232,223,240);"></i></td>
						<td><i class="fas fa-pizza-slice"></i></td>
						<td><i class="fas fa-motorcycle"></i></td>
						<td><i class="fas fa-home"></i></td>
					</tr>
					<tr>
						<td>확인중</td>
						<td>조리중</td>
						<td>배달중</td>
						<td>배달완료</td>
					</tr>
				</table>
				<button class="btn1" onclick="goMain()">메인으로</button>
				<button class="btn1" onclick="goOrderList()">주문내역</button>
			</div>
			<br>
			<strong style="font-size: 23px;">함께하면 더 맛있다! 꿀조합 메뉴 추천</strong>
			<div id="mypage_line_0" style="border-top:2px solid lightgray; margin:auto; margin-top:10px; margin-bottom:23px; width:950px;"></div>
			<div class="honeyCombo">
				<c:forEach var="honeyCombo" items="${honeyCombo}" varStatus="i">
					<c:choose>
						<c:when test="${ordersCount[0] != 0}">
						<div class="hero-image">
							<div class="hero-text">
								<h1> [ ${orderCount[i.index]} ] 명의 고객님들이 <br>
								[ ${honeyCombo} ] 를<br> 
								함께 주문하셨습니다.
								</h1>
							</div>
						</div>
						</c:when>
						
						<c:when test="${orderCount[0] == 0}">
						<div class="hero-image">
							<div class="hero-text">
								<h1> 식사 후에 <br>
								[ ${honeyCombo} ] 는
								어떠세요?
								</h1>
							</div>
						</div>
						</c:when>
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>