<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/cd5c7a4640.js"crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap"rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.js"integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/main1.css">
<link rel="stylesheet" href="resources/css/footer.css">
<link rel="stylesheet" href="resources/css/adminpage.css">
<script>
	function memberview(nuum){
	    var url = "memberview?mid="+mid;
	    var name = "회원상세조회";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	}
	
	function noticedelete(nnum) {
		location.href="noticedelete?nnum="+nnum+"&loginId=${sessionScope.loginId}";
	}
	function adminnoticeview(nnum) {
		location.href="adminnoticeview?nnum="+nnum+"&loginId=${sessionScope.loginId}";
	}
	
	var page = parseInt('${paging.page}');
	$(window).scroll(function() {
		if ($(window).scrollTop() == $(document).height() - $(window).height()) {
			page = page+1;
			
			$.ajax ({
				type:"post",
				url:"noticelistajax",
				data:{"page":page},
				dataType:"json",
				success:
					function(result){
					var output=$("#profilebox").html();

					for(var i in result){
						if(i%2==0){
		    				output+="<tr>";
		    				output+="<td style='width:80px;'>"+result[i].nnum+"</td>";
		    				output+="<td style='width:250px;'>"+result[i].ntitle+"</td>";
		    				output+="<td>"+result[i].ndate+"</td>";
		    				output+="<td><button onclick='noticedelete("+result[i].nnum+")' id='btn'>삭제</button><button onclick='adminnoticeview("+result[i].nnum+")' class='btn'>상세</button></td>";
		    				output+="</tr>";
							
						}else{
							output+="<tr>";
		    				output+="<td style='width:80px;'>"+result[i].nnum+"</td>";
		    				output+="<td style='width:250px;'>"+result[i].ntitle+"</td>";
		    				output+="<td>"+result[i].ndate+"</td>";
		    				output+="<td><button onclick='noticedelete("+result[i].nnum+")' id='btn'>삭제</button><button onclick='adminnoticeview("+result[i].nnum+")' class='btn'>상세</button></td>";
		    				output+="</tr>";
						}
							
					}
					$("#profilebox").html(output);
				},
				error:
					function(){
						console.log("통신실패!");
				}
			});
		}
	});
</script>
<style>
#profilebox td{
	width:200px;
	font-weight:300;
	padding-top:10px;
	padding-bottom:10px;
	border-top:0.7px solid lightgray;
}
#profilebox th{
	width:200px;
	padding-bottom:20px;
}
#profile{
	width:80px;
	height:80px;
}
#btn{
  border-top-left-radius:20px;
  border-bottom-left-radius:20px;
  border: 1.3px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
.btn{
  margin:-5px;
  border-top-right-radius:20px;
  border-bottom-right-radius:20px;
  border: 1.3px solid;
  border-color: rgb(95, 0, 128);
  background-color: white;
  color: rgb(95, 0, 128);
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
#btn:hover {
  border-top-left-radius:20px;
  border-bottom-left-radius:20px;
  border: 1.3px solid;
  background-color: rgb(95, 0, 128);
  color: white;
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
.btn:hover {
  margin:-5px;
  border-top-right-radius:20px;
  border-bottom-right-radius:20px;
  border: 1.3px solid;
  background-color: rgb(95, 0, 128);
  color: white;
  padding: 5px 13px;
  font-size: 13px;
  cursor: pointer;
  width: 70px;
}
.main{
	width:900px;
}
</style>
</head>
<body>

	<jsp:include page="../adminProfile.jsp"></jsp:include>
	
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	    <jsp:include page="../adminSideNav.jsp"></jsp:include>
	    
	     <div id="main">
	     	<span style="font-size:20px;">공지사항</span>
	     	<div id="mypage_line_0"></div>
	     	<table id="profilebox">
	     		<tr>
	     			<th style="width:80px;">글번호</th><th style="width:300px;">제목</th><th>작성일자</th><th>삭제 / 상세</th>
	     		</tr>
	     	<c:forEach var="noticeList" items="${noticeList}">
	     		<tr>
	     			<td style="width:80px;">${noticeList.nnum}</td>
	     			<td style="width:300px;">${noticeList.ntitle}</td>
	     			<td>${noticeList.ndate}</td>
	     			<td><button onclick="noticedelete('${noticeList.nnum}')" id="btn">삭제</button>
	     			<button onclick="adminnoticeview('${noticeList.nnum}')" class="btn">상세</button></td>
	     		</tr>
	     	</c:forEach>
	     	</table>
	     </div>
	</div>
	
	

</body>
</html>