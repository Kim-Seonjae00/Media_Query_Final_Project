<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function deleteResultFn(){
	if('${deleteResult}' == '1'){
		alert("정상적으로 탈퇴되었습니다.");
		location.href="main";
	}else{
		alert("비밀번호가 일치하지 않습니다.");
		location.href="storedeleteform?sid=${sessionScope.storeId}";
	}
}
</script>
</head>
<body onload="deleteResultFn()">

</body>
</html>