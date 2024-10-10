<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/include/top.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<style>
	body, html {
	    height: 100%;
	    margin: 0;
	}
	
	#wrapper {
	    display: flex;
	    min-height: 100vh;
	    justify-content: center; /* 수평 중앙 정렬 */
	    align-items: flex-start; /* 상단 정렬 */
	}
	
	#content-wrapper {
	    display: flex;
	    width: 100%;
	    max-width: 1200px; /* 최대 너비 설정 */
	}
	
	#sidebar-wrapper {
	    width: 200px; /* 사이드바 너비 */
	    background-color: #fff;
	    border-right: 1px solid #ddd; /* 사이드바의 오른쪽 경계선 */
	    flex-shrink: 0; /* 사이드바가 줄어들지 않도록 설정 */
	}
	
	#page-content-wrapper {
	    flex: 1; /* 나머지 공간 차지 */
	    padding: 20px; /* 콘텐츠 여백 추가 */
	    display: flex;
	    flex-direction: column;
	    align-items: center; /* 수평 중앙 정렬 */
	}
	
	.center-text span {
	    font-size: 30px;
	    font-weight: bold;
	    padding-left: 16px;
	}
	
	.sidebar-heading {
	    font-size: 1.25rem;
	    font-weight: bold;
	    color: black;
	    margin-bottom: 20px;
	}
	
	.list-group-item {
	    font-size: 1.25rem;
	    font-weight: bold;
	    color: black;
	    margin-bottom: 15px;
	}
	
	.sub-menu {
	    list-style: none;
	    padding-left: 20px;
	}
	
	.sub-menu li {
	    margin-bottom: 8px;
	}
	
	.sub-menu a {
	    font-size: 1rem;
	    color: black;
	    text-decoration: none;
	}
	
	.sub-menu a:hover {
	    color: #333;
	}
	
	.table-container {
	    width: 100%;
	    max-width: 1000px; /* 테이블 최대 너비 설정 */
	}
	
	.table {
	    width: 100%; /* 테이블 폭을 부모 컨테이너에 맞춤 */
	}
</style>
</head>

<script>

$(function() {
    $("#enquiry_type").on("change", function() {
        var selectedValue = $(this).val();
        var textarea = $("#content");

        if (selectedValue === "등급문의") {
            textarea.attr("placeholder", "판매자로 권한 요청 시 사업자 번호 or 사업자등록증을 첨부해주세요.");
        } else {
            textarea.attr("placeholder", "");
        }
    });
    
    $("#enquiryForm").submit(function(e) {
        e.preventDefault(); 
        
        let formData = new FormData(this); 

        $.ajax({
            type: "post",
            url: $(this).attr("action"),
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                
                alert("문의사항이 등록되었습니다.");
                
                window.location.href = '/hn/mypage/enqList'; 
            }
        });
    });
});

</script>
<body>
    <div id="wrapper">
        <div id="content-wrapper">
            <div id="sidebar-wrapper">
                <div class="center-text">
                    <span>마이페이지</span>
                </div>
                <div class="list-group list-group-flush">
                    <div class="list-group-item list-group-item-action list-group-item-light p-3">
                        마이쇼핑
                    </div>
                    <ul class="sub-menu">
                        <li><a href="#!">장바구니</a></li>
                        <li><a href="#!">주문/배송 조회</a></li>
                    </ul>
                    <div class="list-group-item list-group-item-action list-group-item-light p-3">
                        마이활동
                    </div>
                    <ul class="sub-menu">
                        <li><a href="/hn/mypage/enqList">1:1문의내역</a></li>
                       
                    </ul>
                    <div class="list-group-item list-group-item-action list-group-item-light p-3">
                        마이정보
                    </div>
                    <ul class="sub-menu">
                        <li><a href="#!">회원정보 수정</a></li>
                        <li><a href="#!">회원탈퇴</a></li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div id="page-content-wrapper">
                <div class="container-fluid">
                    <!-- Title Section -->
                    <div class="row mb-4">
                        <div class="col-md-12 text-center">
                            <h3>1:1 문의사항</h3>
                        </div>
                    </div>

                    <!-- Form Section -->
                    <div class="row">
                        <div class="col-md-12">
                            <form id="enquiryForm" role="form" action="/hn/mypage/enqRegister" method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="user_id">작성자</label>
                                    <input value="${login.user_id}" type="text" class="form-control" id="user_id" name="user_id" readonly />
                                </div>

                                <div class="form-group">
                                    <label for="enquiry_type">문의 유형</label>
                                    <select class="form-control" aria-label="Default select example" id="enquiry_type" name="enquiry_type">
                                        <option value="상품문의">상품문의</option>
                                        <option value="배송문의">배송문의</option>
                                        <option value="결제문의">결제문의</option>
                                        <option value="등급문의">등급문의</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="content">내용</label>
                                    <textarea rows="10" wrap="hard" class="form-control" id="content" name="content"></textarea>
                                </div>

                                <div class="form-group">
                                    <label for="image">첨부파일</label>
                                    <input  type="file" id="image" name="image" multiple>
                                </div>

                               
                                <div class="col-md-12 text-right">
							            <button class="btnMod btn btn-success" type="submit">등록하기</button>
						    	</div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
<!-- main -->
        </div>
    </div>



<%@ include file="/WEB-INF/views/include/bottom.jsp" %>