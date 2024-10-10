<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/include/top.jsp" %>
<%@ include file="/WEB-INF/views/hn/mypage/include/myPageSide.jsp" %>

<style>
	.card {
	    border: none; /* 카드의 테두리 제거 */
	    background-color: #ffffff; /* 전체 배경색을 하얀색으로 설정 */
	    margin-bottom: 10px; /* 카드 사이 간격 설정 */
	}
	
	/* 카드 헤더의 가로 옆 테두리 제거 */
	.card-header {
	    border-left: none; /* 왼쪽 테두리 제거 */
	    border-right: none; /* 오른쪽 테두리 제거 */
	    border-top: none; /* 위쪽 테두리 제거 (선택적) */
	    border-bottom: 1px solid #ddd; /* 아래쪽 테두리만 유지 (선택적) */
	    padding: 0.75rem 1.25rem; /* 카드 헤더 패딩 조정 */
	}
	
	/* 아코디언 토글 스타일 조정 */
	.accordion-toggle {
	    cursor: pointer;
	    padding: 8px; /* 세로 길이 조정 */
	    background-color: #ffffff; /* 하얀색 배경 */
	    color: black;
	    text-decoration: none;
	    border: none; /* 테두리 제거 */
	    box-shadow: none; /* 그림자 제거 (선택적) */
	    font-size: 14px; /* 글씨 크기 조정 */
	    display: block; /* 블록 레벨 요소로 설정 */
	    width: 100%; /* 너비를 100%로 설정 */
	}
	
	/* 아코디언 바디의 여백과 패딩 조정 */
	.card-body {
	    padding: 1rem; /* 카드 바디 패딩 조정 */
	    background-color: #ffffff; /* 카드 바디 배경색 하얀색 */
	}
	.accordion-toggle {
	    display: flex; /* Flexbox를 사용하여 내부 요소 정렬 */
	    justify-content: space-between; /* 아이콘과 텍스트 사이의 공간 분배 */
	    align-items: center; /* 수직 정렬을 중앙으로 설정 */
	    padding: 8px; /* 적절한 패딩 추가 */
	    background-color: #ffffff; /* 배경색 설정 */
	    color: black; /* 텍스트 색상 설정 */
	    text-decoration: none; /* 텍스트 장식 제거 */
	    border: none; /* 테두리 제거 */
	    box-shadow: none; /* 그림자 제거 */
	    font-size: 14px; /* 글씨 크기 조정 */
	    width: 100%; /* 너비를 100%로 설정 */
	}
	
	.toggle-icon {
	    font-size: 18px; /* 아이콘 크기 조정 */
	    margin-left: 8px; /* 아이콘과 텍스트 사이의 여백 추가 */
	}

</style>
<script>


$(function(){
	
	
	// 페이지 블럭
	 $(".faqPage").click(function(e) {
		    e.preventDefault(); // 브라우저의 기본 기능 막기
		    let pageNum = $(this).attr("href"); 
		    console.log(pageNum);
		    $("#actionForm > input[name=pageNum]").val(pageNum);
		    $("#actionForm > input[name=amount]").val('${criteria.amount}');
		    $("#actionForm").attr("action", "/hn/mypage/faqList");
		    $("#actionForm").submit();
		});
	
	
	
});




</script>

            <!-- Main Content -->
            <div id="page-content-wrapper">
                <div class="container-fluid">
                   
                    <!-- Title Section -->
                 	  <div class="row mb-4 text-center" style="margin-left: 0px; margin-right: 0px;">
					    <div class="col" style="padding: 0;">
					        <a href="/hn/mypage/noticeList" style="text-decoration: none; color: black; background-color: #ffffff; padding: 10px; display: block; margin-bottom: -1px;">
					            <h3 style="margin: 0;">공지사항</h3>
					        </a>
					    </div>
					    <div class="col" style="padding: 0;">
					        <a href="/hn/mypage/enqList" style="text-decoration: none; color: black; background-color: #ffffff; padding: 10px; display: block; margin-bottom: -1px;">
					            <h3 style="margin: 0;">1:1 문의사항</h3>
					        </a>
					    </div>
					    <div class="col" style="padding: 0;">
					        <a href="/hn/mypage/faqList" style="text-decoration: none; color: black; background-color: #D6EFD8; padding: 10px; display: block;">
					            <h3 style="margin: 0;">자주하는 질문</h3>
					        </a>
					    </div>
					</div>
					
					<!-- 검색 -->
					<div class="container-fluid mb-3" style="max-width: 600px; margin: 0 auto; margin-top: 30px;">
					    <form id="searchForm"  action="/hn/mypage/faqList" method="get">
					        <div class="input-group">
					        	<select style="display: none;" name="type">
					        		  <option value="T" ${criteria.type == 'T' ? 'selected' : ''}>제목</option>
					        	</select>
					            <input type="text" id="searchInput" name="keyword" class="form-control" placeholder="질문 키워드를 입력해주세요." aria-label="Search" value="${param.keyword}">
					            <div class="input-group-append">
					                <button id ="btnSearch" class="btn btn-success" type="submit">검색</button>
					            </div>
					        </div>
					    </form>
					</div>
					
			<div id="accordion">
			    <c:forEach items="${faqList}" var="vo">
			        <div class="card">
			            <div class="card-header" id="heading${vo.f_no}">
			                <h5 class="mb-0">
			                    <div class="accordion-toggle" data-toggle="collapse" data-target="#collapse${vo.f_no}" aria-expanded="true" aria-controls="collapse${vo.f_no}">
			                     ${vo.title} <span id="spanIcon" class="toggle-icon"> ▼ </span>
			                    </div>
			                </h5>
			            </div>
			            <div id="collapse${vo.f_no}" class="collapse" aria-labelledby="heading${vo.f_no}" data-parent="#accordion">
			                <div class="card-body">
			                <pre>${vo.content}</pre>    
			                </div>
			            </div>
			        </div>
			    </c:forEach>
			</div>
			
			<!-- Pagination -->
<div class="row">
    <div class="col-md-12">
        <nav>
            <ul class="pagination justify-content-center pagination-sm">
                <c:if test="${pageMaker.prev}">
                    <li class="page-item">
                        <a class="page-link faqPage" href="${pageMaker.startPage - 1}">&laquo;</a>
                    </li>
                </c:if>
                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="v">
                    <li class="page-item ${v == pageMaker.cri.pageNum ? 'active' : ''}">
                        <a class="page-link faqPage" href="${v}">${v}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="page-item">
                        <a class="page-link faqPage" href="${pageMaker.endPage + 1}">&raquo;</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>
<!-- // Pagination -->
			
    </div>
</div>

<form id="actionForm" action="/hn/mypage/faqList" method="get">
	<input type="hidden" name="pageNum" 
		value="${criteria.pageNum}" />
	<input type="hidden" name="amount" 
		value="${criteria.amount}" />
	<input type="hidden" name="type"
		value="${criteria.type}"/>
	<input type="hidden" name="keyword"
		value="${criteria.keyword}"/>
</form>

 <%@ include file="/WEB-INF/views/include/bottom.jsp" %>