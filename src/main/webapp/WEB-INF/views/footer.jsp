<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="footer">
	   	<div class="bottomnav">
			<div class="store">
				<a href="">이용약관</a>  |  
				<a href="">회사소개</a>  |  
				<a href="">공지사항</a>  |  
				<c:choose>
					<c:when test="${storeId eq null}"><a href="storeloginform">요기서요기 사장님</a></c:when>
					<c:when test="${storeId ne null}"><a href="storepage?sid=${sessionScope.storeId}">요기서요기 사장님</a></c:when>
					<c:when test="${loginId eq null}"><a href="storeloginform">요기서요기 사장님</a></c:when>
					<c:when test="${loginId ne null}"><a href="storeloginform">요기서요기 사장님</a></c:when>
				</c:choose>
			</div>
		</div>
	   	<div class="social">
	        <a href=""><i class="fab fa-facebook-f"></i></a>
	        <a href=""><i class="fab fa-twitter"></i></a>
	        <a href=""><i class="fab fa-google"></i></a>
	        <a href=""><i class="fab fa-instagram"></i></a>
	        <a href=""><i class="fab fa-youtube"></i></a>
	        <p>법인명(상호):주식회사 요기서요기<br>
	             대표자: 박누리, 원선영, 김선재<br>
	             통신판매업:인천 미추홀구 매소홀로488번길 6-32 태승빌딩 5층<br>
	             개인정보담당자:yogiseoyogi@delivery.co.kr<br>
	             고객만족센터:support@yogiseoyogi.co.kr<br>
	             Copyright ®2020 yogiseoyogi.co.,Ltd.All rights reserved.
	        </p>
		</div>
	 </div>
</body>
</html>