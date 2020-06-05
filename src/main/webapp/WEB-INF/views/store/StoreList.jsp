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
</head>
<style>
	#main{
		margin:auto;
	}
	.storeProfile{
		width:800px;
		height:200px;
		margin:auto;
		padding-top:20px;
	}
	
	#storeImg{
		vertical-align: middle;
		float:left;
		width:150px;
		height:150px;
		border-radius: 50%;
	}
	.storeInfo{
		vertical-align: middle;
		float:left;
		width:550px;
		height:130px;
		text-align:left;
		padding-top:20px;
	}
	#storeInfoOdd{
		vertical-align: middle;
		float:left;
		height:130px;
		text-align:left;
		padding-left:40px;
	}
	#storeInfoEven{
		vertical-align: middle;
		float:left;
		height:130px;
		text-align:right;
		padding-right:40px;
		margin-left:50px;
	}
	.storeName{
		font-size:30px;
	}
	.storePhone{
		font-size:20px;
	}
	#main{
		margin-top:60px;
	}
	.storeCategory{
		color:gray;
	}
	.storeName a{
		color:black;	
	}
	#storeProfileOdd{
		background-color:rgb(245,243,248);
		padding-left:40px;

	}
</style>
<script>
var page = parseInt('${search.page}');
$(window).scroll(function() {
	if ($(window).scrollTop() == $(document).height() - $(window).height()) {
		page = page+1;
		var scategory = '${search.scategory}';
		$.ajax ({
			type:"post",
			url:"storelist",
			data:{"page":page,"scategory":scategory},
			dataType:"json",
			success:
				function(result){
				var output=$("#main").html();
				for(var i in result){
					if(i%2==0){
						output+="<div class='storeProfile' id='storeProfileEven'>";
						output+="<div class='storeInfo' id='storeInfoEven'>";
	    				output+="<span class='storeName'><a href='storeview?sid="+result[i].sid+"'>"+result[i].storename+"</a></span>";
	    				output+="<span class='storeCategory'>"+result[i].scategory+"</span><br>";
	    				output+="<span class='storePhone'>"+result[i].sphone+"</span><br>";
	    				output+=result[i].spostcode + result[i].sadrs1 + result[i].sadrs3+ result[i].sadrs4;
	    				output+="</div>";
						output+="<div id='storeProfileImg'>";
						if(result[i].simg != null){
							output+="<img src='resources/img/Profile/"+result[i].simg+"' id='storeImg'>";
						}else{
							output+="<img src='resources/img/logo/로고2.png' id='storeImg'>";
						}
						output+="</div>";
						output+="</div>";
					}else{
						output+="<div class='storeProfile' id='storeProfileOdd'>";
						output+="<div id='storeProfileImg'>";
						if(result[i].simg != null){
							output+="<img src='resources/img/Profile/"+result[i].simg+"' id='storeImg'>";
						}else{
							output+="<img src='resources/img/logo/로고2.png' id='storeImg'>";
						}
						output+="</div>";
						output+="<div class='storeInfo' id='storeInfoOdd'>";
	    				output+="<span class='storeName'><a href='storeview?sid="+result[i].sid+"'>"+result[i].storename+"</a></span>";
	    				output+="<span class='storeCategory'>"+result[i].scategory+"</span><br>";
	    				output+="<span class='storePhone'>"+result[i].sphone+"</span><br>";
	    				output+=result[i].spostcode + result[i].sadrs1 + result[i].sadrs3+ result[i].sadrs4;
	    				output+="</div>";
						output+="</div>";
						
					}
				}
				$("#main").html(output);
			},
			error:
				function(){
					console.log("통신실패!");
			}
		});
	}
});


</script>


<body>
	<jsp:include page="../header.jsp"></jsp:include>
    <div class="article">
		<jsp:include page="../sideMenu.jsp"></jsp:include>
    	<div id="main">
    		<c:forEach var="store" items="${storeList}" varStatus="status">
    				<c:choose>
    					<c:when test = "${status.index%2 eq 0}">
    						<div class="storeProfile" id="storeProfileOdd">
				    			<div id="storeProfileImg">
				 					<c:choose>
				 						<c:when test="${store.simg eq null}">
				 							<img src="resources/img/logo/로고2.png" id="storeImg">
			    						</c:when>
			    						<c:otherwise>
			    							<img src="resources/img/Profile/${store.simg}" id="storeImg">
			    						</c:otherwise>
			    					</c:choose>
			    				</div>
				    			<div class="storeInfo" id="storeInfoOdd">
				    				<span class="storeName"><a href="storeview?sid=${store.sid}">${store.storename}</a></span>
				    				<span class="storeCategory">${store.scategory}</span><br>
				    				<span class="storePhone">${store.sphone}</span><br>
				    				${store.spostcode}
				    				${store.sadrs1}
				    				${store.sadrs3}
				    				${store.sadrs4}
				    			</div>
    						</div>
		    			</c:when>
		    			<c:otherwise>
			    			<div class="storeProfile" id="storeProfileEven">
			    				<div class="storeInfo" id="storeInfoEven">
				    				<span class="storeName"><a href="storeview?sid=${store.sid}">${store.storename}</a></span>
				    				<span class="storeCategory">${store.scategory}</span><br>
				    				<span class="storePhone">${store.sphone}</span><br>
				    				${store.spostcode}
				    				${store.sadrs1}
				    				${store.sadrs3}
				    				${store.sadrs4}
				    			</div>
				    			<div id="storeProfileImg">
			    					<img src="resources/img/Profile/${store.simg}" id="storeImg">
			    				</div>
			    			</div>
		    			</c:otherwise>
	    			</c:choose>
    		</c:forEach>
    	</div>
	</div>
	
	 <jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>