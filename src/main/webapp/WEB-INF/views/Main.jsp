<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src=""></script>
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
    <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">
<title>Insert title here</title>
<script>
	$(document).ready(function() {

		var currentPosition = parseInt($("#sideMenu").css("top"));
		$(window).scroll(function() {
			var position = $(window).scrollTop();
			console.log("position:" + position);
			if (position < 200) {
				$("#sideMenu").stop().animate({
					"top" : 400 + "px"
				}, 500);
				console.log("aaa")
			} else if (position > 1600) {
				$("#sideMenu").stop().animate({
					"top" : 2100 + "px"
				}, 500);
				console.log("bbb")
			} else {
				console.log("ddd");
				$("#sideMenu").stop().animate({
					"top" : position + currentPosition - 170 + "px"
				}, 300);
				console.log("머러마ㅣ:" + parseInt($("#sideMenu").css("top")));
			}
		});
	});
	
	function preferencesearchform() {
		if('${sessionScope.loginId}' != "") {
			location.href="preferencesearchform";
		} else {
			alert("로그인 후 이용 가능합니다");
			location.href="memberloginform";
		}
	}
	
	function honeycombo() {
		location.href="orderlist";
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
    <div class="container">
      <div class="slideshow-container">
          <div class="mySlides fade">
          <img src="resources/img/ad/ad5.PNG" style="width:100%; height:440px;">
          </div>

          <div class="mySlides fade">
          <img src="resources/img/ad/ad6.PNG" style="width:100%; height:440px;">
          </div>

          <div class="mySlides fade">
          <img src="resources/img/ad/ad7.PNG" style="width:100%; height:440px;">
          </div>
      </div>
      
      <div style="text-align:center" id="dots">
          <span class="dot"></span> 
          <span class="dot"></span> 
          <span class="dot"></span> 
      </div>
      <script>
     	  document.getElementById("dots").style.display="none";
          var slideIndex = 0;
          showSlides();

          function showSlides() {
          var i;
          var slides = document.getElementsByClassName("mySlides");
          var dots = document.getElementsByClassName("dot");
          for (i = 0; i < slides.length; i++) {
              slides[i].style.display = "none";  
          }
          slideIndex++;
          if (slideIndex > slides.length) {slideIndex = 1}    
          for (i = 0; i < dots.length; i++) {
              dots[i].className = dots[i].className.replace(" active", "");
          }
          slides[slideIndex-1].style.display = "block";  
          dots[slideIndex-1].className += " active";
          setTimeout(showSlides, 2000);
          }
      </script>
  </div>

	<!-- <div class="sideAd">
		<img src="resources/img/ad/첫주문쿠폰.jpg" class="adImg"> 
		<img src="resources/img/ad/회원가입할인쿠폰.png" class="adImg">
	</div> -->
	<div class="article">
     <jsp:include page="sideMenu.jsp"></jsp:include>
		<div class="mainMenu">
			<div class="category">
				<a href="searchby?scategory=치킨"><img
					src="resources/img/category/치킨.png" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=치킨"><div class="text"># 치킨</div></a>
				</div>
			</div>
			<div class="category">
				<a href="searchby?scategory=피자"><img
					src="resources/img/category/피자.jpg" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=피자"><div class="text"># 피자</div></a>
				</div>
			</div>
			<div class="category">
				<a href="searchby?scategory=패스트푸드"><img
					src="resources/img/category/패스트푸드.jpg" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=패스트푸드"><div class="text"># 패스트푸드</div></a>
				</div>
			</div>
			<div class="category">
				<a href="searchby?scategory=한식"><img
					src="resources/img/category/한식.jpg" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=한식"><div class="text"># 한식</div></a>
				</div>
			</div>
			<div class="category">
				<a href="searchby?scategory=중식"><img
					src="resources/img/category/짜장면.jpg" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=중식"><div class="text"># 중식</div></a>
				</div>
			</div>
			<div class="category">
				<a href="searchby?scategory=일식/돈까스"><img
					src="resources/img/category/초밥.jpg" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=일식/돈까스"><div class="text"># 일식</div></a>
				</div>
			</div>
			<div class="category">
				<a href="searchby?scategory=분식"><img
					src="resources/img/category/떡볶이.jpg" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=분식"><div class="text"># 분식</div></a>
				</div>
			</div>
			<div class="category">
				<a href="searchby?scategory=야식"><img
					src="resources/img/category/야식.jpg" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=야식"><div class="text"># 야식</div></a>
				</div>
			</div>
			<div class="category">
				<a href="searchby?scategory=족발/보쌈"><img
					src="resources/img/category/족발.jpg" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=족발/보쌈"><div class="text"># 족발/보쌈</div></a>
				</div>
			</div>
			<div class="category">
				<a href="searchby?scategory=아시안/양식"><img
					src="resources/img/category/아시안양식.jpg" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=아시안/양식"><div class="text"># 아시안/<br>양식</div></a>
				</div>
			</div>
			<div class="category">
				<a href="searchby?scategory=디저트"><img
					src="resources/img/category/디저트.jpg" class="cateImg"></a>
				<div class="middle">
					<a href="searchby?scategory=디저트"><div class="text"># 디저트</div></a>
				</div>
			</div>
			<div class="category">
				<a href="preferencesearchform"><img
					src="resources/img/category/오늘뭐먹지.png" class="cateImg"></a>
				<div class="middle">
					<a href="preferencesearchform"><div class="text"># 오늘<br>뭐먹지?</div></a>
				</div>
			</div>
		</div>
	</div>
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>