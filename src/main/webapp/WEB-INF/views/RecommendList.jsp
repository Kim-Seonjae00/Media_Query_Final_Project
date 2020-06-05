<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/recommend.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="article">
		<jsp:include page="sideMenu.jsp"></jsp:include>
		<br><br>
		<h2 style="text-align: center">믿고 먹는 맛집 리스트</h2>

		<div class="container">
			<div class="mySlides">
				<div class="numbertext"></div>
				<img src="resources\img\recommend\고깃집대표사진.jpg" style="width: 100%; height:500px;">
				<div class="content">
				<h1 style="font-size:40px;"><a href="recommendstorelist?matcategory=고깃집&title=고기 맛집 베스트">고기 맛집 베스트</a></h1>
				<p style="font-size:20px;">"인생은 고기서 고기지!"</p>
				</div>
			</div>

			<div class="mySlides">
				<div class="numbertext"></div>
				<img src="resources\img\recommend\냉면대표사진.jpg" style="width: 100%; height:500px;">
				<div class="content">
				<h1 style="font-size:40px;"><a href="recommendstorelist?matcategory=냉면&title=전국 냉면 맛집 베스트">전국 냉면 맛집 베스트</a></h1>
				<p style="font-size:20px;">"입맛 없을 땐 역시 시원한 냉면!"</p>
				</div>
			</div>

			<div class="mySlides">
				<div class="numbertext"></div>
				<img src="resources\img\recommend\노량진대표사진.jpg" style="width: 100%; height:500px;">
				<div class="content">
				<h1 style="font-size:40px;">노량진 맛집 베스트</h1>
				<p style="font-size:20px;">"어디서 노랴? 노량진에서!"</p>
				</div>
			</div>

			<div class="mySlides">
				<div class="numbertext"></div>
				<img src="resources\img\recommend\디저트대표사진.jpg" style="width: 100%; height:500px;">
				<div class="content">
				<h1 style="font-size:40px;"><a href="recommendstorelist?matcategory=디저트&title=예쁜 디저트 맛집 베스트">예쁜 디저트 맛집 베스트</a></h1>
				<p style="font-size:20px;">"사진 찍기 전엔 포크 들 생각 하지 마!!!!"</p>
				</div>
			</div>

			<div class="mySlides">
				<div class="numbertext"></div>
				<img src="resources\img\recommend\돈가스대표사진.jpg" style="width: 100%; height:500px;">
				<div class="content">
				<h1 style="font-size:40px;"><a href="recommendstorelist?matcategory=돈가스&title=돈가스 맛집 베스트">돈가스 맛집 베스트</a></h1>
				<p style="font-size:20px;">"바삭함은 기본, 소스는 듬뿍!"</p>
				</div>
			</div>

			<div class="mySlides">
				<div class="numbertext"></div>
				<img src="resources\img\recommend\이자카야대표사진.jpg" style="width: 100%; height:500px;">
				<div class="content">
				<h1 style="font-size:40px;"><a href="recommendstorelist?matcategory=술집&title=안주가 맛있는 술집 베스트">안주가 맛있는 술집 베스트</a></h1>
				<p style="font-size:20px;">"안주에 한 번, 분위기에 두 번 취하는 맛집!"</p>
				</div>
			</div>


			<div class="row">
				<div class="column">
					<img class="demo cursor" src="resources\img\recommend\고깃집대표사진.jpg" style="width: 100%; height:100px;"
						onclick="currentSlide(1)" alt="고기 맛집 베스트">
				</div>
				<div class="column">
					<img class="demo cursor" src="resources\img\recommend\냉면대표사진.jpg" style="width: 100%; height:100px;"
						onclick="currentSlide(2)" alt="전국 냉면 맛집">
				</div>
				<div class="column">
					<img class="demo cursor" src="resources\img\recommend\노량진대표사진.jpg"
						style="width: 100%; height:100px;" onclick="currentSlide(3)"
						alt="노량진 맛집 베스트">
				</div>
				<div class="column">
					<img class="demo cursor" src="resources\img\recommend\디저트대표사진.jpg" style="width: 100%; height:100px;"
						onclick="currentSlide(4)" alt="예쁜 디저트 맛집 베스트">
				</div>
				<div class="column">
					<img class="demo cursor" src="resources\img\recommend\돈가스대표사진.jpg" style="width: 100%; height:100px;"
						onclick="currentSlide(5)" alt="돈가스 맛집 베스트">
				</div>
				<div class="column">
					<img class="demo cursor" src="resources\img\recommend\이자카야대표사진.jpg" style="width: 100%; height:100px;"
						onclick="currentSlide(6)" alt="안주가 맛있는 술집 베스트">
				</div>
			</div>
		</div>

		<script>
			var slideIndex = 1;
			showSlides(slideIndex);

			function plusSlides(n) {
				showSlides(slideIndex += n);
			}

			function currentSlide(n) {
				showSlides(slideIndex = n);
			}

			function showSlides(n) {
				var i;
				var slides = document.getElementsByClassName("mySlides");
				var dots = document.getElementsByClassName("demo");
				var captionText = document.getElementById("caption");
				if (n > slides.length) {
					slideIndex = 1
				}
				if (n < 1) {
					slideIndex = slides.length
				}
				for (i = 0; i < slides.length; i++) {
					slides[i].style.display = "none";
				}
				for (i = 0; i < dots.length; i++) {
					dots[i].className = dots[i].className
							.replace(" active", "");
				}
				slides[slideIndex - 1].style.display = "block";
				dots[slideIndex - 1].className += " active";
				captionText.innerHTML = dots[slideIndex - 1].alt;
			}
		</script>
	
	<div class="voucherstore">
		<h2>요Deal을 판매중인 식당</h2>
		<div class="voucherrow">
			<c:forEach var="store" items="${storeList}" varStatus="i">
				<div class="vouchercolumn">
					<c:choose>
						<c:when test="${store.simg ne null}">
							<img src="resources/img/Profile/${store.simg}" style="width: 100%" id="vstoreImg">
						</c:when>
						<c:when test="${store.simg eq null}">
							<img src="resources/img/recommend/이자카야대표사진.jpg" style="width: 100%" id="vstoreImg">
						</c:when>
					</c:choose>
					<a href="storeview?sid=${store.sid}"><span class="tt">${store.storename}</span></a><strong class="rr">${fn:substring(rrateList[i.index],0,3)}</strong>
					<p class="pp">(${store.sadrs1})</p>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<div class="beststore">
		<h2>평점 높은 인기맛집</h2>
		<div class="voucherrow">
			<c:forEach var="best" items="${bestList}" varStatus="i" begin="0" end="7" step="1">
				<div class="vouchercolumn">
					<c:if test="${rates[i.index] >= 4.0}">
					<c:choose>
						<c:when test="${best.simg ne null}">
							<img src="resources/img/Profile/${best.simg}" style="width: 100%" id="vstoreImg">
						</c:when>
						<c:when test="${best.simg eq null}">
							<img src="resources/img/recommend/이자카야대표사진.jpg" style="width: 100%" id="vstoreImg">
						</c:when>
					</c:choose>
					<a href="storeview?sid=${best.sid}"><span class="tt">${best.storename}</span></a><strong class="rr">${rates[i.index]}</strong>
					<p class="pp">(${best.sadrs1})</p>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>
	
	</div>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>