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
	
	
	
$("#chatInput").focus();
	let nickname;

	// 닉네임을 입력하지 않거나 조건에 맞지 않으면 재귀호출
	function inputNick(){
		 nickname = prompt('닉네임을 입력해주세요');

		if(nickname==null){
	
			inputNick();
		} else if(nickname.length<2){
			alert("두글자 이상 입력해주세요");
			inputNick();
		} else if(nickname.length>8){
			alert("최대 8글자까지 입력가능합니다");
			inputNick();
		}
	}
	
		
// 	setInterval(function(){
// 		$("#enterUser").html(`<p>\${}님이 접속하였습니다</p>`);
// 	}, 100)	
		
	inputNick();


	$(document).keyup(function(e){
		
		
			
			if(e.keyCode==13&&$("#chatInput").val()!=""){	// 엔터
				console.log("엔터");
				//$("#chatContext").append($("#chatInput").val()+"<br>");
				
				let data ={
						"user_id":"${login.user_id}",
						"user_name":nickname,
						"chat_log":$("#chatInput").val()
					
					};
				
				$.ajax({
					type:"POST",
					url:"/ds/chat/sendChat",
					data:JSON.stringify(data), 
					contentType: "application/json; charset=UTF-8",
					async: false,
					success: function(result){
							console.log("채팅보냄")
					//getChatLog();


					}
					,error: function(){
						console.log("채팅안보내짐");
					
					}	
			
				});
				
				
				
				$("#chatInput").val("");
			}
			

		});
	
	
	setInterval(function(){
		getChatLog();	
	}, 100);
	
	
	function getChatLog(){
		$.ajax({
			type:"POST",
			url:"/ds/chat/chatLog",
			contentType: "application/json; charset=UTF-8",
			async: false,
			success: function(result){
				
					
// 					console.log("채팅 읽어옴")
// 					console.log(result)
					
						
					let chat=''; 
					for(let i=0; i<result.length; i++){
// 						console.log(i)
					
						
						chat += `
							<p>\${result[i].user_name} :\${result[i].chat_log}</p>
						
					  `;
						
						}
						
					$("#chatContext").html(chat);
					$("#chatContext").scrollTop(1000000);	// 임시로 스크롤을 내림
					
					
			}
			,error: function(){
				console.log("채팅 못읽옴");
			
			}	
	
		});
		
	}
	
	


});


</script>


<title>채팅</title>

</head>
<body>


<h2>환영합니다<img src=""></h2>
<hr>

<!-- 채팅내용 -->
<div>
<div id="chatContext" style="height:500px;overflow-y:scroll;">	

</div>

<!-- 채팅창 -->
<div id="divChat" style="position:absolute;bottom:0;width:100%">
          <input type="text" class="form-control" id="chatInput">
</div>
</div>
<!-- 들어온 유저 --> 
<!-- <div id="enterUser"> -->

<!-- </div> -->

</body>
</html>