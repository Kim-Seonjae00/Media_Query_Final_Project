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
<link href="https://fonts.googleapis.com/css2?family=Song+Myung&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap"rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="resources/css/recommendstore.css">
</head>

<script>
	function searchFn() {
		var searchWord = document.getElementById("searchword").value;
		console.log(searchWord);
		location.href="searchmenu?searchWord="+searchWord;
	}
	function gomypage(loginId) {
		if(loginId != null) {
			location.href="memberpage?mid="+loginId;
		} else {
			alert("로그인 후 이용 가능합니다.");
			location.href="memberloginform";
		}
	}
	function gorecommend() {
		location.href="recommendlist";
	}
	function godeal(loginId) {
		if(loginId != null) {
			location.href="voucherlist?loginId="+loginId;
		} else {
			alert("로그인 후 이용 가능합니다.");
			location.href="memberloginform";
		}
	}
</script>
<body>
	<div class="recommendheader">
		<a href="main"><i class="fas fa-home" id="logoimg"></i></a>
        <input type="text" id="searchword" value="" placeholder="먹고 싶은 메뉴 검색">
        <button onclick="searchFn()" id="searchbtn"><i class="fas fa-search"></i></button>
        <button onclick="gomypage(${sessionScope.loginId})" class="recobtn"><i class="fas fa-child" ></i></button>
        <button onclick="gorecommend()" class="recobtn">맛집리스트</button>
        <button onclick="godeal(${sessionScope.loginId})" class="recobtn">요기서Deal</button>
	</div>
	<div class="recommendtitle">
		<h2>${title}</h2>
		<h4>"요기서 요기가 엄선한 믿을 수 있는 맛집!"</h4>
	</div>
	<c:forEach var="store" items="${storeList}" varStatus="status">
	<div class="recommendlist">
			<div class="imgArea">
				<c:choose>
					<c:when test="${store.simg ne null}">
						<img src="resources/img/Profile/${store.simg}" class="storeimg">
					</c:when>
					<c:otherwise>
						<img src="resources/img/logo/로고2.png" class="storeimg">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="infoArea">
				<span class="storeName"><a href="storeview?sid=${store.sid}">${store.storename}</a></span>
				<span class="storeCategory">${store.scategory}</span><br> <span
					class="storePhone">${store.sphone}</span><br>
				<div class="adrsArea">${store.spostcode} ${store.sadrs1} ${store.sadrs2} ${store.sadrs3}
				${store.sadrs4}</div><br>
				<div class="reviewArea">
				<c:choose>
					<c:when test="${imgList[status.index] ne null}">
						<span class="reviewImgArea"><img src="resources/img/Profile/${imgList[status.index]}"></span>
					</c:when>
					<c:when test="${imgList[status.index] eq null}">
						<span class="reviewImgArea"><img src="resources/img/logo/로고2.png"></span>
					</c:when>
				</c:choose>
				<span class="reviewIdArea">${reviewList[status.index].mid}</span>
				<span class="reviewTextArea">${reviewList[status.index].rcontents}</span>
				</div>
			</div>
			<div class="moreInfoArea">
				<span class="rateArea">평점 ${fn:substring(rrateList[status.index],0,3)}</span><br><br><br><br><br>
				<span class="seeMore"><a href="storeview?sid=${store.sid}">${store.storename} 더 보기 ></a></span>
			</div>
	</div><br>
	</c:forEach>
	

</body>
</html>