<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		<div id="top_profile_img">
			<c:choose>
				<c:when test="${profile.mimg ne null}"><img src="resources/img/memberProfile/${profile.mimg}" id="profileImg"></c:when>
				<c:when test="${profile.mimg eq null}"><img src="resources/img/logo/로고2.png" id="profileImg"></c:when>
			</c:choose>
		</div>
		
		<div id="top_profile_contents" style="text-align:left;">
			<span style="font-size: 35px; font-weight:500;">${profile.mnickname}님</span><br><br>
			<a href="#" onclick="signOut();" style="color:black;">로그아웃</a>
			<br><br>
			<table id="top_profile_contents_table">
				<tr id="on">
					
				</tr>
				<tr id="under">
					<td><!-- DeliveryController에서 주문개수 불러오기 --></td>
					
					<td><!-- CouponeController에서 쿠폰개수 불러오기 --></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>