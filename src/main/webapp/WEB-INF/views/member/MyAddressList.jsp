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
	function addressAdd(){
		$.ajax({
			type: "post",
			url: "addresscount",
			data: {"mid": '${sessionScope.loginId}'},
			dataType: "text",
			success: function(result){
				console.log("통신 성공");
				if(result == "OK"){
					location.href="addressform?mid=${sessionScope.loginId}";
				}else{
					alert("주소는 3개까지 등록 가능합니다.");
				}
			},
			error: function(){
				console.log("통신 실패!");
			}
		});
	}
	
	function aflagFn(anum){
		var aflag = document.getElementById("aflagBtn"+anum);
		$.ajax({
			type: "post",
			url: "addresspick",
			data: {"anum": anum,
					"mid": '${sessionScope.loginId}'
			},
			dataType: "text",
			success: function(result){
				console.log("통신 성공");
				if(result == "OK"){
					$(".aflagBtn").css("background-color","white");
					$(".aflagBtn").css("color","rgb(95, 0, 128)");
					$("#aflagBtn"+anum).css("background-color","rgb(95, 0, 128)");
					$("#aflagBtn"+anum).css("color","white");
				}else{
					alert("대표주소 변경 오류");
				}
			},
			error: function(){
				console.log("통신 실패!");
			}
		});
	}
	
	function deleteFn(anum){
		location.href="addressdelete?mid=${sessionScope.loginId}&anum="+anum;
	}
</script>
<style>
	.aflagBtn{
		width: 70px;
		border: 1px solid rgb(95, 0, 128);
		border-radius: 50px;
		padding: 8px;
	}
	#deleteBtn{
		width: 70px;
		color: rgb(95, 0, 128);
		background: white;
		border: 1px solid rgb(95, 0, 128);
		border-radius: 50px;
		padding: 8px;
	}
	#addBtn{
		width: 100px;
		border: 1px solid rgb(95, 0, 128);
		color: white;
		background: rgb(95, 0, 128);
		border-radius: 50px;
		margin: 20px;
		padding: 10px;
	}
	#addressList th{
		border-bottom: 1px solid #eee; 
		padding : 10px;
	}
	#addressList td{
		font-weight: 300;
		border-bottom: 1px solid #eee; 
		padding : 10px;
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
	     	<span style="font-size:20px;">배달 주소록</span>
	     	<div id="mypage_line_0"></div>
	     		<div id="addressList">
	     			<table style="margin-left: auto; margin-right: auto">
	     			<tr>
	     				<th style="width: 100px;">우편번호</th>
	     				<th style="width: 300px;">주소</th>
	     				<th style="width: 150px;">지번주소</th>
	     				<th>대표</th>
	     				<th>삭제</th>
	     			</tr>
	     			<c:forEach var="address" items="${addressList}">
	     			<tr>
	     				<td>${address.apostcode}</td>
	     				<td>${address.adrs1} ${address.adrs3} ${address.adrs4}</td>
	     				<td>${address.adrs2}</td>
	     				<td>
	     				<c:choose>
		     				<c:when test="${address.aflag eq 1}">
		     					<button class="aflagBtn" id="aflagBtn${address.anum}" onclick="aflagFn(${address.anum})"
		     					style="background:rgb(95, 0, 128); color:white;">대표</button></td>
		     				</c:when>
		     				<c:otherwise>
		     					<button class="aflagBtn" id="aflagBtn${address.anum}" onclick="aflagFn(${address.anum})" style="background:white; color: rgb(95, 0, 128);">대표</button>
		     				</c:otherwise>
	     				</c:choose>	
	     				<td><button id="deleteBtn" onclick="deleteFn(${address.anum})">삭제</button></td>
	     			</tr>
	     			</c:forEach>
	     			</table>
	     			<button id="addBtn" onclick="addressAdd()">주소 추가</button>
	     			
				</div>
	     	</div>
		</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>