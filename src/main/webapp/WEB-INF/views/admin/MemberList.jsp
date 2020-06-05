<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/cd5c7a4640.js"crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap"rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.js"integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/adminpage.css">
<script>
	function memberview(mid){
	    var url = "memberview?mid="+mid+"&loginId?${sessionScope.loginId}";
	    var name = "회원상세조회";
	    var option = "width = 600, height = 700, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	}
	
	function memberdelete(mid) {
		location.href="adminmemberdelete?mid="+mid+"&loginId=${sessionScope.loginId}";
	}
</script>
<style>
#profilebox td{
	width:170px;
	font-weight:300;
	padding-top:5px;
	padding-bottom:5px;
	border-top:0.7px solid lightgray;
}
#profilebox th{
	width:170px;
	padding-bottom:20px;
}
#profile{
	width:80px;
	height:80px;
}
#btn{
  border-top-left-radius:20px;
  border-bottom-left-radius:20px;
  border: 1.3px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
.btn{
  margin:-5px;
  border-top-right-radius:20px;
  border-bottom-right-radius:20px;
  border: 1.3px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
#btn:hover {
  border-top-left-radius:20px;
  border-bottom-left-radius:20px;
  border: 1.3px solid;
  background-color: rgb(95, 0, 128);
  color: white;
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
.btn:hover {
  margin:-5px;
  border-top-right-radius:20px;
  border-bottom-right-radius:20px;
  border: 1.3px solid;
  background-color: rgb(95, 0, 128);
  color: white;
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
</style>
</head>
<body>
	<jsp:include page="../adminProfile.jsp"></jsp:include>
	
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
		<jsp:include page="../adminSideNav.jsp"></jsp:include>
	     <div id="main">
	     	<span style="font-size:20px;">회원목록</span>
	     	<div id="mypage_line_0"></div>
	     	<table id="profilebox">
	     		<tr>
	     			<th style="width:170px;">프로필사진</th><th>아이디</th><th>이름</th><th>닉네임</th><th>삭제 / 상세</th>
	     		</tr>
	     	<c:forEach var="memberList" items="${memberList}">
	     		<tr>
	     		<c:choose>
					<c:when test="${memberList.mimg eq null}">
						<td><img src="resources/img/logo/로고2.png" id="profile"></td></c:when>
					<c:otherwise>
						<td><img src="resources/img/Profile/${memberList.mimg}" id="profile"></td>
					</c:otherwise>
				</c:choose>
	     
	     			<td>${memberList.mid}</td>
	     			<td>${memberList.mname}</td>
	     			<td>${memberList.mnickname}</td>
	     			<td><button onclick="memberdelete('${memberList.mid}')" id="btn">삭제</button>
	     			<button onclick="memberview('${memberList.mid}')" class="btn">상세</button></td>
	     		</tr>
	     	</c:forEach>
	     	</table>
	     </div>
	</div>
	
	
</body>
</html>