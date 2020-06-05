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
<script>

$(document).ready(function(){
	var categoryList = document.getElementsByClassName("category1");
	for(var i=0;i<categoryList.length;i++){
		if(categoryList[i].value == "${store.scategory}"){
			categoryList[i].setAttribute("checked","checked");
		}
	}
});

function pwdCheck() {
	var exp = /^(?=.*[a-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
	var pw1 = document.getElementById("spassword");
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
    var pwd = document.getElementById("spassword").value;
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

function checkReset() {
	document.getElementById("pwResult").innerHTML = "";
}

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
	<jsp:include page="../storeProfile.jsp"></jsp:include>
	
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	     <jsp:include page="../storeSideNav.jsp"></jsp:include>
	     
	     <div id="main">
	     	<span style="font-size:20px;">업체 정보수정</span>
	     	<div id="mypage_line_0"></div>
	     	<form action="storemodify" method="post" enctype="multipart/form-data">
			<table style="margin-left: auto; margin-right: auto;">
				<tr class="sid">
					<th>아이디*</th>
	            	<td><input type="text" name="sid" id="sid" value="${store.sid}" readonly><br>
	            	<span id="idResult" style="font-size: 15px"></span>  		            	
	            </tr>            
	            <tr class="spassword">
	            	<th>비밀번호*</th>
	                <td><input type="password" name="spassword" id="spassword" onkeyup="pwdCheck()" value="${store.spassword}"><br>	
	                <span id="pwResult" style="font-size: 15px"></span>
	            </tr>
	            <tr class="pwdConfirm">
	            	<th>비밀번호 확인*</th>
	                <td><input type="password" name="pwdConfirm" id="pwdConfirm" onkeyup="pwdConfirming()" placeholder="비밀번호를 한번 더 입력해주세요"><br>
	                	<span id="pwConfirm" style="font-size: 15px"></span></td>	           		            
	            </tr>
	            <tr class="sname">
	            	<th>대표자명*</th>
	            	<td><input type="text" name="sname" id="sname" value="${store.sname}"></td>
	            </tr>
	            <tr class="snumber">
	            	<th>사업자 등록번호*</th>
	            	<td><input type="text" name="snumber" id="snumber" value="${store.snumber}"></td>
	            </tr>
	            <tr class="storename">
	            	<th>상호명*</th>
	            	<td><input type="text" name="storename" id="storename" value="${store.storename}"></td>
	            </tr>
	            <tr class="sphone">
	                <th>전화번호*</th>
	                <td><input type="text" name="sphone" id="sphone" value="${store.sphone}"></td>	 	             
	            </tr>
	            <tr class="address">
	            	<th>주소*</th>
	                <td><input type="text" name="spostcode" id="sample4_postcode" value="${store.spostcode}" placeholder="우편번호"></td>
					<td><input type="button" id="adrsBtn" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"></td>
	            </tr>
	            <tr> 
	            	<th></th>
	                <td><input type="text" name="sadrs1" id="sample4_roadAddress" value="${store.sadrs1}" placeholder="도로명주소"></td>
					<td><input type="text" name="sadrs2" id="sample4_jibunAddress" value="${store.sadrs2}" placeholder="지번주소"></td>
	            </tr>
	            <tr> 
	            	<th></th>
					<td><input type="text" name="sadrs3" id="sample4_detailAddress" value="${store.sadrs3}" placeholder="상세주소"></td>
					<td><input type="text" name="sadrs4" id="sample4_extraAddress" value="${store.sadrs4}" placeholder="참고항목"></td>
	            </tr> 
	            <tr class="simg">
					<th>대표사진</th>
	             	<td><input type="file" name="simgfile" id="simg"></td>
	             	<td><input type="text" name="simg" value="${store.simg}"></td>
	            </tr> 
	            <tr class="scategory">
					<th>음식점 분류*</th>
	             	<td colspan="2">
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="한식">한식
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="중식">중식
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="일식/돈까스">일식/돈까스
	             	</td>
	             <tr>
	             	<th></th>
	             	<td colspan="2">
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="치킨">치킨
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="피자">피자
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="패스트푸드">패스트푸드
	             	</td>
	             </tr>
	             <tr>
	             	<th></th>
	             	<td colspan="2">
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="야식">야식
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="분식">분식
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="족발/보쌈">족발/보쌈
	             	</td>
	             </tr>
	             <tr>	
	             	<th></th>
	             	<td colspan="2">
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="아시안/양식">아시안/양식
	             	<input type="radio" name="scategory" id="scategory" class="category1" value="디저트">디저트
	             	</td>
				</tr>
				<tr>	
					<td><input id="modifyBtn" type="submit" value="정보수정"></td>
				</tr>
	        </table>
			</form>
	     </div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>