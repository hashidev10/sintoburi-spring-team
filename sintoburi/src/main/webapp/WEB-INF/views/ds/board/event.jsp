<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>

$(function(){
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
				let userPoint=result;
				//$(".user").eq(0).text(`님 환영합니다!`);
				$(".point").eq(0).text(`소지포인트 \${userPoint}P`);
					
			}
			,error: function(){
				console.log("포인트 불러오기 실패");
			
			}	

		});
	}
	
	getUserPoint();
});






</script>

<title>이벤트</title>
</head>
<body>

<h2>이벤트 게임에 도전해 포인트를 얻으세요!</h2>

<img src="/resources/images/quiz.png" style="width:50px;height:50px;">
<a href="/ds/board/quizGame">퀴즈게임</a>
<br>
<img src="/resources/images/run.jpg" style="width:50px;height:50px;">
<a href="/ds/board/runGame">야채달리기</a>
<hr>
<!-- <h2 class="user"></h2> -->
<h3 class="point"></h3>





</body>
</html>