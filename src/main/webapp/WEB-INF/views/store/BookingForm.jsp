<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/mypage.css">
<link rel="stylesheet" href="resources/css/storeview.css">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
       crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">
<link href='resources/fullcalendar/core/main.css' rel='stylesheet' />
<link href='resources/fullcalendar/daygrid/main.css' rel='stylesheet' />

<script src='resources/fullcalendar/core/main.js'></script>
<script src='resources/fullcalendar/daygrid/main.js'></script>
<script src='resources/fullcalendar/core/locales/ko.js'></script>
<script src='resources/fullcalendar/interaction/main.js'></script>

<link rel="stylesheet" href="resources/css/default.css">
<link rel="stylesheet" href="resources/css/rtl.css">
<link rel="stylesheet" href="resources/css/default.time.css">

<script src='resources/pickatime/legacy.js'></script>
<script src='resources/pickatime/picker.js'></script>
<script src='resources/pickatime/picker.date.js'></script>
<script src='resources/pickatime/picker.time.js'></script>


<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
  
    var calendar = new FullCalendar.Calendar(calendarEl, {
        plugins: [ 'dayGrid','interaction'],
    	dateClick: function(info) {
			$(".fc-day").css("backgroundColor","");	    	
	    	$("#fc-day"+info.dateStr).css("backgroundColor","rgb(0,0,255,0.2)");
	    	$("#bdate").val(info.dateStr);
	  	},
    });
  
    calendar.render();
 });
 
 
$(document).ready(function(){
	
	$('.timepicker').pickatime({
		  format: 'H:i',
		  interval:60,
		  min:[11,0],
		  max:[20,0],
		  clear: '취소',
		  dynamic: false,
		  dropdown: true,
		  scrollbar: true
	});
	
	$(".check").click(function(){
		if($(".check").attr("class")=="far fa-check-circle check"){
			$(".check").attr("class","fas fa-check-circle check");
		}else{
			$(".check").attr("class","far fa-check-circle check");
		}
	});
	
	$(".viewInfo").click(function(){
		var id="#"+$(this).attr("id")+"Detail";
		if($(id).css("display") == "none"){
			$(this).html("보기<i style='margin-left:5px; font-size:18px;' class='fas fa-angle-up'></i>");
			$(id).css("display","block");
		}else{
			$(this).html("보기<i style='margin-left:5px; font-size:18px;' class='fas fa-angle-down'></i>");
			$(id).css("display","none");
		}
	});
});


</script>
<style>
#calendar{
	width:560px;
	height:500px;
	margin:auto;
}

#bookingForm{
	margin:auto;
	width:560px;
	float:left;
}

#bookingInfo{
	width:500px;
	float:left;
	height:100%;
	padding:30px;
	text-align:left;
}

.timepicker{
	width:100%;
}

.bookingForm_left{
	width:200px;
	text-align:left;
	font-size:19px;
	font-weight:500;
	
}

.bookingForm_right{
	width:460px;
	text-align:left;
	font-size:19px;
	font-weight:400;
}

form input{
	border:none;
	font-size:18px;
	font-weight:500;
	text-align:left;
}

form input:focus {
	outline:none;
}


#bookingTable{
	margin-top:20px;
	border-collapse: collapse;
}

#bookingTable tr, #bookingTable td{
	height:40px;
	border-bottom: 1px solid lightgray;
}

.check:hover{
	cursor:pointer;
}

.viewInfo:hover{
	cursor:pointer;
}

.viewInfoDetail{
	border:1px solid lightgray;
	margin:auto;
	overflow:scroll;
	width:470px;
	height:150px;
	text-align:left;
	margin-top:10px;
	margin-bottom:2px;
	display:none;
}

