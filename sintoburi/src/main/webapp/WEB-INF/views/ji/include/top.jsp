<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신토불이</title>
</head>
<!-- <link rel="stylesheet" href="/resources/css/styles.css"> -->
<style>
body, html {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    box-sizing: border-box;
}

.main-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.main-header {
    width: 100%;
    top: 0;
    z-index: 1000;
    background-color: #fff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    position: fixed;
    display: flex;
    flex-direction: column;
    align-items: center;
}
/* top-bar, middle-bar, main-nav의 높이를 조절할 수 있는 부분 */
.top-bar, .middle-bar, .main-nav {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    border-bottom: 1px solid #e7e7e7;
    
}

.top-bar {
    padding: 10px 0;
    /* 높이를 조절하고 싶다면 아래 높이 값을 변경하세요 */
    height: 20px !important;  /* 이 부분을 수정하여 높이를 조절 */
    background-color: #e0f7fa; 
}

.main-nav {
    padding: 10px 0;
    /* 높이를 조절하고 싶다면 아래 높이 값을 변경하세요 */
    height: 30px !important; /* 이 부분을 수정하여 높이를 조절 */
    background-color: D6EFD8; /* 초록색 배경 추가 */
}

.middle-bar {
    padding: 20px 0;
    /* 높이를 조절하고 싶다면 아래 높이 값을 변경하세요 */
    height: 120px !important; /* 이 부분을 수정하여 높이를 조절 */
    background-color: #e0f7fa; 
}

.top-bar .main-container {
    justify-content: space-between;
    align-items: center;
}

.announcement {
    flex-basis: 0;
    flex-grow: 1;
    text-align: left;
    margin-right: 200px; /* 공지사항에 오른쪽 마진을 줄입니다 */
    white-space: nowrap;
    overflow: hidden; /* 넘치는 텍스트를 숨김 */
    text-overflow: ellipsis; /* 넘치는 텍스트를 "..."로 표시 */
    border-radius: 20px; /* 모서리를 둥글게 설정 */
}

.user-menu {
    display: flex;
    justify-content: flex-end;
}

.announcement a,
.user-menu a {
    text-decoration: none;
    margin-left: 10px; /* 좌측 마진을 10px로 줄입니다 */
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    color: #2F4F4F; 
    font-weight: bold;
    padding: 8px 16px; /* 버튼 스타일링을 위한 패딩 추가 */
    border-radius: 20px; /* 모서리를 둥글게 설정 */
}

.middle-bar .main-container {
    justify-content: center;
}

.logo img {
    height: 120px;
}


/* 스크롤 시 상단에 고정되도록 설정 */
.main-nav.sticky {
    position: fixed;
    top: 0;
    z-index: 1001;
    background-color: D6EFD8;
    width: 100%;
}

/* 숨겨진 상태로 설정 */
.hidden {
    display: none;
}

.main-nav ul {
    list-style: none;
    display: flex;
    margin: 0;
    padding: 0;
}

.main-nav ul li {
    margin-right: 10px; /* 마진을 줄여서 아이템 간 간격을 조절 */
    list-style: none; /* 불필요한 기본 리스트 스타일 제거 */
}

.main-nav ul li a {
    color: #fff; /* 텍스트 색상을 흰색으로 변경 */
    font-weight: bold;
    padding: 6px 10px; /* 양옆에 20px의 패딩 추가 */
}


.search-bar input {
    width: 300px;
    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 4px;
    margin-right: 10px;
}

.search-icon, .cart-icon {
    text-decoration: none;
    color: #333;
    margin-left: 10px;
}

main {
    padding-top: 200px; /* 헤더 높이만큼 여백 추가 */
}

/* 지환 스타일 추가  */

.product-list {
	margin-top: 20px;
}

.nav-tabs .nav-link {
    border: 1px solid #ddd;          /* 사각 테두리 추가 */
    padding: 10px 15px;              /* 내부 여백 설정 */
    white-space: nowrap;             /* 텍스트 줄 바꿈 방지 */
    border-radius: 5px;              /* 테두리 둥글게 만들기 */
    margin-right: 10px;              /* 탭 간 간격 설정 */
    background-color: white;         /* 배경색 설정 */
}

