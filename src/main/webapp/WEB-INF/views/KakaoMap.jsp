<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6c81933e16fee6283245fb492563ff94&libraries=services"></script>



<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

.flip-card {
	background-color: transparent;
	width: 300px;
	height: 300px;
	perspective: 1000px;
}

.flip-card-inner {
	position: relative;
	width: 100%;
	height: 100%;
	text-align: center;
	transition: transform 0.6s;
	transform-style: preserve-3d;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
}

.flip-card:hover .flip-card-inner {
	transform: rotateY(180deg);
}

.flip-card-front, .flip-card-back {
	position: absolute;
	width: 100%;
	height: 100%;
	-webkit-backface-visibility: hidden;
	backface-visibility: hidden;
}

.flip-card-front {
	background-color: #bbb;
	color: black;
}

.flip-card-back {
	background-color: #2980b9;
	color: white;
	transform: rotateY(180deg);
}
</style>
</head>

<body onload="onloadFn();">
	<div id="map" style="width: 100%; height: 350px; display:none;"></div>

<script>
function locationFn(){
	var address = $(":input:radio[name=oaddress]:checked").val();
	
	var addressList = address.split(" ");
	address = addressList[1]+" "+addressList[2]+" "+addressList[3];
	
	var address1 = String(address);
	var address2 = String($("#searchAddress2").val());
	var geocoder = new kakao.maps.services.Geocoder();
	console.log(address1);
	console.log(address2);
	geocoder.addressSearch(address1, function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
		   	var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		   	document.getElementById("addressX0").value = result[0].y;
		   	document.getElementById("addressY0").value  = result[0].x;
		}
	});
	
	geocoder.addressSearch(address2, function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
	    	var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	    	document.getElementById("addressX1").value = result[0].y;
	    	document.getElementById("addressY1").value = result[0].x;
		}
	});
}


function getDistanceFromLatLonInKm(lat1,lng1,lat2,lng2) {
    function deg2rad(deg) {
        return deg * (Math.PI/180)
    }

    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2-lat1);  // deg2rad below
    var dLon = deg2rad(lng2-lng1);
    var a = (Math.sin(dLat/2) * Math.sin(dLat/2)) + (Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon/2) * Math.sin(dLon/2));
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    var d = R * c; // Distance in km
    
    return d.toFixed(3)*1000;	
}
          
          
          
</script>
	<p>
		<em>지도를 마우스로 클릭하면 선 그리기가 시작되고<br>오른쪽 마우스를 클릭하면 선 그리기가 종료됩니다</em>
	</p>
	<div style="">
	<button onclick="locationFn()">좌표</button>
	<input type="text" value="" id="searchAddress1">
	<input type="text" value="${saddress}" id="searchAddress2">
	
	<br>
	<input type="number" id="addressX0" value="" placeholder="X좌표">
	<input type="number" id="addressY0" value="" placeholder="Y좌표">
	<br>
	<input type="number" id="addressX1" value="" placeholder="X좌표">
	<input type="number" id="addressY1" value="" placeholder="Y좌표">
	<br>
	</div>
	<input type="number" id="time" value="" placeholder="시간" style="width:80px; font-size:25px; border:none; padding-left:15px;">분
	<button onclick="searchAddressFn()">주소검색</button>
	<input type="number" id="distance" value="" placeholder="거리">
</body>
