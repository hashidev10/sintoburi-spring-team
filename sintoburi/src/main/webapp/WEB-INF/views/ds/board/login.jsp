
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
	
	$(document).keyup(function(e){
		
		if(e.keyCode==13){
			$("#btnLogin").click();
		}
		
		
	});
	
	$("#btnLogin").click(function(){
		
		let user_id= $("#user_id").val();
		let user_pw = $("#user_pw").val();
		let data ={
				"user_id":user_id,
				"user_pw":user_pw
				};
		
		$.ajax({
			type:"POST",
			url:"/ds/user/login",
			data:JSON.stringify(data),
			contentType: "application/json; charset=UTF-8",
			success: function(result){
				
				// 전 페이지로 이동
				
				//history.back();
				if (result == "manager") {
	
						$(location).attr("href", "/hn/manager/user/userList");

					} else {

						location.href = document.referrer;
					}

					console.log(result); 

				},
				error : function() {

					alert("아이디또는 비밀번호를 확인해주세요");
				}

			});


		});

	});
</script>
<title>로그인</title>
</head>
<body class="bg-gradient-primary">

    <div class="container">
<a href="/hc/main/home"><img src="/resources/images/logo.png" alt="농사랑 로고" style="width:112px;height:88px;"></a>
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row" style="margin-right:50px;">
                    <div class="col-lg-3 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">로그인</h1>
                            </div>
                            
                              
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="user_id" 
                                        placeholder="아이디" >
                                </div>

								

                                 
                               <div class="form-group">
    
                                    <input type="password" class="form-control form-control-user" id="user_pw" 
                                        placeholder="비밀번호" >
     
                                </div>
                                 
                                
                                 
                             	  <button type="button" class="btn btn-primary btn-user btn-block" id="btnLogin">
                               				로그인
                               		</button>

                            
                            <hr>
<!--                             <div class="text-center"> -->
<!--                                 <a class="small" href="forgot-password.html">비밀번호 찾기</a> -->
<!--                             </div> -->
                            <div class="text-center">
                                <a class="small" href="/ds/board/register">회원가입</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
   </body>
</html>
