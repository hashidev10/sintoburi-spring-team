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
	
	let loginStatus  = "${login}";
	
	console.log(loginStatus);
	
	if(loginStatus==null||loginStatus==""){
		console.log("로그인안됨");
	} else{
		$(location).attr("href","/ds/board/index");
	}

	
	$("#btnRegister").click(function(){	

		let user_id= $("#user_id").val();
		let user_pw= $("#user_pw").val();
		let user_name = $("#user_name").val();
		let address = $("#address").val();
		let user_phone = $("#user_phone").val();
		let user_email = $("#user_email").val();
		
		
		let data={
				
				"user_id":user_id,
				"user_pw":user_pw,
				"user_name":user_name,
				"address":address,
				"user_phone":user_phone,
				"user_email":user_email
				
				
		};		
		
		
		
		if($("#checkId").val()=="yes"){
			registerUser(data);
		}else{
			alert("아이디를 확인해주세요");
		}
		
		
		
});
	
	$("#checkId").click(function(){
		if($("#user_id").val()!="")
		checkUserId();
	});
	
	function checkUserId(){
		
		
		let user_id= $("#user_id").val();
		let data ={
				"user_id":user_id
				};
		
		if(user_id.length<8){
			console.log(user_id.length);
			$("#checkId").text("최소8글자를 입력해주세요");
			$("#checkId").val("no");
			return;
		}
		
		$.ajax({
			type:"POST",
			url:"/ds/user/checkId",
			data:JSON.stringify(data),
			contentType: "application/json; charset=UTF-8",
			success: function(result){
				if(result>=1){
					
					$("#checkId").text("중복된 아이디입니다");
					$("#checkId").val("no");
				} else if(result<1){
					$("#checkId").text("사용가능한 아이디입니다");
					$("#checkId").val("yes");
					
				}
					
			}
			,error: function(){
				
			
			}	

		});
	}
	

		
		
	
	
	
	function registerUser(data){
		
		
		if($("#user_pw").val()==$("#user_pw_check").val()){
			
		
		
		$.ajax({
			type:"POST",
			url:"/ds/user/register",
			data:JSON.stringify(data), 
			contentType: "application/json; charset=UTF-8",
			success: function(result){
			console.log(result);
			
			if(result==true){
				if($("#user_id").val().length<8){
					console.log(user_id.length);
					$("#checkId").text("최소8글자를 입력해주세요");
					$("#checkId").val("no");
					return;
				}
				setTimeout(() => {
					alert("가입이 완료되었습니다.");
					$(location).attr("href","/ds/board/index");
				}, 500);
			}
		
			
				}
			,error: function(){
			
				alert("입력정보를 다시 확인해주세요");
			}	
	});
		
		} else{
			alert("비밀번호가 일치하지 않습니다")
		}
		
	}


	});
</script>
<title>회원가입</title>
</head>
<body class="bg-gradient-primary">

    <div class="container">
  <a href="/hc/main/home"><img src="/resources/images/logo.png" alt="농사랑 로고" style="width:112px;height:88px;">
    </a>
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row" style="margin-right:50px;">
                    <div class="col-lg-3 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
                            </div>
                            
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" id="user_name" 
                                            placeholder="이름" >
                                    </div>
                                  
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="user_id" 
                                        placeholder="아이디" >
                                </div>

								<div class="form-group">
									<button type="button"class="btn btn-primary btn-user btn-block" style=";" id="checkId" value="no">
										아이디 중복체크
									</button>
								</div>
								
								<div id="idCheckText">
								</div>

								<div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user"
                                            placeholder="비밀번호" id="user_pw">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control form-control-user"
                                            placeholder="비밀번호 확인" id="user_pw_check" >
                                    </div>
 
                                </div>
                                
                               <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="tel" class="form-control form-control-user"
                                            placeholder="전화번호" id="user_phone"  >
                                    </div>
                                    
                                     <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="tel" class="form-control form-control-user"
                                            placeholder="이메일" id="user_email"  >
                                    </div>
                                   
                                </div>
                                 
                               <div class="form-group">
    
                                    <input type="text" class="form-control form-control-user" id="address" 
                                        placeholder="주소" >
     
                                </div>
                                 
                                
                                 
                             	  <button type="button" class="btn btn-primary btn-user btn-block" id="btnRegister">
                               				가입하기
                               		</button>

                            
                            <hr>
                            
                            <div class="text-center">
                                <a class="small" href="/ds/board/login">로그인</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
   </body>
</html>