<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">
<title>Insert title here</title>
<script>
		function loginFn(){
			storelogin.submit();
		}
		function joinFn(){
			location.href = "storejoinform";
		}
	</script>
	<style>
	*{
		text-align: center;
		font-weight: 700;
	}
	#logo{
		width: 170px;
		height: 170px;
	}
	.login input{
		border: 0.5px solid #ccc;
		width: 340px;
		height: 54px;
		border-radius: 5px;
		text-align: left;
	}
	#loginBtn{
		background-color: rgb(95, 0, 128);
		border: rgb(95, 0, 128);
		color: white;
		margin-top: 10px;
		margin-bottom: 5px;
	}
	#joinBtn{
		background-color: white;
		border: 1px solid rgb(95, 0, 128);
		color: rgb(95, 0, 128);
		margin-top: 5px;
		margin-bottom: 10px;
	}
	#loginBtn, #joinBtn{
		border-radius: 5px;
		width: 340px;
		height: 54px;
	}
	.login{
		margin: 50px;
	}
	
	</style>
</head>
<body>
	<div class="body">
		 <div class="login">
		 	<a href="main"><img src="resources/img/logo/로고2.png" id="logo"></a>
            <h2>요기서요기 사장님 로그인</h2>
        		<form action="storelogin" method="post" name="storelogin">
	        		<table style="margin-left: auto; margin-right: auto;">
	        			<tr>
	        				<th>아이디</th>
				            <td><input type="text" name="sid" id="sid"></td>
			        	</tr>
			        	<tr>		       
			        		<th>비밀번호</th>  	
				            <td><input type="password" name="spassword" id="spassword"></td>
			           	</tr>
	        		</table>
        		</form>
        			<button onclick="loginFn()" id="loginBtn">로그인</button><br>
        			<button onclick="joinFn()" id="joinBtn">회원가입</button><br>
        	</div>
    </div>
</body>
</html>