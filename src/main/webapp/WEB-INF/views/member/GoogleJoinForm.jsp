<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">
<title>Insert title here</title>
	<script>
		function submitJoin(){
			if(blankCh() && phoneCheck()){	
				memberjoin.submit();
			}else{
				alert("가입형식에 맞지 않습니다.");
			}
		}
		
		function checkReset() {
			document.getElementById("pwResult").innerHTML = "";
		}
		
		//빈칸 검사
		function blankCh(){
			var contents=document.getElementsByClassName("required");
			var blank_ch = false;
			for(var i=0;i<contents.length;i++){
				if(contents[i].value == ""){
					blank_ch = false;
					break;
				}else{
					blank_ch = true;
				}
			}
			return blank_ch;
		}
		
		//핸드폰 번호 검사
		function phoneCheck() {
			var exp = /^\d{3}\d{4}\d{4}$/;
			var phone = document.getElementById("mphone");
			var phoneCheck = document.getElementById("phoneCheck");
			var check = false;
			if (phone.value.match(exp)) {
				phoneCheck.style.color = "green";
				phoneCheck.innerHTML = "유효한 전화번호입니다."
				check = true;
			} else {
				phoneCheck.style.color = "red";
				phoneCheck.innerHTML = "유효하지 않은 전화번호입니다."
				check = false;
			}
			return check;
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
	.joinform{
		background-color: white;
		margin:
	}
	.joinform input{
		border: 0.5px solid #ccc;
		width: 300px;
		height: 40px;
		border-radius: 5px;
	}
	.joinform th{
		text-align: left;
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
	td{
		text-align: left;
	}
	</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	
	<div class="body">
        <div class="joinform">
        	<a href="naverjoin">
				<img style="width: 65px; height: 65px;" 
					src="${pageContext.request.contextPath}/resources/img/login/naverlogo.png" id="naverJoin">
			</a>
			<a href="kakaojoin">
				<img style="width: 50px; height: 50px;" 
					src="${pageContext.request.contextPath}/resources/img/login/kakaolink_btn_medium.png" id="kakaoJoin">
			</a>
	        <h2>회원가입</h2>
	        <p> *필수입력사항</p>
			<form action="memberjoin" method="post" enctype="multipart/form-data" name="memberjoin">
			<table style="margin-left: auto; margin-right: auto;">
				<tr class="mid">
					<th>아이디*</th>
	            	<td colspan="2"><input type="text" name="mid" id="mid" value="${member.mid}" readonly>
	            </tr>    
	            <tr class="mpassword">
	                <td colspan="2"><input type="password" name="mpassword" id="mpassword" value="123456789" style="display:none;">	
	            </tr>
	            <tr class="mname">
	            	<th>이름*</th>
	            	<td colspan="2"><input type="text" name="mname" id="mname" class="required" placeholder="고객님의 이름을 입력해주세요"></td>
	            </tr>
	            <tr class="mphone">
	                <th>휴대전화*</th>
	                <td colspan="2"><input type="text" name="mphone" id="mphone" class="required" onblur="phoneCheck()" placeholder="숫자만 입력해 주세요">
	                	<span id="phoneCheck" style="font-size: 12px"></span></td>	 	
	            </tr>
	            <tr class="mnickname">
	            	<th>별명</th>
	            	<td colspan="2"><input type="text" name="mnickname" id="mnickname" value="${member.mnickname}"></td>
	            </tr>
	            <tr class="address">
	            	<th>주소*</th>
	                <td colspan="2"><input type="text" name="apostcode" id="sample4_postcode" class="required" placeholder="우편번호">
	                <input type="button" id="adrsBtn" class="required"onclick="sample4_execDaumPostcode()" value="우편번호 찾기"></td>
	            </tr>
	            <tr> 
	            	<th></th>
	                <td colspan="2"><input type="text" name="adrs1" id="sample4_roadAddress" class="required" placeholder="도로명주소"></td>
	            </tr>
	            <tr>
	            	<th></th>
					<td colspan="2"><input type="text" name="adrs2" id="sample4_jibunAddress" class="required" placeholder="지번주소"></td>
	            </tr>
	            <tr> 
	            	<th></th>
					<td colspan="2"><input type="text" name="adrs3" id="sample4_detailAddress" class="required" placeholder="상세주소"></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="text" name="adrs4" id="sample4_extraAddress" class="required" placeholder="참고항목"></td>
	            </tr>
	            <tr class="memail">
					<th>이메일*</th>
	             	<td colspan="2"><input type="email" name="memail" id="memail" class="required" value="${member.memail}" readonly>
	            </tr>
	            <tr class="mimg">
					<th>프로필</th>
	             	<td><input type="file" name="mimgfile" id="mimg"></td>
	            </tr>        
				<tr>
					<th></th>
					<td><input type="button" onclick="submitJoin()" id="joinBtn" value="회원가입"></td>
				</tr>
	        </table>
			</form>
		</div>
		<input id="idCheck" type="text" value="false" style="display:none;">
		<input id="emailCheck" type="text" value="false" style="display:none;">		
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>