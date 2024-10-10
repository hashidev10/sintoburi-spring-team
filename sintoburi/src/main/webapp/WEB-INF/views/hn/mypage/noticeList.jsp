<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/include/top.jsp" %>
<%@ include file="/WEB-INF/views/hn/mypage/include/myPageSide.jsp" %>


<script>
$(function() {
	// 페이지 블럭
	 $(".noticePage").click(function(e) {
		    e.preventDefault(); // 브라우저의 기본 기능 막기
		    let pageNum = $(this).attr("href"); 
		    console.log(pageNum);
		    $("#actionForm > input[name=pageNum]").val(pageNum);
		    $("#actionForm > input[name=amount]").val('${criteria.amount}');
		    $("#actionForm").attr("action", "/hn/mypage/noticeList");
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
					        <a href="/hn/mypage/noticeList" style="text-decoration: none; color: black; background-color: #D6EFD8; padding: 10px; display: block; margin-bottom: -1px;">
					            <h3 style="margin: 0;">공지사항</h3>
					        </a>
					    </div>
					    <div class="col" style="padding: 0;">
					        <a href="/hn/mypage/enqList" style="text-decoration: none; color: black; background-color: #ffffff; padding: 10px; display: block; margin-bottom: -1px;">
					            <h3 style="margin: 0;">1:1 문의사항</h3>
					        </a>
					    </div>
					    <div class="col" style="padding: 0;">
					        <a href="/hn/mypage/faqList" style="text-decoration: none; color: black; background-color: #ffffff; padding: 10px; display: block;">
					            <h3 style="margin: 0;">자주하는 질문</h3>
					        </a>
					    </div>
					</div>

                    <!-- Table Section -->
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr class="text-center">
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>작성일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${noticeList}" var="vo">
                                    <tr class="text-center">
                                        <td>${vo.n_no}</td>
                                       <td>
									    <c:choose>
									        <c:when test="${vo.important == 'Y'}">
									            <span class="badge badge-info">중요</span>
									        </c:when>
									        <c:otherwise>
<!-- 									            <span class="badge badge-light">일반</span> -->
									        </c:otherwise>
									    </c:choose>
									    <a href="/hn/mypage/noticeRead?n_no=${vo.n_no}" style="color: black; padding-left: 10px;">${vo.title}</a>
									</td>
                                        <td><fmt:formatDate value="${vo.write_date}" pattern="yyyy-MM-dd"/></td>
                                        
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                    </div>
                  	<!-- Pagination -->
				<div class="row">
				    <div class="col-md-12">
				        <nav>
				            <ul class="pagination pagination-sm justify-content-center">
				                <c:if test="${pageMaker.prev}">
				                    <li class="page-item">
				                        <a class="page-link noticePage" href="${pageMaker.startPage - 1}">&laquo;</a>
				                    </li>
				                </c:if>
				                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="v">
				                    <li class="page-item ${v == pageMaker.cri.pageNum ? 'active' : ''}">
				                        <a class="page-link noticePage" href="${v}">${v}</a>
				                    </li>
				                </c:forEach>
				                <c:if test="${pageMaker.next}">
				                    <li class="page-item">
				                        <a class="page-link noticePage" href="${pageMaker.endPage + 1}">&raquo;</a>
				                    </li>
				                </c:if>
				            </ul>
				        </nav>
				    </div>
				</div>
				<!-- // Pagination -->
  
                </div>
            </div>
 
 
 <form id="actionForm" action="/hn/mypage/noticeList" method="get">
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