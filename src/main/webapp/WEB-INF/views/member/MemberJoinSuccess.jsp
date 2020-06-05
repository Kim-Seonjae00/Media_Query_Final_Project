<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src=""></script>
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
    <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">
<title>Insert title here</title>
	<script>
		function loginFn(){
			location.href = "memberloginform";
		}
		function homeFn(){
			location.href = "main";
		}
	</script>
	<style>
	#loginBtn{
		background-color: rgb(95, 0, 128);
		border: rgb(95, 0, 128);
		color: white;
		margin-top: 10px;
		margin-bottom: 5px;
	}
	#homeBtn{
		background-color: white;
		border: 1px solid rgb(95, 0, 128);
		color: rgb(95, 0, 128);
		margin-top: 5px;
		margin-bottom: 10px;
	}
	#loginBtn, #homeBtn{
		border-radius: 5px;
		width: 300px;
		height: 54px;
		font-size: 16px; 
	}
	.success{
		padding: 100px;
	}
	</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<div id="sideMenu">
        <a href=""><div class="sideTab"><i class="fas fa-shopping-cart"></i></div></a>
        <a href=""><div class="sideTab"><i class="far fa-envelope"></i></div></a>
        <a href=""><div class="sideTab"><i class="fas fa-bullhorn"></i></div></a>
        <a href="#"><div class="sideTab"><i class="fas fa-chevron-up"></i></div></a>
      </div>

	<div class="success">
		<h2>회원가입이 완료되었습니다.</h2>
	
		<button onclick="loginFn()" id="loginBtn">로그인</button>
    	<button onclick="homeFn()" id="homeBtn">홈으로</button>
	
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>