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
<script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name = "google-signin-client_id"content = "41945232468-5mp6fhoi7leeotgcnil7lqlnv9sv6ej5.apps.googleusercontent.com">
<title>Insert title here</title>
	<script>
		function loginFn(){
			memberlogin.submit();
		}
		function joinFn(){
			location.href = "memberjoinform";
		}
		function onSignIn(googleUser) {
		  var profile = googleUser.getBasicProfile();
		  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
		  console.log('Name: ' + profile.getName());
		  console.log('Image URL: ' + profile.getImageUrl());
		  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
		  
		   $.ajax({
			 type:"post",
			 url:"checkgoogleid",
			 data:{mid: profile.getId(),
				 memail: profile.getEmail()
			 },
			 resultType:"text",
			 success: 
				 function(result){
				 console.log("통신 성공");
				 console.log("result값:"+result);
				 if(result == "OK"){
					 location.href = "googleloginok?mid="+profile.getId()+"&memail="+profile.getEmail();
				 }else{
					 location.href = "googlejoinform?mid="+profile.getId()+"&memail="+profile.getEmail()
							 +"&mnickname="+profile.getName();
				 }
			 },
			 error : function(){
				 console.log("통신 실패");
			 }
		  }); 
		}
		
	</script>
	<style>
	
	.login input{
		border: 0.5px solid #ccc;
		width: 340px;
		height: 54px;
		border-radius: 5px;
		text-align: left;
		padding: 10px;
	}
	#loginBtn{
		background-color: rgb(95, 0, 128);
		border: rgb(95, 0, 128);
		color: white;
		margin-top: 10px;
		margin-bottom: 5px;
		border-radius: 5px;
	}
	#joinBtn{
		background-color: white;
		border: 1px solid rgb(95, 0, 128);
		color: rgb(95, 0, 128);
		margin-top: 5px;
		margin-bottom: 10px;
		border-radius: 5px;
	}
	#loginBtn, #joinBtn{
		width: 340px;
		height: 54px;
	}
	.login{
		margin: 50px;
	}
	#naverLogin, #kakaoLogin{
		margin: 5px;
		width: 222px; 
		height: 49px;
	}
	
	
	</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
	<div class="body">
		 <div class="login">
            <h2>로그인</h2>
        		<form action="memberlogin" method="post" name="memberlogin">
	        		<table style="margin-left: auto; margin-right: auto;">
	        			<tr>
				            <td><input type="text" name="mid" id="mid" placeholder="아이디를 입력해주세요"></td>
			        	</tr>
			        	<tr>		        	
				            <td><input type="password" name="mpassword" id="mpassword" placeholder="비밀번호를 입력해주세요"></td>
			           	</tr>
	        		</table>
        		</form>
        			<button onclick="loginFn()" id="loginBtn">로그인</button><br>
        			<button onclick="joinFn()" id="joinBtn">회원가입</button><br>
					<a href="naverlogin">
						<img src="${pageContext.request.contextPath}/resources/img/login/네이버_아이디로_로그인_완성형_Green.png" id="naverLogin">
					</a><br>
					<a href="kakaologin">
						<img src="${pageContext.request.contextPath}/resources/img/login/kakao_account_login_btn_medium_narrow.png" id="kakaoLogin">
					</a><br>
					<button class="g-signin2" data-onsuccess="onSignIn" style="border: none;"></button>
        	</div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>