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
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/mypage.css">
<style>
.menuImg {
	width: 70px;
	height: 70px;
}

#menuList{
	padding-top:20px;
	border-top:1px solid lightgray;
}
</style>
<script>
function goMenuAddForm(){
	location.href="menuaddform?sid=${sessionScope.storeId}";
}
function menuDel(menu){
	if(confirm("삭제하시겠습니까?")){
		parseInt(menu);
		location.href="menudelete?menunum="+menu+"&sid=${sessionScope.storeId}";	
	}
}
function menuMod(menu){
	parseInt(menu);
	location.href="menumodifyview?menunum="+menu;
}
</script>
</head>
<body>
	<jsp:include page="../storeProfile.jsp"></jsp:include>
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
		<jsp:include page="../storeSideNav.jsp"></jsp:include>

		<div id="main">
			<span style="font-size: 20px;">메뉴</span>
			<div id="mypage_line_0"></div>
			<canvas id="myChart" style="width: 770px; height: 300px; margin-bottom:15px;"></canvas>
			<table id="menuList">
				<tr>
					<th style="width: 50px;">번호</th>
					<th style="width: 80px;">이미지</th>
					<th>메뉴이름</th>
					<th>메뉴설명</th>
					<th>가격</th>

					<th>조리시간</th>
					<th>카테고리</th>
					<th>누적 주문 수</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<c:forEach var="menu" items="${menuList}">
					<tr id="menu${menu.menunum}">
						<td>${menu.menunum}</td>
						<td><img src="resources/img/menuImage/${menu.menuimg}"
							class="menuImg"></td>
						<td class="menuname">${menu.menuname}</td>
						<td>${menu.menudesc}</td>
						<td>${menu.menuprice}</td>
						<td>${menu.menutime}</td>
						<td>#${menu.mcategory1},#${menu.mcategory2},#${menu.mcategory3}</td>
						<td class="menuhit">${menu.menuhit}</td>
						<td><button onclick="menuMod(${menu.menunum})">수정</button></td>
						<td><button onclick="menuDel(${menu.menunum})">삭제</button></td>
					</tr>
					<div></div>
				</c:forEach>
			</table>
			<button onclick="goMenuAddForm()">메뉴 추가</button>
			
			
			<script>
	              var ctx = document.getElementById("myChart");
	              var menunames = document.getElementsByClassName("menuname");
	         	  var menuhits = document.getElementsByClassName("menuhit");
	              var labels = [];
	              var data = [];
	              var backgroundcolors = [];
	              var bordercolors = [];
	              for(var i=0;i<menunames.length;i++){
	            	  labels.push(menunames[i].innerHTML);
	            	  data.push(menuhits[i].innerHTML);
	              	  var r = Math.floor(Math.random() * 255);
	            	  var g = Math.floor(Math.random() * 255);
	            	  var b = Math.floor(Math.random() * 255);
	            	  backgroundcolors.push("rgb(+"+r+","+g+","+b+",0.2)");
	            	  bordercolors.push("rgb(+"+r+","+g+","+b+",1)");
	              }
	              
	              var myChart = new Chart(ctx, {
	                  type: 'bar',
	                  data: {
	                      labels: labels,
	                      datasets: [{
	                          label: "누적 주문 수",
	                          data: data,
	                          backgroundColor:backgroundcolors,
	                          borderColor:bordercolors,
	                          borderWidth: 1
	                      }]
	                  },
	                  options: {
	          			responsive: false,
	          			scales: {
		          			yAxes: [{
	        					ticks: {
	        						min: 0,
	        						max:10,
	        						fontSize : 14,
	        					}
	        				}]
	          			}
	          		}
	              });
	        </script>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>