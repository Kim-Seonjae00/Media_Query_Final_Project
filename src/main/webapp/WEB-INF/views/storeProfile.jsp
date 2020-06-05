<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script>
function signOut() {
	location.href="logout";
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
      console.log('User signed out.');
    });
    auth2.disconnect();
  }
</script>
</head>
<body>
<div id="top_profile">
		<div id="top_profile_img"><!--프로필 사진 -->
			<c:choose>
				<c:when test="${store.simg eq null}">
					<img src="resources/img/logo/로고2.png" id="profileImg">
				</c:when>
				<c:otherwise>
					<img src="resources/img/Profile/${store.simg}" id="profileImg">
				</c:otherwise>
			</c:choose>
		</div>
		
		<div id="top_profile_contents" style="text-align:left; width:740px !important;"><!--프로필 내용-->
			<span style="font-size: 35px; font-weight:500;">${store.sname}님</span>
			${store.storename}<br><br>
			<table id="top_profile_contents_table">
				<tr id="on">
					<td>주문내역</td>
					<td>매출액</td>
					<td>리뷰 갯수</td>
				</tr>
				<tr id="under">
					<td>${ordersCount}</td>
					<td><fmt:formatNumber value="${store.sales}" type="number"/>원</td>
					<td>${reviewCount}<!-- 리뷰 개수 추가 --></td>
					<td><a href="#" onclick="signOut();">로그아웃</a></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>