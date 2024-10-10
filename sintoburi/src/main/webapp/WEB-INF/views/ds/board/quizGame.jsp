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
<style>

#timeBar{

width:500px;
height:30px;
background-color:red;


}

</style>

<script>

$(function() {

	let limitTime =10000;
	const enterKeyCode = 13;
	let playerLife=3;
	let playerScore=0;
	let correctNum =0;		// 현재 맞춘 문제수
	let bonusScore=0;
	let stageLevel=1;
	let judgeNum = null;	// 결과를 판단할 임시값
	
	
	function judgeStageLevel(){
		
		// 게임레벨 판단 부분 확인 편의상 빠르게 레벨 증가 시켜놓음
		if(correctNum==2){
			bonusScore++;
			stageLevel++;
			limitTime=8000;
		} else if(correctNum==3){
			bonusScore++;
			stageLevel++;
			limitTime=6000;
		}  else if(correctNum==5){
			bonusScore++;
			stageLevel++;
			limitTime=4000;
		} else if(correctNum==7){
			bonusScore++;
			stageLevel++;
			limitTime=2500;
		}
		$("#stage").text(`레벨 : \${stageLevel}`);
	}


	
	function initGame(){
		$("#timeBar").css("display","block");
		$("#score").css("display","block");
		$("#life").css("display","block");
		$("#stage").css("display","block");
		$("#btnClick").css("display","none");
		$("#life").text(`남은기회 \${playerLife}`);
		$("#onion").css("display","none");
		$("#record").css("display","none");
		$("#title").css("display","none");
		judgeStageLevel();
	
		// 숫자+연산자 믹스할 난수
		let firstNum = parseInt(Math.random() * 100) + 1;	
		let secondNum = parseInt(Math.random() * 100) + 1;
		let operation = parseInt(Math.random() * 3) + 1;	
		// 오답 난수
		let inAnswer1 = parseInt(Math.random() * 800) + -100;
		let inAnswer2 = parseInt(Math.random() * 800) + -100;
		let inAnswer3 = parseInt(Math.random() * 800) + -100;
		// 답
		let resultNum = null;
		// answerGroup을 믹스할 난수
		let mixIndex = parseInt(Math.random() * 4) + 0;
		
		
		console.log("op"+operation)
		const add=1,sub=2,mul=3;
		
		if(operation==add){
			resultNum= firstNum+secondNum;
			$("#question").text(firstNum+"+"+secondNum+"="+"?");
		} else if(operation==sub){
			resultNum= firstNum-secondNum;
			$("#question").text(firstNum+"-"+secondNum+"="+"?");
		} else if(operation==mul){
			resultNum= firstNum*secondNum;
			$("#question").text(firstNum+"x"+secondNum+"="+"?");
		} 
		
		console.log("resultNum:"+resultNum)
		// 정답과 오답이 들어갈 배열
		var answer = [resultNum,inAnswer1,inAnswer2,inAnswer3];
		
		// 답그룹에서 p태그를 찾아 랜덤한 위치에 text 출력 답은 0번 인덱스 그외는 오답	
		$("#answerGroup").find(`p:eq(\${mixIndex})`).text(`\${answer[0]}`);
	
		let j=1;
		console.log("mix"+mixIndex)
		for(let i=0; i<4; i++){
			if(i!=mixIndex){
				$("#answerGroup").find(`p:eq(\${i})`).text(`\${answer[j]}`);
				j++;
				console.log("index i:"+i);
			}
		}
		
		return resultNum;
	}

	$("#btnClick").click(function(){
	
		judgeNum = initGame();
		timeBarRun();
	
		$(document).keyup(function(e){
				
				if(e.keyCode==49||e.keyCode==97){			//1
					judgeGame(0,judgeNum);
				} else	if(e.keyCode==50||e.keyCode==98){	//2
					judgeGame(1,judgeNum);
				} else	if(e.keyCode==51||e.keyCode==99){	//3
					judgeGame(2,judgeNum);
				} else	if(e.keyCode==52||e.keyCode==100){	//4
					judgeGame(3,judgeNum);
				}
			});

		
		

		});
	
	// 정답인지 오답인지 판단
	function judgeGame(i,resultNum){	
		
		if(resultNum==$("#answerGroup").find(`p:eq(\${i})`).text()){
			$("#result").text("정답!");
			$("#result").css("color","blue");
			playerScore+=bonusScore+1;
			correctNum++;
			$("#score").text(`점수 \${playerScore}`);
			judgeNum = initGame();
			timeBarRun();
		} else{
			$("#result").text("오답");
			$("#result").css("color","red");
			judgeNum = initGame();
			timeBarRun();
			--playerLife;
			judgeLose(playerLife);
			$("#life").text(`남은기회 \${playerLife}`);
			
		}
		
	}
	// 시간바 동작
	function timeBarRun(){
		$("#timeBar").stop();
		$("#timeBar").css("width","500px");
		$("#timeBar").animate({
			width : "0px"
		}, limitTime, function() {
			$("#result").text("제한시간 초과!");
			$("#result").css("color","red");
			--playerLife;
			judgeLose(playerLife);
			judgeNum = initGame();
			timeBarRun();
			
		});
		
	}
	
	// 게임에서 졌는지 판단
	function judgeLose(playerLife){
		if(playerLife==0){
			$("#timeBar").stop();
			//alert("기회를 모두 소진하였습니다");
			
			let data ={
					"user_id":"${login.user_id}",
					"user_name":"${login.user_name}",
					"score":playerScore
				
				};
			
			$.ajax({
				type:"POST",
				url:"/ds/game/quizRecord",
				data:JSON.stringify(data), 
				contentType: "application/json; charset=UTF-8",
				success: function(result){
					if(result){
						alert(`\${playerScore}포인트 획득!`);
						$(location).attr("href","/ds/board/event");
						
						
						
						
					}
				}
				,error: function(){
					//alert("스코어 등록실패");
				
				}	
		
			});

		}
	}
	// 랭킹 불러오는 부분	
	$.ajax({
		type:"POST",
		url:"/ds/game/quizScore",
		contentType: "application/json; charset=UTF-8",
		success: function(result){
			if(result){
				//alert("스코어 불러와짐");
				
				for(let i=0; i<5; i++){
					console.log(result[i].user_name);
					// 등수 표시
					$("#record").append(`<h3>\${i+1}등 :\${result[i].user_name}님 \${result[i].score}점</h3>`);
				}
				
			}
		}
		,error: function(){
			//alert("스코어 불러오기 실패");
		
		}	

	});
	getUserPoint();
	
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
	


});
</script>
<title>이벤트</title>
</head>
<body>

	<h1 id="title">간단한 문제를 맞춰보세요!</h1>
	

	<button id="btnClick" class="btn btn-outline" style="text-align:center;">
	<img src="/resources/images/startGame.png" style="width:300px;height:250px;"></button>
	<img src="/resources/images/characters/onion.png" id="onion">
	<p id="timeBar" style="display:none;"></p>
	<h1 style="display:none" id="score">점수 0</h1>
	<p id="life" style="font-size:30px;display:none;">남은기회</p>
	<p id="stage" style="font-size:30px;display:none;"></p>
	<h2 id="question"></h2>


	<div id="record">
	<h1 class="point"></h1>
	<h2>현재 랭킹</h2>
	</div>
	
	<h3 id="result"></h3>
	
	<div id="answerGroup">
		<p style="font-size:25px;"></p>
		<p style="font-size:25px;"></p>
		<p style="font-size:25px;"></p>
		<p style="font-size:25px;"></p>
	</div>
	
	
</body>
</html>