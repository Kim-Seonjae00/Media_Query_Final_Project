<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/mypage.css">

<style>
	#ordersList th{
		padding: 10px;
		text-align: left;
	}
	#ordersList td{
		font-weight: 300;
		padding : 10px;
		text-align: left;
	}
	#mypage_line_1{
		height:0px;
		border-bottom:1px solid #ccc;
	}
	pre{
		text-align: left;
		padding: 20px;
	}
	#onum{
		background: #eee;
	}
	#reviewBtn{
		width:160px;
		height:40px;
		background-color:rgb(95, 0, 128);
		border:1.5px solid rgb(95, 0, 128);
		border-radius:50px;
		color:white;
		font-size:17px;
		margin-left:340px;
		-webkit-transition: background-color 0.2s;
  		transition: background-color 0.2s;
	}
	.reviewBtn_Done, #reviewBtn:hover{
		width:160px;
		height:40px;
		background-color:white;
		border:1.5px solid rgb(95, 0, 128);
		border-radius:50px;
		color:rgb(95, 0, 128);
		font-size:17px;	
		margin-left:340px;
	}
	
	#ordersCancelBtn{
		border-radius:50px;
		background-color:gray;
		border:1.5px solid gray;
		-webkit-transition: background-color 0.2s;
  		transition: background-color 0.2s;
  		color:white;
	}
	#ordersCancelBtn:hover{
		cursor:pointer;
	}
</style>
<script>
function goReviewForm(onum,menunum){
	location.href="reviewwriteform?onum="+onum+"&menunum="+menunum;
}

function ordersCancelFn(onum){
	if(confirm("주문을 취소하시겠습니까?")){
		location.href="orderscancel?onum="+onum+"&mid=${sessionScope.loginId}";
	}
}
</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="../memberProfile.jsp"></jsp:include>
	
	<div class="article">
	
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	    <jsp:include page="../memberSideNav.jsp"></jsp:include>
	     
	     <div id="main">
	     	<span style="font-size:20px;">주문내역</span>
	     	<div id="mypage_line_0"></div>
	     		<canvas id="myChart" style="width: 770px; height: 250px; margin-bottom:15px;"></canvas>
	     		<script>
	     		  var ctx = document.getElementById("myChart");
	     		  var data=[];
	     		  console.log("${onumList}");
	     		  var onum = "${onumList}".split(",");
	     		  var January = 0;
	     		  var February = 0;
	     		  var March = 0;
	     		  var April = 0;
	     		  var May = 0;
	     		  var June = 0;
	     		  for(var i=0;i<onum.length;i++){
	     			if(onum[i].substring(0,10).indexOf("202001") == 1){
	     				January++;
	     			}else if(onum[i].substring(0,10).indexOf("202002") == 1){
	     				February++;
	     			}else if(onum[i].substring(0,10).indexOf("202001") == 1){
	     				March++;
	     			}else if(onum[i].substring(0,10).indexOf("202004") == 1){
				  		April++;
				  	}else if(onum[i].substring(0,10).indexOf("202005") == 1){
				  		May++;
				  	}else if(onum[i].substring(0,10).indexOf("202006") == 1){
				  		June++;
				  	}
	     		  }
	     		  
	     		  var max = 0;
	     		  if(April < May){
	     			  max = May;
	     		  }else{
	     			  max = April;
	     		  }
	     		  if(max<June){
	     			  max = June;
	     		  }
	     		  max = max+2;
	     		  
	              var myChart = new Chart(ctx, {
	                  type: 'line',
	                  data: {
	                      labels: ["January","February","March","April","May","June"],
	                      datasets: [{
	                          label: "월별 주문 수",
	                          data: [January,February,March,April,May,June],
	                          fill:false, // line의 아래쪽을 색칠할 것인가? 
	                          lineTension:0.1, // 값을 높이면, line의 장력이 커짐.
	                      	  borderColor:["rgb(255,0,0,1)","rgb(0,255,0,1)","rgb(0,0,255,1)"],
	                      	  borderWidth:1
	                      }]
	                  },
	                  options: {
	          			responsive: false,
	          			scales: {
	        				yAxes: [{
	        					ticks: {
	        						min: 0,
	        						max: max,
	        						fontSize : 14,
	        					}
	        				}]
	        			}
	                  }
	             });
	        </script>	
	     		<div id="ordersList">
	     			<div  style="border-bottom:1px solid lightgray;"></div>
	     			<c:forEach var="onum" items="${onumList}">
			     		<div id="order${onum}" class="onum">
			     			<c:choose>
			     				<c:when test="${ordersMap[onum].get(0).ostatus eq '배달완료'}">
				     				<c:choose>
				     					<c:when test="${reviewMap[onum] eq '리뷰있음'}">
											<pre>주문번호      ${onum}<button disabled class="reviewBtn_Done">작성완료</button></pre>				     							
				     					</c:when>
				     					<c:otherwise>
								     		<pre>주문번호      ${onum}<button onclick="goReviewForm('${onum}','${ordersMap[onum].get(0).menunum}')" id="reviewBtn">리뷰쓰기</button></pre>
				     					</c:otherwise>
				     				</c:choose>
			     				</c:when>
			     				<c:when test="${ordersMap[onum].get(0).ostatus eq '주문취소'}">
			     					<pre style="text-decoration:line-through;">주문번호      ${onum}</pre>
			     				</c:when>
			     				<c:otherwise>
			     					<pre>주문번호      ${onum}</pre>
			     				</c:otherwise>
			     			</c:choose>
				     		<div id="mypage_line_1"></div>
				     			<table style="margin-left: auto; margin-right: auto">
					     			<tr>
					     				<th>주문상태</th>
					     				<td>${ordersMap[onum].get(0).ostatus} <c:if test="${ordersMap[onum].get(0).ostatus eq '확인중'}">
					     				<button id="ordersCancelBtn" onclick="ordersCancelFn('${onum}')">주문취소</button></c:if></td>
					     			</tr>
					     			<tr>
					     				<th>주문시간</th>
					     				<td>${ordersMap[onum].get(0).odate}</td>
					     			</tr>
					     			<tr>
					     				<th>상호명</th>
					     				<td>${ordersMap[onum].get(0).storename}</td>
					     			</tr>
				     				<tr>
					     				<th>메뉴</th>					     				
					     				<td><c:forEach var ="orders" items="${ordersMap[onum]}">${orders.menuname} ${orders.camount}개<br></c:forEach></td>						     				
				     				</tr>
					     			<tr>
					     				<th>결제수단</th>
					     				<td>${ordersMap[onum].get(0).opayway}</td>
					     			</tr>
					     			<tr>
					     				<th>주문주소</th>
					     				<td>${ordersMap[onum].get(0).oaddress}</td>
					     			</tr>
					     			<tr>
					     				<th>요청사항</th>
	    								<td>${ordersMap[onum].get(0).omessage}</td>
	    							</tr>						     
						     		<tr>
					     				<th>총 주문 금액</th>
					     				<td>${ordersMap[onum].get(0).ototalprice}원</td>
					     			</tr>
					     		</table>
					     		<div id="mypage_line_1"></div>
			     		</div>
			     	</c:forEach>
				</div>
	     	</div>
		</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>