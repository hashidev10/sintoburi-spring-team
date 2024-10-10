<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.horse {
	width: 50px;
	height: 50px;
	position: relative;
	left: 0%;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
$(function() {
	let playerHorseNum=null;
	let playerHorseRank=null;
	let userPoint;
	
	// 현재 유저가 소지중인 포인트를 얻는다
	function getUserPoint(){
		let data ={
				"user_id":"${login.user_id}"
				};
		
		$.ajax({
			type:"POST",
			url:"/ds/user/getPoint",
			data:JSON.stringify(data),
			contentType: "application/json; charset=UTF-8",
			success: function(result){
				userPoint=result;
				
				$(".point").eq(0).text(`소지포인트 \${userPoint}P`);
					
			}
			,error: function(){
				console.log("포인트 불러오기 실패");
			
			}	
	
		});
	}
	
	getUserPoint();

	function runGameStart(){
		$(".horse").eq(playerHorseNum).css("background-color","gray");
		let rank = 1;
		for (let i = 0; i < $(".horse").length; i++) {
			let elapsedTime = parseInt(Math.random() * 2000) + 3000;
			let delayTime = parseInt(Math.random() * 900) + 100;
			
	
			setTimeout(function() {
				
				$(".horse").eq(i).animate({
					left: "90%"
				}, elapsedTime, function() {
					
					
					$(this).text(rank);
					++rank;
					

					playerHorseRank = $(".horse").eq(playerHorseNum).text();
					
					if(rank==$(".horse").length){
						resultGame();
					}

				});
				
			return
			}, delayTime);

		}

	}
	
	// 현재 등수를 판단하여 포인트를 갱신
	function scoreJudge(point){
		console.log("스코어")
		console.log("포인트"+point);
		let data ={
				"user_id":'user01',	
				"user_point":point
			};
		
		$.ajax({
			type:"PUT",
			url:"/ds/game/runResult",
			data:JSON.stringify(data),
			contentType: "application/json; charset=UTF-8",
			success: function(result){
				$(".point").text(`현재포인트:\${result}P`);
					
			}
			,error: function(){
				console.log("포인트 갱신 실패");
			
			}	
	
		});
		
		
	}
	
	function resultGame(){
		
		
		$("#gameContent").css("display","none");
		$("#gameResult").css("display","block");
		
			let winImg = "/resources/images/win.jpg"
			let loseImg = "/resources/images/lose.jpg"
			let threeImg = "/resources/images/three.jpg"
			
			//console.log(playerImg);
			
			
				
		if(playerHorseRank==1){
			scoreJudge(100);
			$("#resultContext").html(`당신의 야채는\${playerHorseRank}등 입니다`);
			$("#resultContext").append(`<img src='\${winImg}'>`);
			
			
			
			

		} else if(playerHorseRank==2){
			scoreJudge(50);
			$("#resultContext").html(`당신의 야채는\${playerHorseRank}등 입니다`);
			$("#resultContext").append(`<img src='\${winImg}'>`);
			
		
			
		
		} else if(playerHorseRank==3){
			scoreJudge(-50);
			$("#resultContext").html(`당신의 야채는\${playerHorseRank}등 입니다`);
			$("#resultContext").append(`<img src='\${threeImg}'>`);
			
			
			
		} else{
			scoreJudge(-100);
			$("#resultContext").html(`당신의 야채는 순위권 밖입니다`);
			$("#resultContext").append(`<img src='\${loseImg}'>`);
		
			
			
		}

		
		
	};

	
	
	
	$("#btnStart").click(function(){
		
		if(userPoint<100){
			alert("참여포인트가 부족합니다");
		}else{
			$("#gameIntro").css("display","none");
			$("#gameContent").css("display","block");
			
			
			playerHorseNum=$(".check:checked").val();
			
			console.log(playerHorseNum);
			runGameStart();
			
		}
	

	});
	
	$("#btnReset").click(function(){
		$(location).attr("href","/ds/board/event");
	});
	
	
	
});
</script>
<title>야채 달리기</title>
</head>
<body>

<div id="gameIntro">
<h2>야채달리기에서 포인트를 획득하자</h2>
<h4>참여포인트 100P</h4>
<h4 class="point"></h4>
<h4>1등:200P 2등:150P 3등:50P</h4>

<div>
<p>당근</p><input type="radio"  name="group" class="check" checked value="0"><img src="/resources/images/characters/carrot.png" 
	style="width:50px;height:50px;"> 
	
<p>가지</p><input type="radio" name="group" class="check" value="1"><img src="/resources/images/characters/egg plant.png" 
	style="width:50px;height:50px;" > 
	
<p>마늘</p><input type="radio" name="group" class="check" value="2"><img src="/resources/images/characters/garlic.png" 
	style="width:50px;height:50px;" > 
	
<p>양파</p><input type="radio" name="group" class="check" value="3"><img src="/resources/images/characters/onion.png" 
	style="width:50px;height:50px;" > 
	
<p>토마토</p><input type="radio" name="group" class="check" value="4"><img src="/resources/images/characters/tomato.png" 
	style="width:50px;height:50px;" > 
</div>
<button style="width:100px;height:50px; margin-left:500px;" class="btn btn-danger" id="btnStart">게임시작!</button>


</div>



<div id="gameContent" style="display:none;">
	<h1>야채 달리기</h1>
	
	<div class="horse">
	<img src="/resources/images/characters/carrot.png" 
	style="width:50px;height:50px;" class="vege">
	</div>
	<hr>
	<div class="horse">
	<img src="/resources/images/characters/egg plant.png" 
	style="width:50px;height:50px;" class="vege">
	</div>
	<hr>
	<div class="horse">
	<img src="/resources/images/characters/garlic.png" 
	style="width:50px;height:50px;" class="vege">
	</div>
	<hr>
	<div class="horse">
	<img src="/resources/images/characters/onion.png" 
	style="width:50px;height:50px;" class="vege">
	</div>
	<hr>
	<div class="horse">
	<img src="/resources/images/characters/tomato.png" 
	style="width:50px;height:50px;" class="vege">
	</div>
	<hr>
</div>


<div id="gameResult" style="display:none;">

<h2 id="resultContext">
</h2>
<h3 class="point"></h3>

<button class="btn btn-primary" style="margin-left:255px;" id="btnReset">처음으로</button>

</div>
	
</body>
</html>