<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.outline{
	width:100%;
	height:100%;
	text-align:center;
	margin:auto;
}
.inline{
	margin-top:20px;
	padding:10px;
	text-align:center;
	border: 0.7px solid lightgray;
	border-radius:20px;
}
#profileImg {	
	vertical-align: middle;
	width: 200px;
	height: 200px;
	border-radius: 50%;
}
#storebox th{
	background-color: rgb(232,223,240);
	width:150px;
	padding:10px;
	border-top:0.7px solid lightgray;
}
#storebox td{
	border-top:0.7px solid lightgray;
	width:300px;
	padding:10px;
}
#profileImg{
	border: 0.7px solid lightgray;
}
.btn{
  border-radius:20px;
  border: 1.3px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
.btn:hover {
  border-radius:20px;
  border: 1.3px solid;
  background-color: rgb(95, 0, 128);
  color: white;
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
</style>
</head>
<body>
<div class="outline">
			<c:choose>
				<c:when test="${storeView.simg eq null}">
					<img src="resources/img/logo/로고2.png" id="profileImg">
				</c:when>
				<c:otherwise>
					<img src="resources/img/Profile/${storeView.simg}" id="profileImg">
				</c:otherwise>
			</c:choose>
	<div class="inline">
		<table id="storebox">
		<tr>
			<th style="border-top:none;">아이디</th>
			<td style="border-top:none;">${storeView.sid}</td>
		</tr>
		<tr>
			<th>대표자명</th>
			<td>${storeView.sname}</td>
		</tr>
		<tr>
			<th>사업자등록번호</th>
			<td>${storeView.snumber}</td>
		</tr>
		<tr>
			<th>상호명</th>
			<td>${storeView.storename}</td>
		</tr>
		<tr>
			<th>음식점전화번호</th>
			<td>${storeView.sphone}</td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td>${storeView.spostcode}</td>
		</tr>
		<tr>
			<th>도로명주소</th>
			<td>${storeView.sadrs1}</td>
		</tr>
		<tr>
			<th>지번주소</th>
			<td>${storeView.sadrs2}</td>
		</tr>
		<tr>
			<th>상세주소</th>
			<td>${storeView.sadrs3}</td>
		</tr>
		<tr>
			<th>참고주소</th>
			<td>${storeView.sadrs4}</td>
		</tr>
		<tr>
			<th>음식점분류</th>
			<td>${storeView.scategory}</td>
		</tr>
		<tr>
			<th>총매출</th>
			<td>${storeView.sales}</td>
		</tr>
		<tr>
			<th>평점</th>
			<td>${rrate}</td>
		</tr>
		<tr>
			<th>음식점승인여부</th>
			<c:choose>
				<c:when test="${storeView.running eq 0}">
					<td style="color:grey;">승인되지 않음</td>
				</c:when>
				<c:when test="${storeView.running eq 1}">
					<td style="color:lightpurple;">심사중</td>
				</c:when>
				<c:otherwise>
					<td style="color:purple;">운영가능</td>
				</c:otherwise>
			</c:choose>
		</tr>
		<tr>
			<th>정지여부</th>
			<c:choose>
				<c:when test="${storeView.sblock eq 0}">
					<td style="color:green;">운영가능</td>
				</c:when>
				<c:otherwise>
					<td style="color:red;">정지상태</td>
				</c:otherwise>
			</c:choose>
		</tr>
		<tr>
			<th>맛집카테고리</th>
			<td>${storeView.matcategory}</td>
		</tr>
	</table><br>
	</div>
	<form action="getmatcategory?sid=${storeView.sid}" method="post">
		<select name="matcategory">
			<option value="고깃집">고깃집</option>
			<option value="술집">술집</option>
			<option value="냉면">냉면집</option>
			<option value="돈가스">돈가스집</option>
			<option value="디저트">디저트</option>
		</select>
		<input type="submit" value="저장" class="btn">
	</form>
</div>
</body>
</html>