<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  font-family: Arial;
  font-size: 17px;
}

#myVideo {
  position: fixed;
  right: 0;
  bottom: 0;
  min-width: 100%; 
  min-height: 100%;
}

.content {
  text-align:center;
  position:fixed;
  margin-top:350px;
  background: rgba(0, 0, 0, 0.5);
  color: #f1f1f1;
  width: 100%;
  padding: 20px;
}

#myBtn {
  width: 200px;
  font-size: 18px;
  padding: 10px;
  border: none;
  background: #000;
  color: #fff;
  cursor: pointer;
}

#myBtn:hover {
  background: #ddd;
  color: black;
}

.gomain{
	color:white;
	font-size:30px;
	font-weight:700;
	text-decoration:none;
}
</style>
</head>
<body>
<div onclick="myFunction()">
<video autoplay muted loop id="myVideo">
	<source src="resources/video/videoplayback.mp4" type="video/mp4">
</video>
</div>
<div class="content">
  <img src="resources/img/logo/로고2.png" style="width:200px; height:200px; border-radius:50%;"><br>
  <a href="main" class="gomain">주문하러 가기 >></a>
</div>
<script>
var video = document.getElementById("myVideo");

function myFunction() {
  if (video.paused) {
    video.play();
  } else {
    video.pause();
  }
}
</script>
</body>
</html>