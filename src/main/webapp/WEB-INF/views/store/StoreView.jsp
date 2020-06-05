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
<script	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6c81933e16fee6283245fb492563ff94&libraries=services"></script>
<script>
	var page = 1;
	$(document).ready(function(){
		var sid = "${store.sid}";
			$(".storeView_btn").hover(function(){
				$(this).css("background-color","rgb(206,206,206)");
			},function(){
				$(".storeView_btn").css("background-color","white");
			});
			
			$("#menu_btn").click(function(){
				$(".storeView_btn").css("border-bottom","1px solid lightgray");
				$(this).css("border-bottom","3px solid rgb(95, 0, 128)");
				$(this).css("background-color","white");
				$(".storeView_content").css("display","none");
				$("#menu_content").css("display","block");
			});
			$("#review_btn").click(function(){
				$(".storeView_btn").css("border-bottom","1px solid lightgray");
				$(this).css("border-bottom","3px solid rgb(95, 0, 128)");
				$(this).css("background-color","white");
				$(".storeView_content").css("display","none");
				$("#review_content").css("display","block");
				page = 1;
				$.ajax({
					type:"post",
					url:"reviewlist",
					data:{"page":page,"sid":sid,"mid":"${sessionScope.loginId}"},
					dataType:"json",
					success:
						function(result){
							var output="<span style='padding-left:170px;'>리뷰 : ${reviewCount}개</span>"+
				    		"<div style='height:5px; width:660px; margin:auto; border-bottom:1px solid lightgray; margin-bottom:8px;'></div>";
							for(var i in result){
								if(result[i].rimg == null){
									output+="<div class='review' style='height:100px;' id='review"+result[i].rnum+"'>";	
								}else{
									output+="<div class='review' id='review"+result[i].rnum+"'>";
								}
			    				output+="<div class='review_info'>"+result[i].mid+"님&nbsp;&nbsp;&nbsp;<span class='rdate'>"+result[i].rdate+"</span>";
			    				output+="<button onclick='reviewReportFn("+result[i].rnum+")' class='reportBtn'>신고</button></div>";
			    				var star="";
			    				for(var j=0;j<Math.round(result[i].rrate);j++){
			    					star+="<i class='fas fa-star' style='color:rgb(95, 0, 128); font-size:13px'></i>";
			    				}
			    				for(var j=0;j<5-Math.round(result[i].rrate);j++){
			    					star+="<i class='fas fa-star' style='color:gray;font-size:13px'></i>";
			    				}
			    				output+=star+" "+"<span style='font-size:14px; font-weight:300; color:gray'>"+result[i].rrate+"</span>";
			    				
			    				if(result[i].recommend){
			    					output+="<button class='recommend_Btn' id='recommend_Btn"+result[i].rnum+"' onclick='cancelFn("+result[i].rnum+")'>"+
		    							"<i class='fas fa-thumbs-up' style='font-size:20px;'></i></button><span class='rhit' id='rhit"+result[i].rnum+"'>"+result[i].rhit+"</span>";	
			    				}else{
			    					output+="<button class='recommend_Btn' id='recommend_Btn"+result[i].rnum+"' onclick='recommendFn("+result[i].rnum+")'>"+
			    						"<i style='font-size:20px;' id='thumbs"+result[i].rnum+"' class='far fa-thumbs-up'></i></button><span class='rhit' style='float:right;'id='rhit"+result[i].rnum+"'>"+result[i].rhit+"</span>";
			    				}
			    				
			    				if(result[i].rimg != null){
			    					output+="<img src='resources/img/review/"+result[i].rimg+"'>";
			    				}
			    				output+="<div class='rcontent'>"+result[i].rcontents+"</div>";
			    				if(result[i].rcnum != 0){
			    					output+="<span style='font-weight:300'>&nbsp;&nbsp;&nbsp;사장님 답글 : "+result[i].rccontents+"</span>";
			    				}else{
			    					output+="<div style='width:100%; height:27px;'></div>";
			    				}
			    				output+="</div></div>";
							}
							$("#review_content").html(output);
					},error:
						function(){
						console.log("통신 실패");
					}
				});
			});
			
			$("#info_btn").click(function(){
				$(".storeView_btn").css("border-bottom","1px solid lightgray");
				$(this).css("border-bottom","3px solid rgb(95, 0, 128)");
				$(this).css("background-color","white");
				$(".storeView_content").css("display","none");
				$("#info_content").css("display","block");
				var output = $("#menu_content").html();
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 2 // 지도의 확대 레벨
				    };  
				
				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
				
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch('${store.sadrs1}', function(result, status) {
				
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				
				        // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });
				
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
				        var infowindow = new kakao.maps.InfoWindow({
				            content: '<div style="width:150px; text-align:center;padding:6px 0;">'+"${store.storename}"+'</div>'
				        });
				        infowindow.open(map, marker);
				
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});    
				
			});
	});
	
	$(window).scroll(function() {
		if ($(window).scrollTop() == $(document).height() - $(window).height()) {
			if($("#review_content").css("display") == "block"){
				page++;
				$.ajax({
					type:"post",
					url:"reviewlist",
					data:{"page":page,"sid":'${store.sid}',"mid":"${sessionScope.loginId}"},
					dataType:"json",
					success:
						function(result){
						console.log(page);
						var output= $("#review_content").html();
			    		"<div style='height:5px; width:660px; margin:auto; border-bottom:1px solid lightgray; margin-bottom:8px;'></div>";
						for(var i in result){
							if(result[i].rimg == null){
								output+="<div class='review' style='height:100px;' id='review"+result[i].rnum+"'>";	
							}else{
								output+="<div class='review' id='review"+result[i].rnum+"'>";
							}
		    				output+="<div class='review_info'>"+result[i].mid+"님&nbsp;&nbsp;&nbsp;<span class='rdate'>"+result[i].rdate+"</span>";
		    				output+="<button onclick='reviewReportFn("+result[i].rnum+")' class='reportBtn'>신고</button></div>";
		    				var star="";
		    				for(var j=0;j<Math.round(result[i].rrate);j++){
		    					star+="<i class='fas fa-star' style='color:rgb(95, 0, 128); font-size:13px'></i>";
		    				}
		    				for(var j=0;j<5-Math.round(result[i].rrate);j++){
		    					star+="<i class='fas fa-star' style='color:gray;font-size:13px'></i>";
		    				}
		    				output+=star+" "+"<span style='font-size:14px; font-weight:300; color:gray'>"+result[i].rrate+"</span>";
		    				
		    				if(result[i].recommend){
		    					output+="<button class='recommend_Btn' id='recommend_Btn"+result[i].rnum+"' onclick='cancelFn("+result[i].rnum+")'>"+
	    							"<i class='fas fa-thumbs-up' style='font-size:20px;'></i></button><span class='rhit' id='rhit"+result[i].rnum+"'>"+result[i].rhit+"</span>";	
		    				}else{
		    					output+="<button class='recommend_Btn' id='recommend_Btn"+result[i].rnum+"' onclick='recommendFn("+result[i].rnum+")'>"+
		    						"<i style='font-size:20px;' id='thumbs"+result[i].rnum+"' class='far fa-thumbs-up'></i></button><span class='rhit' id='rhit"+result[i].rnum+"'>"+result[i].rhit+"</span>";
		    				}
		    				
		    				if(result[i].rimg != null){
		    					output+="<img src='resources/img/review/"+result[i].rimg+"'>";
		    				}
		    				output+="<div class='rcontent'>"+result[i].rcontents+"</div>";
		    				
		    				if(result[i].rcnum != 0){
		    					output+="<span style='font-weight:300'>&nbsp;&nbsp;&nbsp;ㄴ사장님 : "+result[i].rccontents+"</span>";
		    				}else{
		    					output+="<div style='width:100%; height:27px;'></div>";
		    				}
		    				output+="</div></div>";
						}
						$("#review_content").html(output);
					},error:
						function(){
						console.log("통신 실패");
					}	
				});
			}
		}
	});
	function bookingForm(){
		if("${sessionScope.loginId}" == ""){
			alert("로그인 후 이용가능한 기능입니다.");
		}else{
			location.href="bookingform?sid=${store.sid}";
		}
	}
	function countMinus(countInput){
		var count = parseInt(document.getElementById(countInput).value)-1;
		if(count<1){
			count=1;
		}
		document.getElementById(countInput).value = count;
	}
	
	function countPlus(countInput){
		var count = parseInt(document.getElementById(countInput).value)+1;
		document.getElementById(countInput).value = count;
	}
	
	function addCart(menunum){
		var storename = '${store.storename}';
		var sid = '${store.sid}';
		var mid = "${sessionScope.loginId}";
		var menunum = menunum;
		var menuname = $("#menuname"+menunum).text();
		var menuprice = parseInt($("#menuprice"+menunum).text().slice(0,-1).replace(",",""));
		var camount = parseInt($("#camount"+menunum).val());
		console.log(camount);
		$.ajax({
			type:"post",
			url:"cartadd",
			data:{"mid":mid, "sid":sid, "storename":storename, "menunum":menunum, "menuname":menuname, "menuprice":menuprice, "camount":camount},
			dataType:"text",
			success:
				function(result){
					if(result == "success"){
						alert("장바구니에 추가되었습니다.");
					}else if(result=="overlap"){
						alert("장바구니에는 하나의 가게메뉴만 담을 수 있습니다.");
					}else{
						alert("장바구니 추가에 실패하였습니다.");
					}
			},error:
				function(){
					console.log("통신실패");
			}
		});
	}
	
	function recommendFn(rnum){
		if("${sessionScope.loginId}" == ""){
			alert("로그인 후 이용가능한 기능입니다.");
		}else{
			$.ajax({
			type:"post",
			url:"reviewrecommend",
			data:{mid:"${sessionScope.loginId}",rnum:rnum},
			dataType:"text",
			success:
				function(result){
					if(result=="success"){
						alert("추천이 완료되었습니다.");
						var rhit = $("#rhit"+rnum).text();
						console.log(parseInt(rhit)+1)
						$("#rhit"+rnum).text(parseInt(rhit)+1);
						$("#recommend_Btn"+rnum).html("<i class='fas fa-thumbs-up' style='font-size:20px;'></i>");
						$("#recommend_Btn"+rnum).attr("onclick","cancelFn("+rnum+")");
					}
			},error:
				function(){
					console.log("통신실패");
				}
			});
		}
	}
	
	function cancelFn(rnum){
		if("${sessionScope.loginId}" == ""){
			alert("로그인 후 이용가능한 기능입니다.");
		}else{
			$.ajax({
			type:"post",
			url:"recommendcancel",
			data:{mid:"${sessionScope.loginId}",rnum:rnum},
			dataType:"text",
			success:
				function(result){
					if(result=="success"){
						alert("추천이 취소되었습니다.");
						var rhit = $("#rhit"+rnum).text();
						$("#rhit"+rnum).text(parseInt(rhit)-1);
						$("#recommend_Btn"+rnum).html("<i class='far fa-thumbs-up' style='font-size:20px;'></i>");
						$("#recommend_Btn"+rnum).attr("onclick","recommendFn("+rnum+")");
					}
			},error:
				function(){
					console.log("통신실패");
				}
			});
		}
	}
	
	function reviewReportFn(rnum){
		if("${sessionScope.loginId}" == ""){
			alert("로그인 후 이용가능한 기능입니다.");
		}else{
			$.ajax({
				type:"post",
				url:"reviewreport",
				data:{mid:"${sessionScope.loginId}",rnum:rnum},
				dataType:"text",
				success:
					function(result){
						if(result=="success"){
							alert("신고되었습니다.");
						}else if(result=="overlap"){
							alert("신고는 한번만 가능합니다.");
						}
				},error:
					function(){
						console.log("통신실패");
				}
			});
		}
	}
	
