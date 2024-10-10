<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
p {
	
	width: 50px;
	height: 50px;
	position: relative;
	left: 44%;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
$(function() {
	let playerPos=44;
	let playerSpeed=5;

	const maxRightPos = 88; 
	const maxLeftPos = 0; 
	
	$(document).keydown(function(e){
		if(e.keyCode==39 &&playerPos<maxRightPos){
			$("#playerCharcter").css("left",playerPos+"%");
			if(playerPos>maxRightPos){
				playerPos==maxRightPos;
				$("#playerCharcter").css("left",maxRightPos+"%");
			}
			playerPos+=playerSpeed;
		} else if(e.keyCode==37&&playerPos>maxLeftPos){
			$("#playerCharcter").css("left",playerPos+"%");
			if(playerPos<maxLeftPos){
				playerPos==maxLeftPos;
				$("#playerCharcter").css("left",maxLeftPos+"%");
			}
			playerPos-=playerSpeed;
		}

	});
	
});
</script>
<title>이벤트</title>
</head>
<body >

	<button id="gameStart">게임시작</button>
	<button id="resetGame">Reset</button>
	<p style="margin-top:500px" id="playerCharcter"><img src="/resources/images/characters/carrot.png" style="width:80px;height:80px"></p>
	<hr>
	
</body>
</html>