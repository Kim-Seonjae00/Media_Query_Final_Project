<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/cd5c7a4640.js"
	crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap"rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/mypage.css">
<script>
function pwCheck(){
	if(confirm("정말로 탈퇴하시겠습니까?")){
		var spassword = '${store.spassword}';
		var passwordCheck = $("#passwordCheck").val();
		location.href="storedelete?sid=${sessionScope.storeId}&passwordcheck="+passwordCheck;
	}else{
		alert("탏퇴가 취소되었습니다.");
	}
}
</script>
</head>
<body>
	<jsp:include page="../storeProfile.jsp"></jsp:include>
	
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	     <jsp:include page="../storeSideNav.jsp"></jsp:include>
	     
	     <div id="main">
	     	<span style="font-size:20px;">업체탈퇴</span>
	     	<div id="mypage_line_0"></div>
	     	<input type="password" id="passwordCheck" placeholder="비밀번호 확인">
	     	<button onclick="pwCheck()">탈퇴</button>
	     </div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>