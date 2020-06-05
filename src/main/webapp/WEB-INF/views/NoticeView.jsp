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
	function noticelist(page) {
		location.href="noticelist";
	}
</script>
<style>
.voucheraddbox{
	width:900px;
	margin:auto;
	border: 0.5px solid lightgray;
	margin-bottom: 200px;
	text-align:left;
	margin-top:20px;
}
.inputbox{
	border:none;
	border-bottom: 0.5px solid lightgray;
	width: 890px;
	padding-left:10px;
	text-align:left;
	padding-top:10px;
	padding-bottom:10px;
	font-weight:300;
}
.textbox{
	border:none;
	border-bottom: 0.5px solid lightgray;
	width: 890px;
	height: auto;
	text-align:left;
	font-weight:300;
	padding-top:10px;
	padding-bottom:10px;
}
.thbox{
	border:none;
	background-color:rgb(252,210,211);
	width:100px;
	color: black;
	font-weight:500;
}
.imgbox{
	text-align:center;
}
.btn:hover{
  border: 2px solid;
  border-color: rgb(252,210,211);
  background-color: white;
  color: rgb(252,210,211);
}
.btn {
  background-color: rgb(252,210,211);
  color: white;
  font-size: 14px;
  cursor: pointer;
  width: 100px;
  padding: 14px 28px;
  border:2px solid rgb(252,210,211);
}
.noticeimg{
	width:300px;
	height:300px;
}
.filebox{
	width: 400px;
	margin-left: 5px;
}
.main{
	width:900px;
	margin:auto;
}
.noticeImg{
	width:850;
	margin:auto;
}
.contentimg{
	width:500px;
	height:auto;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	
	<div class="article">
		<jsp:include page="sideMenu.jsp"></jsp:include>
	     <div class="main">
	     	<img src="resources/img/notice/공지사항.jpg" class="noticeImg">
	     	<table class="voucheraddbox">
	     		<tr>
	     			<th class="thbox">글번호</th>
	     			<td class="inputbox">${notice.nnum}</td>
	     		</tr>
	     		<tr>
	     			<th class="thbox">작성일자</th>
	     			<td class="inputbox">${notice.ndate}</td>
	     		</tr>
	     		<tr>
	     			<th class="thbox">제목</th>
	     			<td class="inputbox">${notice.ntitle}</td>
	     		</tr>
	     		<tr>
	     			<td class="textbox" colspan="2">
	     				<div class="imgbox">
	     				<c:if test="${notice.nfiletype ne '자료'}">
	     					<img src="resources/img/notice/${notice.nfile}" class="contentimg">
	     				</c:if>
	     				</div>
	     				<br><br>
	     			${notice.ncontents}</td>
	     		</tr>
	     		<tr>
	     			<c:if test="${notice.nfiletype ne '이미지'}">
	     			<td class="filebox" colspan=2><a href="resources/img/notice/${notice.nfile}" download="${notice.nfile}">파일다운로드</a></td>
	     			</c:if>
	     		</tr>
	     		<tr>
	     			<td class="filebox" colspan="2"><button onclick="noticelist()" class="btn">목록</button></td>
	     		</tr>
	     	</table>
	     </div>
	</div>
	
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>