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

<style>
	#reviewList td{
		font-weight: 300;
		text-align: left;
		padding: 10px;
		
	}
	#mypage_line_1{
		height:0px;
		border-bottom:1px solid #ccc;
	}
	pre{
		text-align: left;
		padding-left: 10px; 
	}
	#rImg{
		width:740px;
		height:300px;
	}
	#deleteBtn{
		width: 100px;
		border: 1px solid rgb(95, 0, 128);
		color: rgb(95, 0, 128);
		background: white;
		border-radius: 50px;
		margin: 5px;
		padding: 10px;
	}
</style>
<script>
function reviewDeleteFn(rnum){
	if(confirm("정말로 삭제하시겠습니까?")){
		alert("삭제되었습니다.");
		location.href="reviewdelete?rnum="+rnum+"&mid=${sessionScope.loginId}";
	}else{
		alert("취소되었습니다.");
	}
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
	     	<span style="font-size:20px;">리뷰내역</span>
	     	<div id="mypage_line_0"></div>
	     		<div id="reviewList">
	     			<c:forEach var="review" items="${reviewList}">
	     			<div id="rnum">
	     			<pre>리뷰번호      ${review.rnum}<button onclick="reviewDeleteFn(${review.rnum})" style="margin-left:550px;" id="deleteBtn">삭제</button></pre>
	     			</div>
	     			<div id="mypage_line_1"></div>
	     			<table>
	     			<tr>
	     				<td>${review.rdate}</td>
	     			</tr>
	     			<tr>
	     				<c:choose>
	     					<c:when test="${review.rimg ne null}">
	     						<td><img id="rImg" src="resources/img/review/${review.rimg}"></td>
	     					</c:when>
	     				</c:choose>
	     			</tr>
	     			<tr>
	     				<td>${review.rcontents}</td>
	     			</tr>
	     			<tr>	
	     				<td>${review.rrate}점</td>
	     			</tr>
	     			<tr>
	     				<td><i class="far fa-thumbs-up"></i> ${review.rhit}</td>
	     			</tr>
	     			</table>
	     			<div id="mypage_line_1"></div>
	     			</c:forEach>
				</div>
	     	</div>
		</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>