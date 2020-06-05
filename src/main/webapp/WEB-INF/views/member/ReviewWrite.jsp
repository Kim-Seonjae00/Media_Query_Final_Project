<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
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

	$(document).ready(function() {
		var currentPosition = parseInt($("#sideMenu").css("top"));
		$(window).scroll(function() {
			var position = $(window).scrollTop();
			if (position < 200) {
				$("#sideMenu").stop().animate({
					"top" : 400 + "px"
				}, 500);
			} else if (position > 1600) {
				$("#sideMenu").stop().animate({
					"top" : 2100 + "px"
				}, 500);
			} else {
				$("#sideMenu").stop().animate({
					"top" : position + currentPosition - 170 + "px"
				}, 300);
			}
		});
		$("#reviewimg").change(function() {
			$("#reviewImage").html("<img id='image_section' src='#' alt='your image' style='width:260px; height:200px;'/>");
			readURL(this);
		});
		
		$(".star-fas").click(function(){
			var id = $(this).attr("id");
			var value = parseInt(id.substring(4,5))+1;
			$("#starValue").val(id.substring(4,5));
			$(".star-fas").attr("class","far fa-star star-fas");
			for(var i=1;i<value;i++){
				var starId = "#star"+String(i);
				$(starId).attr("class","fas fa-star star-fas")
			}
		});
	});

	function readURL(input) {
		
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				$('#image_section').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}


	
</script>
<style>
#reviewForm {
	width: 100%;
	margin: auto;
	margin-top: 50px;
	margin-bottom: 30px;
}

#rcontents {
	border: none;
	background-color: rgb(245, 245, 245);
	padding: 10px;
	text-align: left;
	color: rgb(140, 140, 140);
	resize: none;
}

#rMenuInfo {
	text-align: left;
	padding: 10px;
}

.rordersInfo {
	padding-left: 20px;
	text-align: left;
	height: 33px;
	font-weight: 500;
}

#reviewWirte table td {
	border: 1px solid lightgray;
}

#reviewWirte table {
	border: 1px solid lightgray;
	border-collapse: collapse;
}

.reviewTable {
	padding: 20px;
	text-align: left;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	background-color: rgb(95, 0, 128);
	border: 1px solid rgb(95, 0, 128);
	color: white;
	line-height: normal;
	vertical-align: middle;
	cursor: pointer;
	-webkit-transition: background-color 0.2s;
	transition: background-color 0.2s;
}

.filebox label:hover {
	background-color: white;
	border: 1.5px solid rgb(95, 0, 128);
	color: rgb(95, 0, 128);
}

.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

#star i {
	font-size: 30px;
	color: rgb(95, 0, 128);
	margin: 5px;
}

#reviewWrite_Btn {
	width:160px;
	height:40px;
	background-color:rgb(95, 0, 128);
	border:1.5px solid rgb(95, 0, 128);
	border-radius:50px;
	color:white;
	font-size:17px;
	-webkit-transition: background-color 0.2s;
  	transition: background-color 0.2s;
  	margin:15px;
}

#reviewWrite_Btn:hover {
	width:160px;
	height:40px;
	background-color:white;
	border:1.5px solid rgb(95, 0, 128);	
	border-radius:50px;
	color:rgb(95, 0, 128);	
	font-size:17px;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
    
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
    	<div id="reviewForm">
    		<div style="text-align:left;">
	    		<span style="font-size:25px; font-weight:300;">아래 상품에 대한 리뷰를 작성합니다.</span>
	    		<div style="border-top:1px solid black; margin:10px 0px 10px;"></div>
	    		<div id="rMenuInfo">
   					<img src="resources/img/menuImage/${menu.menuimg}" style="width:100px;height:100px; float:left;">
	    			<table style="float:left;">
	    				<tr>
	    					<td class="rordersInfo">주문번호 : ${orders.onum}</td>
	    				</tr>
	    				<tr>
	    					<td class="rordersInfo" style="color:gray;">상품명 : ${orders.menuname}</td>
	    				</tr>
	    				<tr>
	    					<td class="rordersInfo" style="color:gray;">가격 : ${orders.ototalprice}원</td>
	    				</tr>
	    				
	    			</table>
	    		</div>
	    		
	    		<div style="height:115px; border-bottom:1px solid black; margin-bottom:30px;"></div>
	    		<form action="reviewwrite" method="post" enctype="multipart/form-data">
	    		<input value="${orders.sid}" name="sid" style="display:none;">
	    		<input value="${sessionScope.loginId}" name="mid" style="display:none;">
	    		<input value="${orders.onum}" name="onum" style="display:none;">
	    		<div>
	    			<span style="font-size:25px;">평점</span>
		    		<div id="star" style="margin-bottom:20px;">
		    			<i class="fas fa-star star-fas" id="star1"></i>
		    			<i class="fas fa-star star-fas" id="star2"></i>
		    			<i class="fas fa-star star-fas" id="star3"></i>
		    			<i class="fas fa-star star-fas" id="star4"></i>
		    			<i class="fas fa-star star-fas" id="star5"></i>
		    		</div>
	    		</div>
	    			<input type="number" value="5" id="starValue" name="rrate" style="display:none;">
	    		<div id="reviewWirte" style="text-align:left; margin-bottom:25px;">
	    			<span style="font-size:20px; font-wiegh:500;">리뷰작성</span>
		    			<table>
		    				<tr>
		    					<td class="reviewTable" id="reivew" style="width:740px;">
		    						<span style="font-weight:500; color:#555;">리뷰쓰기</span><br>
		    						<textarea rows="12" cols="88" id="rcontents" name="rcontents"></textarea>
		    					</td>
		    					<td class="reviewTable" id="image" style="width:260px;">
		    						<span style="font-weight:500; color:#555;">사진업로드</span>
		    						<div class="filebox" style="margin-bottom:2px;">
			    						<label for="reviewimg" style="width:260px;">업로드</label>
			    						<input type='file' id="reviewimg" name="rimgfile"/>
		    						</div>
		    						<div style="width:260px; height:200px; background-color:#dde;" id="reviewImage">
		    							<div style="height:75px;"></div>
										<span style="font-size:20px;">260*200</span>		    							
   									</div>
		    					</td>
		    				</tr>
		    			</table>
	    			</div>
	    			<input type="button" id="reviewWrite_Btn" value="취소" onclick="location.href='myorderslist?mid=${sessionScope.loginId}'">
	    			<input type="submit" id="reviewWrite_Btn" value="작성">
	    		</form>
    		</div>
    	</div>
    </div>
    
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
