<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
	    
    .hidden {
      display: none;
  }
</style>
</head>
<body>
    <div id="wrapper">
        <div id="content-wrapper" style="margin-top: 20px;">
            <div id="sidebar-wrapper"  class="${login == null ? 'hidden' : ''}" >
            <c:if test="${login != null}">

                <div class="center-text" style="margin-top: 25px;">
                    <span>마이페이지</span>
                </div>
                 <ul class="sub-menu" style="margin-top: 0px; margin-bottom: 0px;">
				    <li>
				        <span style="color: green;font-weight: bold;">${login.user_id}님</span> 반갑습니다.
				        <c:if test="${login.grade == '관리자' || login.grade == '마스터'}">
				         <li><a href="/hn/manager/user/userList" style="color: green;">관리자 페이지</a></li>
				         </c:if>
				    </li>
				</ul>
                      
                <div class="list-group list-group-flush">
                    <div class="list-group-item list-group-item-action list-group-item-light p-3">
                        마이쇼핑
                    </div>
                    <ul class="sub-menu">
                        <li><a href="/gr/basket/list">장바구니</a></li>
                        <li><a href="/gr/order/payment_list">주문/배송 조회</a></li>
                        <c:if test="${login.grade == '판매자'}">
                        <li><a href="/ji/manager/productList">판매 상품 조회</a></li>
                        <li><a href="/gr/seller_delivery/list">판매 내역 조회</a></li>
                        </c:if>
                    </ul>
                    <div class="list-group-item list-group-item-action list-group-item-light p-3">
                        마이활동
                    </div>
                    <ul class="sub-menu">
                        <li><a href="/hn/mypage/enqList">1:1문의내역</a></li>
                        <li><a href="/hn/mypage/noticeList">공지사항</a></li>
                        <li><a href="/hn/mypage/faqList">자주하는 질문</a></li>
                    </ul>
                    <div class="list-group-item list-group-item-action list-group-item-light p-3">
                        마이정보
                    </div>
                    <ul class="sub-menu">
                        <li><a href="/hn/mypage/checkPw">회원 정보 수정</a></li>
                        <li><a href="/hn/mypage/loginConfirm">회원탈퇴</a></li>
                    </ul>
                </div>
                </c:if>
            </div>
		

   