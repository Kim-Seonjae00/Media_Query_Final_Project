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
	function adminreviewdelete(rnum) {
		location.href="adminreviewdelete?rnum="+rnum+"&loginId=${sessionScope.loginId}";
	}
	
	function memberview(mid){
	    var url = "memberview?mid="+mid;
	    var name = "회원상세조회";
	    var option = "width = 600, height = 700, top = 100, left = 200, location = no"
		    window.open(url, name, option);
	}
	
	function adminstoreview(sid){
	    var url = "adminstoreview?sid="+sid;
	    var name = "업체상세조회";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
		    window.open(url, name, option);
	}
	function memberblacklistadd(mid) {
		location.href="memberblacklistadd?mid="+mid+"&loginId=${sessionScope.loginId}";
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
#reviewimg{
	width:100px;
	heigth:80px;
	border:0.4px solid grey;
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
	     	<span style="font-size:20px;">신고된 리뷰 리스트</span>
	     	<div id="mypage_line_0"></div>
	     	<table id="profilebox">
	     		<tr>
	     			<th>리뷰사진</th><th>회원아이디</th><th>업체아이디</th><th>내용</th>
	     			<th>평점</th><th style="width:200px">삭제/회원정지</th>
	     		</tr>
	     	<c:forEach var="reportReviewList" items="${reportReviewList}">
	     		<tr>
					<c:choose>
						<c:when test="${reportReviewList.rimg eq null}">
							<td><img src="resources/img/noimg.jpg" id="reviewimg"></td>
						</c:when>
						<c:otherwise>
							<td><img src="resources/img/review/${reportReviewList.rimg}" id="reviewimg"></td>
						</c:otherwise>
					</c:choose>
	     			<td><a href="#" onclick="memberview('${reportReviewList.mid}')">${reportReviewList.mid}</a></td>
	     			<td><a href="#" onclick="adminstoreview('${reportReviewList.sid}')">${reportReviewList.sid}</a></td>
	     			<td>${reportReviewList.rcontents}</td>
	     			<td>${reportReviewList.rrate}</td>
	     			<td style="width:200px;"><button onclick="adminreviewdelete('${reportReviewList.rnum}')" id="btn">삭제</button>
	     			<button onclick="memberblacklistadd('${reportReviewList.mid}')" class="btn">정지</button></td>
	     		</tr>
	     	</c:forEach>
	     	</table>
	     </div>
	</div>

</body>
</html>