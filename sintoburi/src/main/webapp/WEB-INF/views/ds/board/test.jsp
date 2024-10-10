<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>

$(function() {
// 	$(document).keyup(function(e){
		
// 		if(e.keyCode==13){
// 			$("#textContent").append("<br>");
// 			console.log("엔터");
// 		}
		
// 	});
	
	$("#btnInput").click(function(){
		let content= $("#textContent").val();
		
	
		
		$("#content").html(content);
		
	});
	


	});
</script>
<title>테스트</title>
</head>
<body>
		
	<!-- hard속성과 pre태크를 쓰면 textarea에 개행을 포함해 보여줄수있다 -->
	<textarea cols="100" wrap="hard" id="textContent"></textarea>
	<button id="btnInput">입력</button>
	<h3><pre id="content"></pre></h3>	

</body>
</html>