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
function storeConfirmFn(sid){
	var checkPw = document.getElementById("checkPw").value;
	if(checkPw == '${store.spassword}'){
		alert("신청이 완료되었습니다.");
		location.href="storeconfirm?sid="+sid;
	}else{
		alert("비밀번호가 일치하지 않습니다.");
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
			   	<span style="font-size:20px;">음식점 등록신청</span>
		   	<div id="mypage_line_0"></div>
		     <c:if test="${store.running eq 2}">
		     	음식점 등록이 완료되었습니다.
		     </c:if>
		     <c:if test="${store.running eq 1}">
		     	검토 중입니다.
		     </c:if>
		     <c:if test="${store.running eq 0}">
				비밀번호 확인 : <input type="password" id="checkPw">
				<button onclick="storeConfirmFn('${sessionScope.storeId}')">등록 신청</button>
		     </c:if>
	     </div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>