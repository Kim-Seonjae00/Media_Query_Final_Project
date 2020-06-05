<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/adminpage.css">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
<title>공지사항등록</title>
<style>
body{
	margin:0;
}	

.voucheraddbox{
	width:500px;
	margin:auto;
	border:0.5px solid;
	border-color: rgb(95, 0, 128);
	border-radius: 8px;
	padding:50px;
	text-align:center;
	margin-bottom: 200px;
	margin-top: 100px;
}
.inputbox{
	width: 400px;
	margin-left: 5px;
}
.textbox{
	width: 400px;
	height: 500px;
	margin-left: 5px;
}
.btn{
  border: 2px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 14px 28px;
  font-size: 14px;
  cursor: pointer;
  width: 150px;
}
.btn:hover {
  background-color: rgb(95, 0, 128);
  color: white;
}
</style>
</head>
<body>
    	<jsp:include page="../adminProfile.jsp"></jsp:include>
   
   	<div class="article">
   		<jsp:include page="../sideMenu.jsp"></jsp:include>
		<jsp:include page="../adminSideNav.jsp"></jsp:include>
	     <div id="main">
	     	<span style="font-size:20px;">공지사항 등록</span>
	     	<div id="mypage_line_0">
			</div>
			<form action="noticewrite?loginId=${sessionScope.loginId}" method="post" name="noticewrite" enctype="multipart/form-data" class="voucheraddbox">
		    		<h2>공지사항 등록</h2><br>
					작성자<br>
					<input type="text" value="관리자" name="nid" class="inputbox" readonly><br><br>
					제목<br>
					<input type="text" name="ntitle" class="inputbox"><br><br>
					내용<br> 
					<textarea name="ncontents" class="textbox"></textarea><br><br>
					첨부파일<br> 
					<input type="file" name="nfilefile" class="inputbox">
					<br><br>
					<input type="submit" value="등록" class="btn">
				</form><br>
	     </div>
		
    </div>
    
	
</body>
</html>