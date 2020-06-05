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
		function pwdCheck(){
			var mid = '${sessionScope.loginId}';
			var mpassword = document.getElementById("mpassword").value;
			$.ajax({
				type: "post",
				url: "passwordcheck",
				data: {"mpassword":mpassword,
						"mid": mid
				},
				dataType: "text",
				success : function(result){
					console.log("통신 성공!");
					console.log("서버리턴값" + result);
					if(result == "OK"){
						if(confirm("탈퇴하시겠습니까?")){
							location.href="memberdelete?mid="+mid;
						}else{
							alert("탈퇴가 취소되었습니다.");
						}
					}
					else{
						alert("비밀번호가 일치하지 않습니다.");
					}
				},
				error : function(){
					console.log("통신 실패!");
				}
			});
		}
	</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../memberProfile.jsp"></jsp:include>
	
	<div class="article">
	
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	    <jsp:include page="../memberSideNav.jsp"></jsp:include>
	     
	     <div id="main">
	     	<span style="font-size:20px;">회원탈퇴</span>
	     	<div id="mypage_line_0"></div>
	     		<div id="memberdelete">
	     			
			     	<table style="margin-left: auto; margin-right: auto;">
			     		<th>비밀번호</th>
			     		<td><input type="password" name="mpassword" id="mpassword"></td>
			     		<td><input type="button" onclick="pwdCheck()" id="pwdCheck" value="확인"></td>
			     	</table>
				</div>
	     	</div>
		</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>