.nav-tabs .nav-link.active {
    background-color: #f8f9fa;       /* 활성화된 탭의 배경색 설정 */
    border-color: #ddd;              /* 활성화된 탭의 테두리 색상 */
}

.nav-tabs {
    border-bottom: none;             /* 기본 하단 경계선 제거 */
}

.col-md-6 img {
    display: block;
    margin-left: auto;
    margin-right: auto;
}

.star-rating {
    font-size: 0; /* 텍스트 크기를 0으로 설정하여 별 이미지만 표시 */
    display: inline-block;
}

.star-rating i {
    font-size: 22px; /* 별의 크기를 설정 */
    color: #ffcc00; /* 별의 색상 */
}

.star-rating .half-star {
    position: relative;
    overflow: hidden;
    display: inline-block;
    width: 11px; /* 반 별의 너비 */
}
.gold-star {
        color: gold;
}

/*// 지환 스타일 추가 */
</style>
<body>
    <header class="main-header">
        <div class="top-bar">
            <div class="main-container">
                <div class="announcement">
                    <a href="#" class="btn ">공지사항[24/07/22] 당첨자발표 | 7월 고기데이 기획전 경품 당첨자</a>
                </div>
                <div class="user-menu">
				    <!-- 로그인 상태 O -->
				    <c:if test="${isLoggedIn}">
				        <a href="/ds/user/logout" class="btn">로그아웃</a>
				        <a href="/user/myPage" class="btn">마이페이지</a>
				    </c:if>
				    
				    <!-- 로그인 상태 X -->
				    <c:if test="${not isLoggedIn}">
				        <a href="/ds/board/login" class="btn">로그인</a>
				        <a href="/user/register" class="btn">회원가입</a>
				    </c:if>
				
				    <a href="#" class="btn">주문조회</a>
				    <a href="#" class="btn">고객센터</a>
				</div>
            </div>
        </div>
        <div class="middle-bar">
            <div class="main-container">
                <div class="logo">
                    <a href="/"><img src="/resources/images/logo.png" alt="농사랑 로고"></a>
                </div>
            </div>
        </div>
        <nav class="main-nav">
            <div class="main-container">
                <ul>
                    <li><a href="/ji/product/productMain" class="btn btn-success">메인화면</a></li>
                    <li><a href="#" class="btn btn-success">정기배송</a></li>
                    <li><a href="#" class="btn btn-success">베스트</a></li>
                    <li><a href="#" class="btn btn-success">신상품</a></li>
                    <li><a href="#" class="btn btn-success">상품후기</a></li>
                    <li><a href="#" class="btn btn-success">장바구니</a></li>
                </ul>
            </div>
        </nav>
    </header>
    <main>
    <script>
	    // 특정 글자 수로 텍스트 자르기
	    function truncateText(selector, maxLength) {
	        const element = document.querySelector(selector);
	        if (element) {
	            let text = element.textContent;
	            if (text.length > maxLength) {
	                element.textContent = text.substring(0, maxLength) + '...';
	            }
	        }
	    }
	
	    window.addEventListener('DOMContentLoaded', function() {
	        truncateText('.announcement a', 35); // 공지사항 텍스트를 50자로 제한
	    });
	
	    window.addEventListener('scroll', function() {
	        var topBar = document.querySelector('.top-bar');
	        var middleBar = document.querySelector('.middle-bar');
	        var mainNav = document.querySelector('.main-nav');
	
	        if (window.scrollY > 50) {
	            topBar.classList.add('hidden');
	            middleBar.classList.add('hidden');
	            mainNav.classList.add('sticky');
	        } else {
	            topBar.classList.remove('hidden');
	            middleBar.classList.remove('hidden');
	            mainNav.classList.remove('sticky');
	        }
	    });
    </script>
  