</script>

<style>

.recommend{
	width:280px;
	height:35px;
	padding:2px;
	float:left;
	text-align:right;
}

.fa-thumbs-up{
	margin-top:2px;
	font-size:23px;
}

.fa-thumbs-up:hover{
	cursor:pointer;
}

.addCartBtn{
	margin-top:8px;
	border-radius:50px;
	background-color:rgb(232,223,240);
	border:none;
}

.addCartBtn:hover{
	cursor:pointer;
}

.recommend_Btn{
	border:none;
	background:none;
}
</style>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
    
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
		
		<div id="top_profile_object">
			<span id="rate"><fmt:formatNumber value="${reviewRate}" pattern=".0"/> / 
			</span><span style="font-size:30px;font-weight:300">5</span>
			<span style="font-size:15px; font-weight:300">(${reviewCount})</span><br>
			<c:forEach var="i" begin="1" end="${reviewRate}" step="1">
				<i class="fas fa-star" id="star_yellow"></i>
			</c:forEach>
			<c:choose>
				<c:when test="${(5-reviewRate)%1 ne 0}">
					<c:forEach var="i" begin="1" end="${6-reviewRate}" step="1">
						<i class="fas fa-star" id="star_gray"></i>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="i" begin="1" end="${5-reviewRate}" step="1">
						<i class="fas fa-star" id="star_gray"></i>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<br>
			<br>
			<button id="booking_btn" onclick="bookingForm()">예약하기</button>
		</div>
	</div>
	
    <div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
    	<div id="storeView_main">
    		<div id="buttons">
		    	<div id="menu_btn" class="storeView_btn">메뉴</div>
		    	<div id="review_btn" class="storeView_btn">리뷰</div>
		    	<div id="info_btn" class="storeView_btn">지도</div>
	    	</div>
	    	<div class="storeView_content" id="menu_content">
	    		<c:forEach var="menu" items="${menuList}">
	    			<div class="menuList">
	    				<img src="resources/img/menuImage/${menu.menuimg}" class="menuImg">
	    				<div class="menuInfo">
	    					<span style="font-size:20px;font-weight:400" id="menuname${menu.menunum}" value="${menu.menuname}">${menu.menuname}</span><br>
	    					<span style="color:gray;font-weight:100; font-size: 13px;">${menu.menudesc}</span><br>
	    					<table id="menuInfo_table">
	    					<tr>
	    						<td>
	    							<span style="font-weight:400">${menu.menutime}분 소요<br></span>
	    						</td>
	    						<td style="text-align:right;">
	    							<button class="count_btn" id="count_minus" onclick="countMinus('camount${menu.menunum}')"><i class="fas fa-minus"></i></button>
	    							<input type="number" class="camount" id="camount${menu.menunum}" value="1" readonly>
	    							<button class="count_btn" id="count_plus" onclick="countPlus('camount${menu.menunum}')"><i class="fas fa-plus"></i></button> 
	    						</td>
	    					</tr>
	    					<tr>
	    						<td style="width:200px;">
	    						<span style="font-weight:400" id="menuprice${menu.menunum}"><fmt:formatNumber value="${menu.menuprice}" type="number"/>원</span>
	    						</td>
	    						<td style="text-align:right; width:170px;">
	    							<button class="addCartBtn" onclick="addCart('${menu.menunum}')" style="width:99px; height:25px;">장바구니</button>
	    						</td>
	    					</tr>
	    					</table>
	    				</div>
					</div>
	    		</c:forEach>
    		</div>
	    	<div class="storeView_content" id="review_content">
	    	</div>
	    	
	    	<div class="storeView_content" id="info_content" style="margin-bottom:10px;">
	    		<div id="map" style="width:990px; height:350px; margin-bottom:20px; border:1px solid lightgray;"></div>
	    		주소 ${store.sadrs1} (지번 ${store.sadrs2})
			<div>
			
			</div>
	    	</div>
    	</div>
    </div>
    <jsp:include page="../footer.jsp"></jsp:include>
    
</body>
</html>