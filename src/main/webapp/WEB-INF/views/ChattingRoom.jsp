<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ChattingRoom</title>
<script src="https://kit.fontawesome.com/c4acfea8a6.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap" rel="stylesheet">
<script>
	function messagelist(mreceiver, msender, senderimg, sendername){
	    var url = "messagelist?mreceiver="+mreceiver+"&msender="+msender+"&senderimg="+senderimg+"&sendername="+sendername;
	    var name = "채팅";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	}
	
	function messageAdmin(loginId){
		var url = "messageadmin";
	    var name = "채팅";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	}

</script>
<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
	a{
		text-decoration: none; 
	}
	#msender:hover{
		background-color: rgb(249, 249, 249);
	}
	#msender{
		text-align: left;
		height: 50px;
		border-bottom: 1px solid #ddd;
		padding: 15px;
	}
	#Line_0{
		height:0px;
		border-bottom:2px solid black;
		margin-top:10px;
	}
	#messageBtn{
		width: 150px;
		border: 1px solid rgb(95, 0, 128);
		color: rgb(95, 0, 128);
		background: white;
		border-radius: 50px;
		padding: 10px;
		margin: 10px;
	}
</style>

</head>
<body>
	
	<c:set var="loginId" value="${sessionScope.loginId}"></c:set>
	<c:if test="${sessionScope.loginId eq null}">
		<c:set var="loginId" value="${sessionScope.storeId}"></c:set>
	</c:if>
	<h2 style="text-align: center;">요기서 요기</h2>
	<div id="Line_0"></div>
		<div class="msenderList">
			<c:forEach var="sender" items="${senderList}" varStatus="i">
				
				<a href="#" onclick="messagelist('${sender.senderid}', '${loginId}', '${sender.senderimg}', '${sender.sendername}')">
					<div id="msender">
						<table>
						<tr>
							<th style="width: 150px;">${sender.sendername}&nbsp;&nbsp;&nbsp;<span style="color:rgb(255, 122, 107);"><i class="fas fa-bell"></i>${malertList[i.index]}</span></th>
							<td style="width: 320px; text-align: right;">${messageList[i.index].mdate}</td>
						</tr>
						<tr>				
							<td colspan="2">${messageList[i.index].mcontents}</td>
						</tr>
						</table>
					</div>
				</a>
			</c:forEach>
		</div>
	<c:choose>
		<c:when test="${sessionScope.loginId ne 'admin'}">
			<button onclick="messageAdmin('${loginId}')" id="messageBtn">요기서 요기 1:1 문의</button>
		</c:when>
	</c:choose>
</body>
</html>