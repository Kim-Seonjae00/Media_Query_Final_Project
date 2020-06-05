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
	function adminstoreview(sid){
	    var url = "adminstoreview?sid="+sid;
	    var name = "업체상세조회";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	}
	
	function storedelete(sid) {
		location.href="adminstoredelete?sid="+sid+"&loginId=${sessionScope.loginId}";
	}
	
	function storeblacklistadd(sid) {
		location.href="storeblacklistadd?sid="+sid+"&loginId=${sessionScope.loginId}";
	}
</script>
<style>
.main{
	text-align:center;
}
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
  border: 2px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 8px 15px;
  font-size: 14px;
  cursor: pointer;
  width: 65px;
}
#btn:hover {
  background-color: rgb(95, 0, 128);
  color: white;
}
#profileimg{
	width:120px;
	height:120px;
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
.btn1{
  margin:-5px;
  border: 1.3px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
.btn1:hover {
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
	     	<span style="font-size:20px;">업체목록</span>
	     	<div id="mypage_line_0"></div>
	     	<table id="profilebox">
	     		<tr>
	     			<th style="width:150px;">업체사진</th><th>상호명</th><th>사업자<br>등록번호</th><th style="width:300px;">삭제 / 상세 / 블랙리스트</th>
	     		</tr>
	     	<c:forEach var="storeList" items="${storeList}">
	     		<tr>
	     		<c:choose>
					<c:when test="${storeList.simg eq null}">
						<td><img src="resources/img/logo/로고2.png" id="profileimg"></td></c:when>
					<c:otherwise>
						<td><img src="resources/img/Profile/${storeList.simg}" id="profileimg"></td>
					</c:otherwise>
				</c:choose>
	     			<td>${storeList.storename}</td>
	     			<td>${storeList.snumber}</td>
	     			<td style="width:300px;"><button onclick="storedelete('${storeList.sid}')" id="btn">삭제</button>
	     			<button onclick="adminstoreview('${storeList.sid}')" class="btn1">상세</button>
	     			<button onclick="storeblacklistadd('${storeList.sid}')" class="btn">정지</button></td>
	     		</tr>
	     	</c:forEach>
	     	</table>
	     </div>
	</div>
	
	

</body>
</html>