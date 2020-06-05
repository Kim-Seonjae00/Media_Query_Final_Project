<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
	<script>
	function idOverlap(){
		var inputId = document.getElementById("sid").value;
		var idCheck = document.getElementById("idResult");
		var exp = /^(?=.*[a-z])(?=.*\d)[a-z\d]{6,10}$/;
		var id = document.getElementById("sid");
		
		if (id.value.length == 0) {
			idCheck.style.color = "red";
			idCheck.innerHTML = "아이디 입력은 필수입니다."
		} else if (id.value.length < 6 || id.value.length > 10
				|| !id.value.match(exp)) {
			idCheck.style.color = "red";
			idCheck.innerHTML = "유효하지 않은 아이디입니다."
		} else {
		$.ajax({
			type : "post",
			url : "sidoverlap",
			data : {"id" : inputId},
			dataType : "text",
			success : function(result){
				console.log("통신 성공!");
				console.log("서버리턴값" + result);
				if(result == "OK"){
					idCheck.style.color="green";
					idCheck.innerHTML="사용가능한 아이디입니다.";
				}
				else{
					idCheck.style.color="red";
					idCheck.innerHTML="이미 사용중인 아이디입니다.";
				}
			},
			error : function(){
				console.log("통신 실패!");
			} 
		});
		}
	}
	
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
	<style>
	*{
		text-align: center;
	}
	body{
		background-color: rgb(95, 0, 128);
	}
	#logo{
		width: 170px;
		height: 170px;
	}
	.joinform{
		background-color: white;
		margin: 0px;
		padding: 50px;
	}
	.joinform input{
		border: 0.5px solid #ccc;
		width: 300px;
		height: 40px;
		border-radius: 5px;
	}
	#scategory{
		width: 15px;
		height: 15px;
		
	}
	.joinform th{
		text-align: left;
	}
	
	#checkKeyBtn, #emailSendBtn{
		width: 150px;
		margin-left: -30px;
	}
	#adrsBtn{
		width: 150px;
	}
	#joinBtn{
		width: 350px;
		height: 50px;
		background-color: rgb(95, 0, 128);
		border: none;
		margin: 20px;
		color: white;
	}
	
	</style>
</head>
<body>
	<a href="main"><img src="resources/img/logo/로고1.png" id="logo"></a>
		<div class="joinform">
			<h2>회원가입</h2>
	        <p> *필수입력사항</p>
			<form action="storejoin" method="post" enctype="multipart/form-data">
			<table style="margin-left: auto; margin-right: auto;">
				<tr class="sid">
					<th>아이디*</th>
	            	<td><input type="text" name="sid" id="sid" onkeyup="idOverlap()" placeholder="6-10자 영문과 숫자를 조합"><br>
	            	<span id="idResult" style="font-size: 15px"></span>  		            	
	            </tr>            
	            <tr class="spassword">
	            	<th>비밀번호*</th>
	                <td><input type="password" name="spassword" id="spassword" onkeyup="pwdCheck()" placeholder="비밀번호를 입력해주세요"><br>	
	                <span id="pwResult" style="font-size: 15px"></span>
	            </tr>
	            <tr class="pwdConfirm">
	            	<th>비밀번호 확인*</th>
	                <td><input type="password" name="pwdConfirm" id="pwdConfirm" onkeyup="pwdConfirming()" placeholder="비밀번호를 한번 더 입력해주세요"><br>
	                	<span id="pwConfirm" style="font-size: 15px"></span></td>	           		            
	            </tr>
	            <tr class="sname">
	            	<th>대표자명*</th>
	            	<td><input type="text" name="sname" id="sname" placeholder="고객님의 이름을 입력해주세요"></td>
	            </tr>
	            <tr class="snumber">
	            	<th>사업자 등록번호*</th>
	            	<td><input type="text" name="snumber" id="snumber" placeholder="사업자 등록번호를 등록해 주세요"></td>
	            </tr>
	            <tr class="storename">
	            	<th>상호명*</th>
	            	<td><input type="text" name="storename" id="storename" placeholder="상호명을 입력해주세요"></td>
	            </tr>
	            <tr class="sphone">
	                <th>전화번호*</th>
	                <td><input type="text" name="sphone" id="sphone" placeholder="전화번호를 입력해주세요"></td>	 	             
	            </tr>
	            <tr class="address">
	            	<th>주소*</th>
	                <td><input type="text" name="spostcode" id="sample4_postcode" placeholder="우편번호"></td>
					<td><input type="button" id="adrsBtn" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"></td>
	            </tr>
	            <tr> 
	            	<th></th>
	                <td><input type="text" name="sadrs1" id="sample4_roadAddress" placeholder="도로명주소"></td>
					<td><input type="text" name="sadrs2" id="sample4_jibunAddress" placeholder="지번주소"></td>
	            </tr>
	            <tr> 
	            	<th></th>
					<td><input type="text" name="sadrs3" id="sample4_detailAddress" placeholder="상세주소"></td>
					<td><input type="text" name="sadrs4" id="sample4_extraAddress" placeholder="참고항목"></td>
	            </tr> 
	            <tr class="simg">
					<th>대표사진</th>
	             	<td><input type="file" name="simgfile" id="simg"></td>
	            </tr> 
	            <tr class="scategory">
					<th>음식점 분류*</th>
	             	<td colspan="2">
	             	<input type="radio" name="scategory" id="scategory" value="한식">한식
	             	<input type="radio" name="scategory" id="scategory" value="중식">중식
	             	<input type="radio" name="scategory" id="scategory" value="일식/돈까스">일식/돈까스
	             	</td>
	             <tr>
	             	<th></th>
	             	<td colspan="2">
	             	<input type="radio" name="scategory" id="scategory" value="치킨">치킨
	             	<input type="radio" name="scategory" id="scategory" value="피자">피자
	             	<input type="radio" name="scategory" id="scategory" value="패스트푸드">패스트푸드
	             	</td>
	             </tr>
	             <tr>
	             	<th></th>
	             	<td colspan="2">
	             	<input type="radio" name="scategory" id="scategory" value="야식">야식
	             	<input type="radio" name="scategory" id="scategory" value="분식">분식
	             	<input type="radio" name="scategory" id="scategory" value="족발/보쌈">족발/보쌈
	             	</td>
	             </tr>
	             <tr>	
	             	<th></th>
	             	<td colspan="2">
	             	<input type="radio" name="scategory" id="scategory" value="아시안/양식">아시안/양식
	             	<input type="radio" name="scategory" id="scategory" value="디저트">디저트
	             	</td>
				</tr>
				<tr>	
					<td><input id="joinBtn" type="submit" value="회원가입"></td>
				</tr>
	        </table>
			</form>
		</div>
</body>
</html>