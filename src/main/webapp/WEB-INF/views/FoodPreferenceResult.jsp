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
.hero-image {
  background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url("resources/img/recommend/PIXNIO-1578669-5307x3538.jpg");
  height: 400px;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  position: relative;
  margin-bottom:50px;
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
  display: inline-block;
  padding: 10px 25px;
  text-align: center;
  cursor: pointer;
  background-color: white;
  border:none;
}

.hero-text button:hover {
  background-color: rgb(95, 0, 128);
  color: white;
}
.main{
	width:900px;
	margin:auto;
	margin-top:30px;
	text-align:left;
}
</style>

</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	
	<div class="article">
		<jsp:include page="sideMenu.jsp"></jsp:include>
		
		<div class="main">
			<span style="font-size: 20px;">  오늘 뭐 먹지?</span>
			<div id="mypage_line_0"></div>
			<c:forEach var="tasteList" items="${tasteList}" varStatus="i">
				<c:choose>
					<c:when test="${i.count eq 1}">
						<div class="hero-image">
							<div class="hero-text">
								<h1 style="font-size: 40px">오늘은<br>
									[ ${tasteList.storename} ]의<br>
									[ ${tasteList.menuname} ] 어떠세요?</h1>
								<button>주문하기</button>
							</div>
						</div>
					</c:when>
					<c:otherwise>
							<div class="hero-image">
								<div class="hero-text">
									<h1 style="font-size: 40px">
										<br>[ ${tasteList.storename} ]의<br>
										[ ${tasteList.menuname} ] 도 추천!
									</h1>
									<button>주문하기</button>
								</div>
							</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>