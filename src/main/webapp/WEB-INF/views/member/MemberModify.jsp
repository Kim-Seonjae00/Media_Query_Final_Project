<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
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
		function phoneCheck() {
			var exp = /^\d{3}-\d{4}-\d{4}$/;
			var phone = document.getElementById("mphone");
			var phoneCheck = document.getElementById("phoneCheck");
			if (phone.value.match(exp)) {
				phoneCheck.style.color = "green";
				phoneCheck.innerHTML = "유효한 전화번호입니다."
			} else {
				phoneCheck.style.color = "red";
				phoneCheck.innerHTML = "유효하지 않은 전화번호입니다."
			}
		}
		
		function pwdCheck() {
			var exp = /^(?=.*[a-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
			var pw1 = document.getElementById("mpassword");
			var pwdCheck = document.getElementById("pwResult");
			if (pw1.value.match(exp)) {
				pwdCheck.style.color = "green";
				pwdCheck.innerHTML = "입력가능한 비밀번호입니다."
			} else {
				pwdCheck.style.color = "red";
				pwdCheck.innerHTML = "비밀번호를 다시 입력하세요."
			}
		}
		
		function pwdConfirming(){
		    var pwd = document.getElementById("mpassword").value;
		    var pwdConfirm = document.getElementById("pwdConfirm").value;
		    var confirming = document.getElementById("pwConfirm");
		    if(pwd==pwdConfirm){
		        confirming.style.color = "green";
		        confirming.innerHTML = "비밀번호 일치"
		    }else{
		        confirming.style.color = "red";
		        confirming.innerHTML = "비밀번호 불일치";
		    }
		}
	</script>
	<style>
		#modifyForm{
			font-weight: 500;
		}
		#modifyForm th, td{
			text-align: left;
		}
		input{
			border: 1px solid gray;
			border-radius: 50px;
			padding: 6px;
		}
		#modifyBtn{
			border: 1px solid rgb(95, 0, 128);
			background-color: white;
			color: rgb(95, 0, 128);
			width: 100px;
		}
	</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../memberProfile.jsp"></jsp:include>
	
	<div class="article">
	
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	    <jsp:include page="../memberSideNav.jsp"></jsp:include>
	     
	     <div id="main">
	     	<span style="font-size:20px;">회원정보 수정</span>
	     	<div id="mypage_line_0"></div>
	     		<div id="modifyForm">
			     	<form action="membermodifyprocess" method="post" enctype="multipart/form-data">
					<table style="margin-left: auto; margin-right: auto;">
						<tr class="mid">
							<th>아이디</th>
			            	<td><input type="text" name="mid" id="mid" value="${member.mid}" readonly>
			            </tr>            
			            <tr class="mpassword">
			            	<th>새 비밀번호</th>
			                <td><input type="password" name="mpassword" id="mpassword" onkeyup="pwdCheck()"></td>
			                <td><span id="pwResult" style="font-size: 12px"></span></td>	
			            </tr>
			            <tr class="pwdConfirm">
			            	<th>새 비밀번호 확인</th>
			                <td><input type="password" name="pwdConfirm" id="pwdConfirm" onkeyup="pwdConfirming()"></td>	
			                <td><span id="pwConfirm" style="font-size: 12px"></span></td>	
			            </tr>
			            <tr class="mname">
			            	<th>이름</th>
			            	<td><input type="text" name="mname" id="mname" value="${member.mname}" readonly></td>
			            </tr>
			            <tr class="mphone">
			                <th>휴대전화</th>
			                <td><input type="text" name="mphone" id="mphone" value="${member.mphone}" onblur="phoneCheck()"></td>
			                <td><span id="phoneCheck" style="font-size: 12px"></span></td>	 	             
			            </tr>
			            <tr class="mnickname">
			            	<th>별명</th>
			            	<td><input type="text" name="mnickname" id="mnickname" value="${member.mnickname}"></td>
			            </tr>
						<tr class="memail">
							<th>이메일</th>
			             	<td><input type="email" name="memail" id="memail" value="${member.memail}"></td>
			            </tr>
			            <tr class="mimg">
							<th>프로필</th>
			             	<td colspan="2"><input type="file" name="mimgfile" id="mimg">${member.mimg}</td>
			             	<td><input type="text" name="mimg" id="mimg" value="${member.mimg}" style="display: none;"></td>
			            </tr>        
						<tr>
							<th></th>
							<td><input id="modifyBtn" type="submit" value="확인"></td>
						</tr>
			        </table>
				</form>
			</div>
	     </div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>