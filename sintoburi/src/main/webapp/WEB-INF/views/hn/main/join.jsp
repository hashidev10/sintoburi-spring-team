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
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8">
                <table class="table table-bordered">
                   <h1 class="text-center" style=" margin-bottom: 30px;">JOIN US</h1>
                    <thead>
                       
                    </thead>
                    <tbody>
                    	 <tr>
                            <th scope="row">이름 <span class="text-danger">*</span></th>
                            <td>
                                <input id="user_name" name="user_name" class="form-control" maxlength="30" type="text" />
                               
                            </td>
                        </tr>
                    
                        <tr>
                            <th scope="row">아이디 <span class="text-danger">*</span></th>
                            <td>
                                <input id="member_id" name="member_id" class="form-control" type="text" />
                                <small id="idMsg" class="form-text text-muted">(영문소문자/숫자, 4~16자)</small>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">비밀번호 <span class="text-danger">*</span></th>
                            <td>
                                <input id="user_pw" name="user_pw" class="form-control" type="password" />
                                <small class="form-text text-muted">
                                    ※ 비밀번호 입력 조건<br>
                                    - 대소문자/숫자 4자~16자<br>
                                    - 특수문자 및 공백 입력 불가능<br>
                                    - 연속된 문자, 숫자 사용 불가능<br>
                                    - 동일한 문자, 숫자를 반복해서 사용 불가능<br>
                                    - 아이디 포함 불가능
                                </small>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">비밀번호 확인 <span class="text-danger">*</span></th>
                            <td>
                                <input id="pw_check" name="pw_check" class="form-control" type="password" />
                                <small id="pwConfirmMsg" class="form-text text-danger">비밀번호가 일치하지 않습니다.</small>
                            </td>
                        </tr>
                  
                        <tr class="d-none">
                            <th scope="row">비밀번호 확인 답변 <span class="text-danger">*</span></th>
                            <td><input id="hint_answer" name="hint_answer" class="form-control" type="text" /></td>
                        </tr>
                        
                        <tr>
                            <th scope="row">이메일 <span class="text-danger">*</span></th>
                            <td>
                                <input id="email" name="email" class="form-control" type="text" />
                                
                            </td>
                        </tr>
                       
                        <tr>
                            <th scope="row">주소 </th>
                            <td>
                                <input id="adress" name="adress" class="form-control mb-2" placeholder="" readonly maxlength="14" type="text" />
                                <a href="#none" class="btn btn-primary" id="postBtn">우편번호</a><br />
                                <input id="addr1" name="addr1" class="form-control mt-2" placeholder="" readonly type="text" /> 기본주소<br />
                                <input id="addr2" name="addr2" class="form-control mt-2" placeholder="" type="text" /> 나머지주소
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
    
    
    
     <%@ include file="/WEB-INF/views/include/bottom.jsp" %>