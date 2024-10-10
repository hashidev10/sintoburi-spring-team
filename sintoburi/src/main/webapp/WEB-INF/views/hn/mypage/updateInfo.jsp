<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/include/top.jsp" %>
    
<style>
    .table-bordered {
        border-collapse: collapse; /* 테두리 중복 방지 */
    }
    .table-bordered th, .table-bordered td {
        border: 1px solid #dee2e6; /* 내부 테두리 */
    }
    .table-bordered {
        border: none; /* 테이블 가장자리 선 제거 */
    }
    .table thead th {
        border-bottom: 2px solid #dee2e6; /* 헤더와 본문 사이에 두꺼운 테두리 */
    }
    .table caption {
        caption-side: top;
        text-align: center;
        font-weight: bold;
        padding: 0.5rem;
    }
    
}
</style>

<script>
$(function() {
	$("#btnPwCheck").click(function () {
		let user_pw = $("#user_pw").val();
		let checkPw = $("#inputPwCheck").val();
		
		if(user_pw === checkPw){
			$("#pwMessage").text("비밀번호가 일치합니다.");
			$("#pwMessage").css("color", "green");
		}else{
			$("#pwMessage").text("비밀번호가 일치하지 않습니다.");
			$("#pwMessage").css("color", "red");
			
		}
		
	});
	
	$("#btnMod").click(function(e) {
        let user_pw = $("#user_pw").val();
        let checkPw = $("#inputPwCheck").val();
        
        if (user_pw !== checkPw) {
            e.preventDefault(); 
            alert("비밀번호가 일치하지 않아 수정이 불가능합니다.");
        } else{
        	alert("회원 정보가 수정되었습니다.");
        }
    });
	
	
});
</script>

<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8">
                <form action="/hn/mypage/userInfoMod" method="post">
                    <h1 class="text-center" style="margin-bottom: 30px;">회원 정보 수정</h1>
                    <table class="table table-bordered">
                        <thead>
                        </thead>
                        <tbody>
                        
                            <tr>
                                <th scope="row">이름 <span class="text-danger">*</span></th>
                                <td>
                                    <input value="${userInfo.user_name}" id="user_name" name="user_name" class="form-control" maxlength="30" type="text" readonly />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">아이디 <span class="text-danger">*</span></th>
                                <td>
                                    <input value="${userInfo.user_id}" id="user_id" name="user_id" class="form-control" type="text" readonly />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">비밀번호 <span class="text-danger">*</span></th>
                                <td>
                                    <input value="${userInfo.user_pw}" id="user_pw" name="user_pw" class="form-control" type="password" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">비밀번호 확인 <span class="text-danger">*</span></th>
                                <td>
                                    <div style="display: inline-block; vertical-align: middle;">
						            <input id="inputPwCheck" class="form-control" type="password" style="display: inline-block; width: auto; margin-right: 5px;" />
						            <button id="btnPwCheck" type="button" class="btn btn-outline-dark" style="display: inline-block;">확인</button>
						       		<p id="pwMessage" style="display: inline-block; margin: 10;"></p>
						        </div>
		                </td>
                            </tr>
                            <tr>
                                <th scope="row">전화번호 <span class="text-danger">*</span></th>
                                <td>
                                    <input value="${userInfo.user_phone}" id="user_phone" name="user_phone" class="form-control" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">이메일 <span class="text-danger">*</span></th>
                                <td>
                                    <input value="${userInfo.user_email}" id="user_email" name="user_email" class="form-control" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">주소 </th>
                                <td>
                                    <input value="${userInfo.address}" id="address" name="address" class="form-control mb-2" maxlength="14" type="text" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-md-12 text-center" style="margin-bottom: 40px;">
                            <a href="/hn/mypage/myPageMain" class="btn btn-secondary">취소</a>
                            <button id="btnMod" type="submit" class="btn btn-success">수정</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
    
    
<%@ include file="/WEB-INF/views/include/bottom.jsp" %>