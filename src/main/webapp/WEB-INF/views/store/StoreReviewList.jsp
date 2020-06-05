<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> 
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
<link rel="stylesheet" href="resources/css/storeview.css">
<script>
var page = 1;
$(window).scroll(function() {
	if ($(window).scrollTop() == $(document).height() - $(window).height()) {
		page++;
		$.ajax({
			type:"post",
			url:"reviewlist",
			data:{"page":page,"sid":'${store.sid}'},
			dataType:"json",
			success:		
				function(result){
				var output=$("#reviewList").html();
				for(var i in result){
					output+="<div class='review' id='review"+result[i].rnum+"'>";
    				output+="<div class='review_info'>"+result[i].mid+"님 <span class='rdate'>&nbsp;"+result[i].rdate+"</span></div>";
    				var star="";
    				for(var j=0;j<Math.round(result[i].rrate);j++){
    					star+="<i class='fas fa-star' style='color:rgb(95, 0, 128); font-size:15px'></i> ";
    				}
    				for(var j=0;j<5-Math.round(result[i].rrate);j++){
    					star+="<i class='fas fa-star' style='color:gray;font-size:15px'></i> ";
    				}
    				output+=star+"<span style='font-size:14px; font-weight:300; color:gray'>"+result[i].rrate+"</span>";
    				output+='<div style="margin-top:10px; text-align:left; font-weight:300">';
    				if(result[i].rimg != null){
    					output+="<img src='resources/img/review/"+result[i].rimg+"'>";
    				}
    				output+=result[i].rcontents+"</div>";
    				output+="<div class='recomment' id='recomment"+result[i].rnum+"'>";
    		
    				if(result[i].rcnum == 0){
    					output+="<input type='text' id='rccontents"+result[i].rnum+"' placeholder='답글'>"
    					output+=" <button onclick='reviewComment("+result[i].rnum+")'>작성</button>";
    				}else{
    					output+="<span style='font-weight:300'>ㄴ"+result[i].rccontents+"</span>";
    				}
    				output+="</div></div>";
				}
				
				$("#reviewList").html(output);
			},error:
				function(){
				console.log("통신 실패");
			}	
		});
	}
});

function reviewComment(rnum){
	var rccontents = $("#rccontents"+rnum).val();
	$.ajax({
		type:"post",
		url:"reviewcomment",
		data:{rnum:rnum,sid:"${sessionScope.storeId}",rccontents:rccontents},
		dataType:"json",
		success:
			function(result){
				var html = "";
				html += "<span style='font-weight:300'>ㄴ"+result.rccontents+"</span>"; 
				$("#recomment"+rnum).html(html);
				console.log("성공");
		},
		error:
			function(){
			console.log("통신실패");
		}
		
		
	});
	
}
</script>
<style>

	#top_profile_contents{
		text-align:left;
		width:500px;
	}
	
	#top_profile_object{
		padding-top:30px;
		float:left;
		text-align:center;
	}
	.fa-star{
		font-size:20px;
	}
	#rate{
		font-size:40px;
		font-weight:300;
	}
	#star_yellow{
		color:rgb(95, 0, 128);
	}
	#star_gray{
		color:gray;
	}
	.recomment{
		text-align:left;
		margin-top:10px;
	}
</style>
</head>
<body>
	<jsp:include page="../storeProfile.jsp"></jsp:include>
	
	<div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
	     <jsp:include page="../storeSideNav.jsp"></jsp:include>
	     
	     <div id="main">
	     	<span style="font-size:20px;">리뷰내역</span>
	     	<div id="mypage_line_0"></div>
	     	<div id="reviewList">
	     		<c:forEach var="review" items="${reviewList}">
	     			<div class='review' id="review${review.rnum}">
	    				<div class='review_info'><span class="">${review.mid}</span>&nbsp;<span class="rdate">${review.rdate}</span></div>
		    				<c:choose>		    		
			    				<c:when test="${review.rrate%1 ge '0.5'}">
				    				<c:forEach var="i" begin="1" end="${review.rrate+1}" step="1">
				    					<i class='fas fa-star' style='color:rgb(95, 0, 128); font-size:15px'></i>
				    				</c:forEach>
				    				<c:forEach var="i" begin="1" end="${5-review.rrate}" step="1">
		    							<i class='fas fa-star' style='color:gray;font-size:15px'></i>
		    						</c:forEach>
		    						<span style='font-size:14px; font-weight:300; color:gray'>${review.rrate}</span>	
			    				</c:when>
			    				
			    				<c:when test="${review.rrate%1 ne '0'}">
				    				<c:forEach var="i" begin="1" end="${review.rrate}" step="1">
				    					<i class='fas fa-star' style='color:rgb(95, 0, 128); font-size:15px'></i>
				    				</c:forEach>
				    				<c:forEach var="i" begin="1" end="${6-review.rrate}" step="1">
		    							<i class='fas fa-star' style='color:gray;font-size:15px'></i>
		    						</c:forEach>
		    						<span style='font-size:14px; font-weight:300; color:gray'>${review.rrate}</span>	
			    				</c:when>
			    				
			    				<c:otherwise>
			    					<c:forEach var="i" begin="1" end="${review.rrate}" step="1">
				    					<i class='fas fa-star' style='color:rgb(95, 0, 128); font-size:15px'></i>
				    				</c:forEach>
				    				<c:forEach var="i" begin="1" end="${5-review.rrate}" step="1">
		    							<i class='fas fa-star' style='color:gray;font-size:15px'></i>
		    						</c:forEach>
		    						<span style='font-size:14px; font-weight:300; color:gray'>${review.rrate}</span>
			    				</c:otherwise>
		    				</c:choose>
		    				<div style="margin-top:10px; text-align:left; font-weight:300">
		    					<c:if test="${review.rimg ne null}">
				    				<img src="resources/img/review/${review.rimg}">
		    					</c:if>
		    					
			    				${review.rcontents}
		    				</div>
		    				<div class="recomment" id="recomment${review.rnum}">
			    				<c:choose>
			    					<c:when test="${recommentMap[review.rnum] eq null}">
										<input type="text" id="rccontents${review.rnum}" name="rccontents" placeholder="답글">
										<button onclick="reviewComment(${review.rnum})">작성</button>
			    					</c:when>
			    					<c:otherwise>
			    						<span style="font-weight:300">ㄴ${recommentMap[review.rnum].rccontents}</span>
			    					</c:otherwise>
			    				</c:choose>
		    				</div>
		    		</div>
	     		</c:forEach>
	     	</div>
	     </div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>