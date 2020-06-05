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

<style>
	#menuAddForm{
		width:700px;
		margin:auto;
	}
	.subject{
		font-size:20px;
		font-weight:300;
		margin-right:10px;
	}
</style>


</head>
<body>
<jsp:include page="../storeProfile.jsp"></jsp:include>
	<div class="article">
	     <jsp:include page="../sideMenu.jsp"></jsp:include>
	     <jsp:include page="../storeSideNav.jsp"></jsp:include>
	     <div id="main">
	     	<span style="font-size:20px;">메뉴추가</span>
	     	<div id="mypage_line_0"></div>
		     <form action="menuadd" method="post" enctype="multipart/form-data">
		     <input type="text" name="sid" value="${sessionScope.storeId}" style="display:none">
		     <table id="menuAddForm">
			     <tr>
			     	<td><span class="subject">메뉴명</span></td>
			     	<td><input type="text" name="menuname" placeholder="메뉴명"></td>
			     </tr>
			     <tr>
			     	<td><span class="subject">가격</span></td>
			     	<td><input type="number" name="menuprice" placeholder="가격"></td>
			     </tr>
			     <tr>
		     		<td><span class="subject">설명</span></td>
		     		<td><input type="text" name="menudesc" placeholder="설명"></td>
		     	</tr>
		     	<tr>
		     		<td><span class="subject">조리시간(분)</span></td>
		     		<td><input type="number" name="menutime" placeholder="조리시간(분)"></td>
		     	</tr>
		     	<tr>
		     		<td><span class="subject">대표이미지</span></td>
		     		<td><input type="file" name="menuimgfile"></td>
		     	</tr>
		     	<tr>
			     	<td><span class="subject">카테고리1</span></td>
			     	<td><select name="mcategory1">
			     		<option value="한식" selected="selected">한식</option>
			     		<option value="중식">중식</option>
			     		<option value="일식">일식</option>
			     		<option value="분식">분식</option>
			     		<option value="야식">야식</option>
			     		<option value="아시안/양식">아시안/양식</option>
			     		<option value="치킨">치킨</option>
			     		<option value="피자">피자</option>
			     		<option value="족발">족발</option>
			     		<option value="패스트푸드">패스트푸드</option>
			     		<option value="디저트">디저트</option>
			     	</select></td>
		     	</tr>
		     	<tr>
		     		<td><span class="subject">카테고리2</span></td>
		     		<td><select name="mcategory2">
				     		<option value="면" selected="selected">면</option>
				     		<option value="밥">밥</option>
				     		<option value="빵">빵</option>
				     		<option value="육류">육류</option>
				     		<option value="생선">생선</option>
				     		<option value="국물">국물</option>
				     		<option value="볶음">볶음</option>
				     		<option value="죽">죽</option>
				     		<option value="찜">찜</option>
				     		<option value="샐러드">샐러드</option>
		     		</select></td>
		     	</tr>
		     	<tr>
			     	<td><span class="subject">카테고리3</span></td>
			     	<td><select name="mcategory3">
			     		<option value="매운맛" selected="selected">매운맛</option>
			     		<option value="단맛">단맛</option>
			     		<option value="고소한맛">고소한맛</option>
			     		<option value="깔끔한맛">깔끔한맛</option>
			     		<option value="느끼한맛">느끼한맛</option>
			     		<option value="기름진맛">기름진맛</option>
			     		<option value="짠맛">짠맛</option>
			     		<option value="개운한맛">개운한맛</option>
			     	</select></td>
		     	</tr>
		     	</table>
		     	<input type="submit" value="추가" style="">
		     </form>
	     </div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>