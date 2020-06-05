<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">

<script>
	function sendMessage(form) {
		// 내용 유효성 검사
		form.mcontents.value = form.mcontents.value.trim();
		if (form.mcontents.value.length == 0) {
			alert('내용 입력하세요');
			form.mcontents.focus();
			return false;
		}
		
		$.ajax({
			type:"post",
			url:"addMessage",
			data:{mreceiver:form.mreceiver.value,
				msender:form.msender.value,
				mcontents:form.mcontents.value},
			resultType:"json",
			success:
				function(result){
				console.log("성공");
				$('#mcontents').val("");
				Chat__loadNewMessages();
			},
			error:
				function(){
				console.log("실패");
			}
		});
	}
	
	
	function Chat__loadNewMessages() {
		var mreceiver = $("#mreceiver").val();
		var msender = $("#msender").val();
		var mcontents = $("#mcontents").val();		
		$.ajax({
			type:"get",
			url:"getMessage",
			data: {mreceiver:mreceiver,
				msender:msender,
				mcontents:mcontents},
			resultType:"json",
			success:
				function(result){
				console.log("성공")
				$('.chat-list').html("");
				for (var i = 0; i < result.length; i++) {					
					var message = result[i];
					Chat__lastReceivedMessageId = message.mnum;
					Chat__drawMessages(message);
				}
				var offset = $('#mcontents').offset();
				$('html').animate({scrollTop:offset.top},1);
				
				setTimeout(Chat__loadNewMessages,500);
			},
			error:
				function(){
				console.log("실패");
			}
		});
	}
	
	function Chat__drawMessages(message) {
		if(message.msender == "${sender.senderid}"){
			var html = "<div><img src='resources/img/Profile/${sender.senderimg}' id='profileImg'><b>"+ "${sender.sendername}" + "</b></div><div>" + message.mcontents + "</div>";
			$('.chat-list').prepend('<div style="text-align:left; padding: 5px; margin: 5px; font-size:15px;">' + html + '</div>');
		}else{
			var html = "<div><b>"+ message.msender + "</b></div><div>" + message.mcontents + "</div>";
			$('.chat-list').prepend('<div style="text-align:right; padding: 5px; margin: 5px; font-size:15px;">' + html + '</div>');
		}
	}
	
	function messageBtn(loginId){
	    var url = "chattingroom?loginId="+loginId; 
	    var name = "채팅";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	} 
	
</script>
<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
	#backBtn{
		color: white;
		font-size: 25px;
	}
	#backBtn:hover{
		color: #ddd;
	}
	#message{
		position: fixed;
		width: 100%;
		height: 30px;
		text-align: left;
		background-color: rgb(136, 164, 187);
		padding:20px;
		margin-top:-5px; 
	}
	a{
		text-decoration: none; 
	}
	.chat{
		position: fixed;
		bottom: 0;
		width: 100%;
		margin: 0;
	}
	body{
		min-height: 100%;
		background-color: rgb(178, 199, 217);
		margin:0;
	}
	#mcontents{
		width: 410px;
		height: 40px;
		border: none;
		float: left;
		padding: 5px;
	}
	#send{
		width: 62px;
		height: 50px;
		border: none;
		background-color: rgb(255,235,51);
		float: left;
		padding: 5px;
	}
	#profileImg{
		width: 50px;
		height: 50px;
		margin: 5px;
		border-radius: 50px;
	}
</style>

</head>
<body onload="Chat__loadNewMessages();">
	<div id="message">
		<c:choose>
			<c:when test="${sessionScope.loginId ne null}">
				<a href="#" onclick="messageBtn('${sessionScope.loginId}')" id="backBtn"><i class="fas fa-arrow-circle-left"></i></a>	
			</c:when>
			<c:when test="${sessionScope.storeId ne null}">
				<a href="#" onclick="messageBtn('${sessionScope.storeId}')" id="backBtn"><i class="fas fa-arrow-circle-left"></i></a>
			</c:when>
		</c:choose>
		<span style="font-weight: 700; font-size: 20px;">&emsp;&emsp;${sender.sendername}</span>
	</div>
		<div class="List" style="padding-top: 60px; padding-bottom: 60px;">
			<div class="chat-list"></div>
		</div>
		<div class="chat">
			<form onsubmit="sendMessage(this); return false;">
				<input type="text" name="mreceiver" id="mreceiver" value="${sender.senderid}" style="display:none;"><br>
				<c:choose>
					<c:when test="${sessionScope.loginId ne null}">
						<input type="text" name="msender" id="msender" value="${sessionScope.loginId}" style="display:none;"><br>
					</c:when>
					<c:when test="${sessionScope.storeId ne null}">
						<input type="text" name="msender" id="msender" value="${sessionScope.storeId}" style="display:none;"><br>
					</c:when>
				</c:choose>
				<input type="text" name="mcontents" id="mcontents" placeholder="서비스와 관계없는 메시지는 삭제될 수 있습니다."></input>
				<input type="submit" id="send" value="전송">
			</form>
		</div>
</body>
</html>