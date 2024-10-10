<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<style>

#timeBar{

width:600px;
height:30px;
background-color:red;


}


</style>


<script>

$(function() {

	let count=0;
	const enterKeyCode = 13;
	const limitTime = 2000;
	
	console.log("timeBar"+$("#timeBar").val())
	$(document).keyup(function(e){
		console.log("엔터");
		if(e.keyCode==enterKeyCode){
			$("#pushCount").text("연타횟수"+count);
			
			if(count>100){
			 $("#pushCount").css("color","red");
			}
			
			count++;
			
			$("#timeBar").animate({
				width:"0px"
			},limitTime,function(){
				$("#timeBar").stop();
				$("#timeBar").css("width","600px");
				count=0;
			});
		
		}
		
		
	
	});



	

	
	

});
</script>
<title>이벤트</title>
</head>
<body>

	<h1>제한시간 동안 엔터를 많이 연타하세요!</h1>
	<p>엔터를 누르면 게임시작!</p>



	<p id="timeBar"></p>
	<p id="pushCount"></p>
	
	
</body>
</html>