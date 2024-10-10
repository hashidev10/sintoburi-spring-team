<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/top.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ include file="/WEB-INF/views/hn/mypage/include/myPageSide.jsp" %>


<head>
 <style>
        body {
            background-color: #ffffff; /* 전체 배경을 하얀색으로 설정 */
            font-family: Arial, sans-serif;
        }
        .login-container {
            max-width: 800px; /* 로그인 폼의 최대 너비를 증가시킴 */
            margin: 10px auto; /* 화면 중앙에 위치하도록 여백 설정 */
            padding: 60px; /* 패딩을 늘려서 내부 공간을 확보 */
            background: #ffffff; /* 로그인 폼 배경을 하얀색으로 설정 */
            border-radius: 8px;
            border: none; /* 테두리 제거 */
            box-shadow: none; /* 그림자 제거 */
        }
        .login-container h2 {
            margin-bottom: 30px;
            text-align: center;
            color: #000000; /* 글자 색상을 검정색으로 설정 */
        }
        .login-container .btn-primary {
            background-color: #28a745; /* 초록색 배경 설정 */
            border-color: #28a745; /* 초록색 테두리 설정 */
            color: #ffffff; /* 글자 색상을 하얀색으로 설정 */
            border-radius: 0; /* 버튼 테두리 직각 설정 */
            max-width: 200px; /* 버튼 가로 길이 제한 */
            padding: 15px; /* 패딩을 늘려서 버튼 크기 증가 */
            font-size: 16px; /* 글자 크기 증가 */
            margin: 0 auto; /* 중앙 정렬 */
        }
        .login-container .btn-primary:hover {
            background-color: #218838; /* 어두운 초록색으로 변경 */
            border-color: #1e7e34; /* 어두운 초록색 테두리 */
        }
        .login-container .btn-secondary {
            background-color: #ffffff; /* 하얀색 배경 설정 */
            border-color: #28a745; /* 초록색 테두리 설정 */
            color: #28a745; /* 초록색 글자 색상 */
            border-radius: 0; /* 버튼 테두리 직각 설정 */
            max-width: 200px; /* 버튼 가로 길이 제한 */
            padding: 15px; /* 패딩을 늘려서 버튼 크기 증가 */
            font-size: 16px; /* 글자 크기 증가 */
            margin: 10px auto; /* 중앙 정렬 */
        }
        .login-container .btn-secondary:hover {
            background-color: #f8f9fa; /* 하얀색 배경에 약간의 그림자 추가 */
            border-color: #1e7e34; /* 어두운 초록색 테두리 */
        }
        .login-container a {
            text-decoration: none;
            color: #007bff;
            font-size: 0.875rem; /* 아이디 저장과 같은 크기 */
        }
        .login-container a:hover {
            text-decoration: underline;
        }
        .form-group {
            display: flex;
            flex-direction: column; /* 세로로 정렬 */
            align-items: center; /* 가운데 정렬 */
            margin-bottom: 20px;
        }
        .form-group .form-control {
            width: 100%; /* 전체 너비를 사용 */
            max-width: 400px; /* 입력 필드 가로 길이 제한 */
            padding: 15px; /* 패딩을 늘려서 입력 필드 크기 증가 */
            font-size: 16px; /* 글자 크기 증가 */
            border-radius: 0; /* 직각 테두리 설정 */
            border: 1px solid #ced4da; /* 직각 테두리 스타일 */
        }
        .form-group .form-checkbox-wrapper {
            display: flex;
            justify-content: space-between; /* 체크박스와 링크를 양쪽 끝에 배치 */
            width: 100%;
            max-width: 400px; /* 입력 필드와 동일한 너비 */
            align-items: center; /* 수직 중앙 정렬 */
            margin-top: 10px;
        }
        .form-checkbox {
            display: flex;
            align-items: center;
            font-size: 0.875rem; /* 링크와 같은 크기 */
        }
        .form-checkbox input[type="checkbox"] {
            margin-right: 5px;
        }
        .form-links {
            display: flex;
            align-items: center;
            font-size: 0.875rem; /* 링크와 같은 크기 */
        }
        .form-links a {
            color: #007bff;
            text-decoration: none;
            margin-right: 15px;
        }
        .form-links a:hover {
            text-decoration: underline;
        }
        
        
       
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="login-container" >
                    <h2>회원탈퇴</h2>
                    <form method="post" action="/hn/mypage/loginConfirm">
                        <div class="form-group">
                            <p>회원탈퇴를 위해 재인증을 해주세요.</p>
                        </div>
                        <div class="form-group" style="margin-bottom: 0px;">
                            <input type="password" class="form-control form-control-user" id="user_pw" name="user_pw" placeholder="비밀번호를 입력해주세요." required>
                        </div>
          				 <div class="form-group">
                        <c:if test="${not empty pwMessage}">
                        <p style="color: red;margin-top: 20px;margin-bottom: 0px;">비밀번호가 일치하지 않습니다.</p>
                   		 </c:if>
                   		   </div>
                   		   <div class="text-center">
                   		    <button style="display: inline-block;"  type="button" class="btn btn-secondary btn-block" onclick="window.location.href='/hn/mypage/myPageMain'">
                       			취소
                  		 	</button>
	                        <button style="display: inline-block;"  type="submit" class="btn btn-primary btn-block">
	                            확인
	                        </button>
	                        
                  		 </div>
                    </form>
                    
                   
                </div>
            </div>
        </div>
    </div>
</body>

<%@ include file="/WEB-INF/views/include/bottom.jsp" %>