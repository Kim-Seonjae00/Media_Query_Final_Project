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
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 참고 항목 변수
	
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	
	            document.getElementById('sample4_postcode').value = data.zonecode;
	            document.getElementById("sample4_roadAddress").value = roadAddr;
	            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	            
	            if(roadAddr !== ''){
	                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	            } else {
	                document.getElementById("sample4_extraAddress").value = '';
	            }
	
	            var guideTextBox = document.getElementById("guide");
	            if(data.autoRoadAddress) {
	                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                guideTextBox.style.display = 'block';
	
	            } else if(data.autoJibunAddress) {
	                var expJibunAddr = data.autoJibunAddress;
	                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                guideTextBox.style.display = 'block';
	            } else {
	                guideTextBox.innerHTML = '';
	                guideTextBox.style.display = 'none';
	            }
	        }
	    }).open();
	}
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../memberProfile.jsp"></jsp:include>
	
	<div class="article">
	
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	    <jsp:include page="../memberSideNav.jsp"></jsp:include>
	     
	     <div id="main">
	     	<span style="font-size:20px;">주소 추가</span>
	     	<div id="mypage_line_0"></div>
	     		<div id="addressForm">
	     		<form action="addressadd" method="post">
	     			<h3>주소 등록</h3>
	     			<input type="text" name="mid" id="mid" value="${sessionScope.loginId}" style="display: none;">
					<table style="margin-left: auto; margin-right: auto;">
			            <tr>
			            	<td>우편번호</td>
			                <td><input type="text" name="apostcode" id="sample4_postcode" placeholder="우편번호"></td>
							<td><input type="button" id="adrsBtn" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"></td>
			            </tr>
			            <tr>
			            	<td>도로명 주소</td> 
			                <td><input type="text" name="adrs1" id="sample4_roadAddress" placeholder="도로명주소"></td>
						</tr>
						<tr>	
							<td>지번주소</td>
							<td><input type="text" name="adrs2" id="sample4_jibunAddress" placeholder="지번주소"></td>
			            </tr>
			            <tr> 
			            	<td>상세주소</td>
							<td><input type="text" name="adrs3" id="sample4_detailAddress" placeholder="상세주소"></td>
						</tr>
						<tr>	
							<td>참고항목</td>
							<td><input type="text" name="adrs4" id="sample4_extraAddress" placeholder="참고항목"></td>
			            </tr>
					</table>
					<input type="submit" id="addressBtn" value="추가">
				</form>
			</div>
	     </div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>