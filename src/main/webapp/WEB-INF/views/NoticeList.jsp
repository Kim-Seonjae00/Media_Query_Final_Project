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
		location.href="noticedelete?nnum="+nnum+"&loginId='${sessionScope.loginId}'";
	}
	function adminnoticeview(nnum) {
		location.href="adminnoticeview?nnum="+nnum+"&loginId='${sessionScope.loginId}'";
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
		    				output+="<td class='shortbox'>"+result[i].nnum+"</td>";
		    				output+="<td class='longboxtd'><a href='noticeview?nnum="+result[i].nnum+"'>"+result[i].ntitle+"</a></td>";
		    				output+="<td class='shortbox'>"+result[i].ndate+"</td>";
		    				output+="</tr>";
							
						}else{
							output+="<tr>";
		    				output+="<td class='shortbox'>"+result[i].nnum+"</td>";
		    				output+="<td class='longboxtd'><a href='noticeview?nnum="+result[i].nnum+"'>"+result[i].ntitle+"</a></td>";
		    				output+="<td class='shortbox'>"+result[i].ndate+"</td>";
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
.shortbox{
	width:170px;
	height:40px;
}
.longbox{
	width:530px;
	height:40px;
}
.longboxtd{
	width:540px;
	height:40px;
	text-align:left;
}
.noticebox td{
	font-weight:300;
	text-decoration:none;
	border-top:0.5px solid lightgray;
	padding-top:10px;
	padding-bottom:10px;
}
.noticebox th{
	padding-bottom:20px;
}
.noticebox{
	width:900px;
	margin:auto;
}
#top_profile {
	width: 100%;
	height: 260px;
	padding-top: 30px;
	padding-left: 460px;
	padding-right: 460px;
	background-color: rgb(232,223,240);
	margin-bottom:80px;
}
.main{
	width:900px;
	margin:auto;
}
.noticeimg{
	width:850;
	margin:auto;
	margin-bottom:30px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	
	<div class="article">
		<jsp:include page="sideMenu.jsp"></jsp:include>
	    
	     <div class="main">
	     	<img src="resources/img/notice/공지사항.jpg" class="noticeimg">
	     	<div class="noticebox">
	     	<table id="profilebox">
	     		<tr>
	     			<th class="shortbox">공지사항번호</th><th class="longbox">제목</th><th class="shortbox">작성일자</th>
	     		</tr>
	     	<c:forEach var="noticeList" items="${noticeList}">
	     		<tr>
	     			<td class="shortbox">${noticeList.nnum}</td>
	     			<td class="longboxtd"><a href="noticeview?nnum=${noticeList.nnum}">${noticeList.ntitle}</a></td>
	     			<td class="shortbox">${noticeList.ndate}</td>
	     		</tr>
	     	</c:forEach>
	     	</table>
	     </div>
	     </div>
	</div>
	
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>