#bookingBtn{
	text-align: center;
	width: 150px;
	margin-top:15px;
	padding: 10px;
	border-radius: 50px;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
    
	<jsp:include page="../sideMenu.jsp"></jsp:include>
    <div id="top_profile" style="margin-bottom:30px;">
		<div id="top_profile_img"><!--프로필 사진 -->
			<c:choose>
				<c:when test="${store.simg ne null}">
					<img src="resources/img/Profile/${store.simg}" id="profileImg">
				</c:when>
				<c:otherwise>
					<img src="resources/img/logo/로고2.png" id="profileImg">
				</c:otherwise>
			</c:choose>
		</div>
		
		<div id="top_profile_contents"><!--프로필 내용-->
			<span style="font-size: 35px; font-weight:500;">${store.storename}</span>
			<span style="color:gray;">${store.scategory}</span><br>
			<div style="text-align:left; margin-top:10px; font-weight:400">
				<span style="color:gray;">연락처</span> ${store.sphone}<br>
				<span style="color:gray;">주소</span> ${store.spostcode} ${store.sadrs1} ${store.sadrs4}<br>
				<span style="color:gray;">최소주문금액</span> 15,000원<br>
				<span style="color:gray;">배달예상시간</span>
			</div> 
		</div>
	</div>
	

	<div style="width:1060px; margin:auto">
	<div id="bookingInfo">
		<img src="resources/img/booking/툴롱1.jpg" style="width:100%;">
		<p style="font-size:25px; margin-bottom:20px; font-weight:500;">${store.storename} 예약</p>
		<span style="font-weight:300; font-size:16px; text-align:left;" >- 8~30인까지 조절 되는 아늑한 단독룸<br>
		- 탁 트이고 시원한 분위기의 야외공간까지<br>
		<br>
		모임 성격에 맞춰 취향껏 고를 수 있는 편안한 공간을 정성껏 준비합니다.<br></span>
		<div style="width:450px; margin:auto; border-bottom:1px solid lightgray; height:20px; margin-bottom:20px;"></div>
		<span style="font-size:20px; padding-left:15px;">이미지</span>
		<img src="resources/img/booking/툴롱4.jpg" style="padding:15px; width:100%;">
		<img src="resources/img/booking/툴롱2.jpg" style="padding:15px; width:100%;">
	</div>
	<div id="bookingForm">
		<div style="height:20px;"></div>
		<div id='calendar'></div>
		<form action="booking?mid=${sessionScope.loginId}" method="post" style="width:560px;">
			<table style="width:100%" id="bookingTable">
				<tr class="">
					<td class="bookingForm_left">예약자</td>
					<td class="bookingForm_right"><input type="text" name="bname" placeholder="예약자명"></td>
				</tr>
				<tr>
					<td class="bookingForm_left">날짜</td>
					<td class="bookingForm_right"><input type="text" name="bdate" value="" placeholder="날짜선택" id="bdate" readonly></td>
				</tr>
				<tr>
					<td class="bookingForm_left">시간</td>
					<td class="bookingForm_right"><input type="text" name="btime" class="timepicker" placeholder="시간선택" readonly></td>
				</tr>
				<tr>
					<td class="bookingForm_left">인원</td>
					<td class="bookingForm_right"><input type="number" name="bpeople" value="1"></td>
				</tr>
			</table>
			<div id="checklist" style="padding-top:60px; padding-bottom:5px; border-bottom:1px solid lightgray;">
				<span style="font-size:17px; font-weight:500;"><i class="far fa-check-circle check" style="font-size:23px;"></i> 이용자 약관 전체동의</span><span style="font-size:15px; font-weight:300; margin-left:320px;">필수동의</span>
			</div>
			<div style="width:520px; border-bottom:1px solid lightgray; font-size:15px; font-weight:300;margin:auto;  padding-top:10px;padding-bottom:10px;">
				<i class="fas fa-minus" style="color:lightgray"></i> 개인정보 수집 동의
					<span class="viewInfo" id="viewInfoOffer" style="color:gray; margin-left:300px; text-decoration:underline;">보기<i style="margin-left:5px; font-size:18px;"class="fas fa-angle-down"></i></span>
					<div id="viewInfoOfferDetail" class="viewInfoDetail">
						<span>
							<개인정보 수집 동의><br>
							1. 기본수집항목: [필수] 네이버 아이디, 이름, (휴대)전화번호, [선택] 이메일 주소<br>
							※ 추가 수집하는 필수항목<br>
							- 배송, 방문 등이 필요한 상품 구매 시 : 주소<br>
							- 해외 여행 관련 상품 구매 시 : 여권상 영문명, 여권번호 끝 4자리, 성별, 생년월일, 이메일주소, 카카오톡ID, 동행 아동정보(여권상 영문명, 생년월일, 신장)<br>
							- 병원을 이용하는 경우: 생년월일<br>
							<br>
							2. 수집 및 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한 기록보존, 네이버 예약 이용 후 리뷰작성에 따른 네이버페이 포인트 지급 및 관련 안내<br>
							<br>
							3. 보관기간<br>
							- 회원탈퇴 등 개인정보 이용목적 달성 시까지 보관<br>
							- 단, 상법 및 ‘전자상거래 등에서의 소비자 보호에 관한 법률’ 등 관련 법령에 의하여 일정 기간 보관이 필요한 경우에는 해당 기간 동안 보관함<br>
							<br>
							4. 동의 거부권 등에 대한 고지: 정보주체는 개인정보의 수집 및 이용 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.<br>
						</span>
					</div>
				</div>
					
			<div style="width:520px; border-bottom:1px solid lightgray; font-size:15px; font-weight:300;margin:auto;  padding-top:10px;padding-bottom:10px;">
				<i class="fas fa-minus" style="color:lightgray"></i> 개인정보 제공 동의
					<span class="viewInfo" id="viewInfoCollect" style="color:gray; margin-left:300px; text-decoration:underline;">보기<i style="margin-left:5px; font-size:18px;"class="fas fa-angle-down"></i></span>
				<div id="viewInfoCollectDetail" class="viewInfoDetail">
					<span>
						<개인정보 제공 동의><br>
						1. 개인정보를 제공받는 자 : ${store.storename}<br>
						<br>
						2. 제공하는 기본 개인정보 항목:  [필수] 네이버 아이디, 이름, (휴대)전화번호, 성별, 연령대, [선택] 이메일 주소<br>
						※ 추가 제공하는 필수항목<br>
						- 배송, 방문 등이 필요한 상품 구매 시 : 주소<br>
						- 해외 여행 관련 상품 구매 시 : 여권상 영문명, 여권번호 끝 4자리, 생년월일, 이메일주소, 카카오톡ID, 동행 아동정보(여권상 영문명, 생년월일, 신장)<br>
						- 병원을 이용하는 경우: 생년월일<br>
						<br>
						3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 서비스 분석과 통계에 따른 혜택 및 맞춤 서비스 제공, 민원처리 등 고객상담, 고객관리, 서비스 이용에 따른 설문조사 및 혜택 제공, 분쟁조정을 위한 기록보존<br>
						<br>
						4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 : 네이버 회원탈퇴 시 또는 위 개인정보 이용목적 달성 시 까지 이용합니다.<br>
						<br>
						5. 동의 거부권 등에 대한 고지 : 정보주체는 개인정보 제공 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.
					</span>
				</div>
			</div>
			<div>
			
			</div>
					
			<input type="text" name="storename" value="${store.storename}" style="display:none;">
			<input type="text" name="sid" value="${store.sid}" style="display:none;">
			
			<input type="submit" value="예약하기" id="bookingBtn">
		</form>
	</div>
</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
