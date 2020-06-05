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
	function memberview(nuum){
	    var url = "memberview?mid="+mid;
	    var name = "회원상세조회";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	}
	
	function noticedelete(nnum) {
		location.href="noticedelete?nnum="+nnum+"&loginId='${sessionScope.loginId}'";
	}
	function noticemodifyselect(nnum) {
		location.href="noticemodifyselect?nnum="+nnum+"&loginId='${sessionScope.loginId}'";
	}
</script>
<style>
#voucheraddbox{
	width:500px;
	margin:auto;
	border:0.5px solid;
	border-color: rgb(95, 0, 128);
	border-radius: 8px;
	padding:10px;
	text-align:center;
	margin-bottom: 200px;
	margin-top: 100px;
}
.inputbox{
	border:none;
	border-bottom: 0.5px solid grey;
	width: 400px;
	margin-left: 5px;
}
.textbox{
	border:none;
	border-bottom: 0.5px solid grey;
	width: 400px;
	height: 500px;
	margin-left: 5px;
}
.btn{
  border-radius:20px;
  border: 1.3px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 9px 18px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
.btn:hover {
  border-radius:20px;
  border: 1.3px solid;
  background-color: rgb(95, 0, 128);
  color: white;
  padding: 9px 18px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
.noticeimg{
	width:300px;
	height:300px;
}
.filebox{
	width: 400px;
	margin-left: 5px;
}
</style>
</head>
<body>
	<jsp:include page="../adminProfile.jsp"></jsp:include>
	
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
		<jsp:include page="../adminSideNav.jsp"></jsp:include>
	     <div id="main">
	     	<span style="font-size:20px;">공지사항</span>
	     	<div id="mypage_line_0"></div>
	     	<table id="voucheraddbox">
	     		<tr>
	     			<td class="inputbox">글번호 : ${notice.nnum}</td>
	     		</tr>
	     		<tr>
	     			<td class="inputbox">작성일자 : ${notice.ndate}</td>
	     		</tr>
	     		<tr>
	     			<td class="inputbox">${notice.ntitle}</td>
	     		</tr>
	     		<tr>
	     			<td class="textbox">${notice.ncontents}</td>
	     		</tr>
	     		<tr>
	     			<c:if test="${notice.nfiletype ne '자료'}">
	     			<td><img src="resources/img/notice/${notice.nfile}" class="noticeimg"></td>
	     			</c:if>
	     		</tr>
	     		<tr>
	     			<c:if test="${notice.nfiletype ne '이미지'}">
	     			<td class="filebox"><a href="resources/img/notice/${notice.nfile}" download="${notice.nfile}">파일다운로드</a></td>
	     			</c:if>
	     		</tr>
	     		<tr>
	     			<td><button onclick="noticedelete('${notice.nnum}')" class="btn">삭제</button>
	     			<button onclick="noticemodifyselect('${notice.nnum}')" class="btn">수정</button></td>
	     		</tr>
	     	</table>
	     </div>
	</div>
	
	
</body>
</html>