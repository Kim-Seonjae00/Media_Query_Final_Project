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
			var idcheck = $("#idCheck").val() == "true";
			var emailcheck = $("#emailCheck").val() == "true";
			if('${kakaoId}'==null && '${naverId}'==null){
			if(idcheck && pwdCheck() && pwdConfirming() && blankCh() && phoneCheck() && emailcheck)	{
				memberjoin.submit();
			}else{
				alert("가입형식에 맞지 않습니다.");
			}
			}else{
				if(idcheck && blankCh() && phoneCheck() && emailcheck){
					memberjoin.submit();
				}else{
					alert("가입형식에 맞지 않습니다.");
				}
			}
		}
		//아이디 검사
		function idOverlap(){
			var inputId = document.getElementById("mid").value;
			var idCheck = document.getElementById("idResult");
			var exp = /^(?=.*[a-z])(?=.*\d)[a-z\d]{6,10}$/;
			var id = document.getElementById("mid");
			
			if (id.value.length == 0) {
				idCheck.style.color = "red";
				idCheck.innerHTML = "아이디 입력은 필수입니다."
			} else {
			$.ajax({
				type : "post",
				url : "idoverlap",
				data : {"id" : inputId},
				dataType : "text",
				success : function(result){
					console.log("통신 성공!");
					console.log("서버리턴값" + result);
					if(result == "OK"){
						idCheck.style.color="green";
						idCheck.innerHTML="사용가능한 아이디입니다.";
						$("#idCheck").val("true");
						if (id.value.length < 6 || id.value.length > 10
								|| !id.value.match(exp)) {
							idCheck.style.color = "red";
							idCheck.innerHTML = "유효하지 않은 아이디입니다."
							$("#idCheck").val("false");
						}
					}
					else{
						idCheck.style.color="red";
						idCheck.innerHTML="이미 사용중인 아이디입니다.";
						$("#idCheck").val("false");
					}
				},
				error : function(){
					console.log("통신 실패!");
				} 
			});
			}
		}
		
		//비밀번호 검사
		function pwdCheck() {
			var exp = /^(?=.*[a-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
			var pw1 = document.getElementById("mpassword");
			var pwdCheck = document.getElementById("pwResult");
			var check = false;
			if (pw1.value.match(exp)) {
				pwdCheck.style.color = "green";
				pwdCheck.innerHTML = "입력가능한 비밀번호입니다."
				check = true;
			} else {
				pwdCheck.style.color = "red";
				pwdCheck.innerHTML = "비밀번호를 다시 입력하세요."
				check = false;
			}
			return check;
		}
		
		//비밀번호 일치 검사
		function pwdConfirming(){
		    var pwd = document.getElementById("mpassword").value;
		    var pwdConfirm = document.getElementById("pwdConfirm").value;
		    var confirming = document.getElementById("pwConfirm");
		    var check = false;
		    if(pwd==pwdConfirm){
		        confirming.style.color = "green";
		        confirming.innerHTML = "비밀번호 일치"
		        check = true;
		    }else{
		        confirming.style.color = "red";
		        confirming.innerHTML = "비밀번호 불일치";
		        check = false;
		    }
		    return check;
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
		
		//이메일 인증키 보내기
		var emailCheck = 0;
		function createKey(){
			var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-z]{2,3}$/i;
			//이메일 정규식
			if(document.getElementById("memail").value != '' || emailReg.test(document.getElementById("memail").value)){
			//이메일이 공백이 아니고 이메일을 정규식에 맞게 입력했을시에 실행
				var email = document.getElementById("memail").value;
				$.ajax({
					type: "post",
					url: "createkey", 
					data: {"email":email},
					dataType:"text",
					success: function(result){
						alert('메일이 전송되었습니다.');
						emailCheck = 1;
					},
					error: function(){
						alert('이메일 인증 실패');
					}					
				});
			}else{
				alert("이메일을 입력해 주세요.");
			}	
		}
		
		//인증키 일치 확인
		function checkKey(){
			if(document.getElementById("emailkey").value != ''){
				var key = document.getElementById("emailkey").value;
				var keyResult = document.getElementById("emailKeyResult");
				$.ajax({
					type: "post",
					url: "checkkey", 
					data: {"key":key},
					dataType:"text",
					success: function(result){
						if(result == "1"){
							keyResult.style.color="green";
							keyResult.innerHTML="인증키가 일치합니다."
							$("#emailCheck").val("true");
						}else{
							keyResult.style.color="red";
							keyResult.innerHTML="인증키가 불일치합니다."
							$("#emailCheck").val("false");
						}
					},
					error: function(){
						alert('인증키 확인 실패');
					}					
				});
			}else{
				alert("인증키를 입력해 주세요.");
			}
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
	
	#checkKeyBtn, #emailSendBtn{
		width: 150px;
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
				<c:choose>
					<c:when test="${naverId ne null}">
						<tr class="mid">
							<th>아이디*</th>
			            	<td colspan="2"><input type="text" name="mid" id="mid" onkeyup="idOverlap()" placeholder="6-10자 영문과 숫자를 조합">
			            	<span id="idResult" style="font-size: 12px"></span>
			            	<td><input type="hidden" name="naverid" id="naverid" value="${naverId}"></td>	  
		            	</tr> 
					</c:when>
					<c:when test="${kakaoId ne null}">
						<tr class="mid">
							<th>아이디*</th>
			            	<td colspan="2"><input type="text" name="mid" id="mid" onkeyup="idOverlap()" placeholder="6-10자 영문과 숫자를 조합">
			            	<span id="idResult" style="font-size: 12px"></span>
			            	<td><input type="hidden" name="kakaoid" id="kakaoid" value="${kakaoId}"></td>	  
		            	</tr> 
					</c:when>
					<c:otherwise>
						<tr class="mid">
							<th>아이디*</th>
			            	<td colspan="2"><input type="text" name="mid" id="mid" onkeyup="idOverlap()" placeholder="6-10자 영문과 숫자를 조합">
			            	<span id="idResult" style="font-size: 12px"></span></td>  		
			            </tr>            
			            <tr class="mpassword">
			            	<th>비밀번호*</th>
			                <td colspan="2"><input type="password" name="mpassword" id="mpassword" onkeyup="pwdCheck()" placeholder="비밀번호를 입력해주세요">	
			                <span id="pwResult" style="font-size: 12px"></span></td>
			            </tr>
			            <tr class="pwdConfirm">
			            	<th>비밀번호 확인*</th>
			                <td colspan="2"><input type="password" name="pwdConfirm" id="pwdConfirm" onkeyup="pwdConfirming()" placeholder="비밀번호를 한번 더 입력해주세요">
			                <span id="pwConfirm" style="font-size: 12px"></span></td>      
			                          
			            </tr>
		            </c:otherwise>
	            </c:choose>
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
	            	<td colspan="2"><input type="text" name="mnickname" id="mnickname"></td>
	            </tr>
	            <tr class="address">
	            	<th>주소*</th>
	                <td colspan="2"><input type="text" name="apostcode" id="sample4_postcode" class="required" placeholder="우편번호">
	                <input type="button" id="adrsBtn" class="required" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"></td>
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
	             	<td colspan="2"><input type="email" name="memail" id="memail" class="required" placeholder="예: email@email.com">
	             	<input type="button" id="emailSendBtn" value="이메일 인증" onclick="createKey()"></td>
	            </tr>
	            <tr class="emailkey">
	           		<th>인증번호*</th>
	           		<td colspan="2"><input type="text" name="emailkey" id="emailkey" class="required">
	           		<input type="button" id="checkKeyBtn" value="확인" onclick="checkKey()"><br>
	           		<span id="emailKeyResult" style="font-size: 12px"></span></td>
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