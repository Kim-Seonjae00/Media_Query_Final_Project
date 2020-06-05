<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/cd5c7a4640.js"crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap"rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	font-family: 'Noto Sans KR', sans-serif;
}
#reviewImg{
	vertical-align: middle;
	width: 100px;
	height: 100px;
	border-radius: 10%;
}
#profileImg {
	vertical-align: middle;
	width: 200px;
	height: 200px;
	border-radius: 50%;
}
#memberbox{
	border: 0.7px solid lightgray;
	
}

#memberbox th{
	background-color: rgb(232,223,240);
	width:250px;
	padding:5px;
	border-bottom: 0.7px solid lightgray;
	border-right: 0.7px solid lightgray;
}
#memberbox td{
	font-weight:300;
	width:300px;
	padding:5px;
	border-bottom: 0.7px solid lightgray;
}
#reviewbox{
	border: 0.7px solid lightgray;
}

#reviewbox th{
	background-color: rgb(232,223,240);
	width:230px;
	border-right: 0.7px solid lightgray;
}
#reviewbox td{
	font-weight:300;
	width:230px;
	border-top: 0.7px solid lightgray;
	border-right: 0.7px solid lightgray;
}
.outline{
	text-align: center;
	height:100%;
	width:100%
}
.inline{
	height: 100%;
	margin:auto;
	width:90%;
	display:block;
	margin-top:20px;
	padding:30px;
}
</style>
</head>
<body>
	<div class="outline">
		<div class="inline">
			<c:choose>
				<c:when test="${member.mimg eq null}">
					<img src="resources/img/logo/로고2.png" id="profileImg">
				</c:when>
				<c:otherwise>
					<img src="resources/img/memberProfile/${member.mimg}" id="profileImg">
				</c:otherwise>
			</c:choose>
			<br><br>
			<table id="memberbox">
				<tr>
					<th>아이디</th>
					<td>${member.mid}</td>
				</tr>
				<tr>
					<th>카카오아이디</th>
					<td>${member.naverid}</td>
				</tr>
				<tr>
					<th>네이버아이디</th>
					<td>${member.kakaoid}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${member.mname}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${member.memail}</td>
				</tr>
				<tr>
					<th>휴대폰번호</th>
					<td>${member.mphone}</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>${member.mnickname}</td>
				</tr>
				<tr>
					<th>누적사용금액</th>
					<td>${member.mtotalprice}</td>
				</tr>
				<tr>
					<th>멤버십등급</th>
					<td>${member.mgrade}</td>
				</tr>
				<tr>
					<th>보유포인트</th>
					<td>${member.mpoint}</td>
				</tr>
				<tr>
					<th style="border-bottom:none;">정지여부</th>
					<c:choose>
						<c:when test="${member.mblock eq 0}">
							<td style="color:green; border-bottom:none;">이용가능</td>
						</c:when>
						<c:otherwise>
							<td style="color:red; border-bottom:none;">정지상태</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
			<br>
			<h2>대표주소</h2>
				<table id="memberbox">
					<tr>
						<th>우편번호</th>
						<td>${address.apostcode}</td>
					</tr>
					<tr>
						<th>도로명주소</th>
						<td>${address.adrs1}</td>
					</tr>
					<tr>
						<th>지번주소</th>
						<td>${address.adrs2}</td>
					</tr>
					<tr>
						<th>상세주소</th>
						<td>${address.adrs3}</td>
					</tr>
					<tr>
						<th style="border-bottom:none;">참고주소</th>
						<td style="border-bottom:none;">${address.adrs4}</td>
					</tr>
				</table>

			<br>
			<h2>리뷰목록</h2>
			<table id="reviewbox">
				<tr>
					<th>업체<br>아이디</th>
					<th>평점</th>
					<th>추천/<br>신고</th>
					<th>작성일자</th>
					<th>리뷰<br>내용</th>
					<th style="border-right:none;">리뷰사진</th>
				</tr>
				<c:forEach var="memberReviewList" items="${memberReviewList}">
					<tr>
						<td>${memberReviewList.sid}</td>
						<td>${memberReviewList.rrate}</td>
						<td>${memberReviewList.rhit}/${memberReviewList.rreport}</td>
						<td>${memberReviewList.rdate}</td>
						<td>${memberReviewList.rcontents}</td>
						<c:choose>
							<c:when test="${memberReviewList.rimg eq null}">
								<td style="border-right:none;"><img src="resources/img/noimg" id="reviewImg"></td>
							</c:when>
							<c:otherwise>
								<td style="border-right:none;"><img src="resources/img/review/${memberReviewList.rimg}" id="reviewImg"></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

</body>
</html>