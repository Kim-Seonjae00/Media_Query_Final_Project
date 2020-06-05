<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(document).ready(function(){
	var currentPosition = parseInt($("#sideMenu").css("top"));
	$(window).scroll(function () {
	var position = $(window).scrollTop();
		if(position<200){
			$("#sideMenu").stop().animate({ "top": 400 + "px" }, 500);
		}else if(position>1600){
			$("#sideMenu").stop().animate({ "top": 2100 + "px" }, 500);
		}else{
			$("#sideMenu").stop().animate({ "top": position + currentPosition-170 + "px" }, 300);
		}
	});
});
function messageBtn(loginId){
    var url = "chattingroom?loginId="+loginId;
    var name = "채팅";
    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    window.open(url, name, option);
}
function messageCount(loginId, storeId){
	var mreceiver = null;
	if(loginId != ""){
		mreceiver = loginId;
	}else if(storeId != ""){
		mreceiver = storeId;
	}
		
	$.ajax({
		type: "post",
		url: "messagecount",
		data: {mreceiver: mreceiver},
		resultType: "text",
		success: 
			function(result){
			console.log("통신 성공");
			if(result == "YES"){
				$("#messageBtn").html("<i class='fas fa-envelope-open' style='color: rgb(255, 122, 107);'></i>");
			}else{
				$("#messageBtn").html("<i class='far fa-envelope'></i>")
			}
		},
		error: 
			function(){
			console.log("통신 실패");
		}
	});
	
}
function goCartList(){
	if("${sessionScope.loginId}" != ""){
		location.href="cartlist?mid=${sessionScope.loginId}";
	}else{
		alert("로그인이 필요한 기능입니다.");
		location.href="memberloginform";
	}
}

</script>
<style>
	.sideTab:hover{
		background-color: #eee;
	}
</style>
</head>
<body onload="messageCount('${sessionScope.loginId}','${sessionScope.storeId}')">
	<div id="sideMenu">
        <a href="#" onclick="goCartList(); return false;"><div class="sideTab"><i class="fas fa-shopping-cart"></i></div></a>
        <c:choose>
        	<c:when test="${sessionScope.loginId ne null}">
        		<a href="#" onclick="messageBtn('${sessionScope.loginId}')" >
	        		<div class="sideTab" id="messageBtn">
	        			<i class="far fa-envelope"></i>
	        		</div>
        		</a>
        	</c:when>
        	<c:when test="${sessionScope.storeId ne null}">
        		<a href="#" onclick="messageBtn('${sessionScope.storeId}')" >
	        		<div class="sideTab" id="messageBtn">
	        			<i class="far fa-envelope"></i>
	        		</div>
        		</a>
        	</c:when>
        	<c:otherwise>
        		<a href="memberloginform"><div class="sideTab"><i class="far fa-envelope"></i></div></a>
        	</c:otherwise>
        </c:choose>
        <a href="noticelist"><div class="sideTab"><i class="fas fa-bullhorn"></i></div></a>
        <a href="#"><div class="sideTab"><i class="fas fa-chevron-up"></i></div></a>
    </div>
</body>
</html>