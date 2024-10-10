<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/include/top.jsp" %>
<%@ include file="/WEB-INF/views/hn/mypage/include/myPageSide.jsp" %>
<script>
$(function() {
		
	// 페이지 블럭
	 $("a.page-link").click(function(e) {
	        e.preventDefault(); // 브라우저의 기본 기능 막기
	        
	        let pageNum = $(this).attr("href");
	        console.log(pageNum);
	        $("#actionForm > input[name=pageNum]").val(pageNum);
	        $("#actionForm").attr("action", "/hn/mypage/enqList");
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
				        <a href="/hn/mypage/enqList" style="text-decoration: none; color: black; background-color: #D6EFD8; padding: 10px; display: block; margin-bottom: -1px;">
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
                                   <th>답변상태</th>
                                   <th>답변확인</th>
                                  
                               </tr>
                           </thead>
                           <tbody>
                               <c:forEach items="${list}" var="vo">
                                   <tr class="text-center">
                                       <td>${vo.eno}</td>
                                       <td><a href="/hn/mypage/enqRead?eno=${vo.eno}">${vo.enquiry_type}</a></td>
                                       <td><fmt:formatDate value="${vo.write_date}" pattern="yyyy-MM-dd"/></td>
                                       <td>${vo.status}</td>
                                        <td>
				                    <c:choose>
				                       <c:when test="${vo.status == '답변완료' || vo.status == '처리완료' || vo.status == '보류상태'}">
				                           <button class="btn btn-sm" type="button" data-toggle="collapse" 
				                            data-target="#collapse${vo.eno}" aria-expanded="false">
				                                ▼
				                            </button>
				                        </c:when>
				                        <c:otherwise>
				                            미처리
				                        </c:otherwise>
				                    </c:choose>
               						</td>
               						
                                   </tr>
                                    <tr>
					                <td colspan="10"> <!-- Adjust the colspan value as needed -->
					                    <div id="collapse${vo.eno}" class="collapse">
					                        <div class="card card-body">
					                            <table class="table mb-0">
					                                <thead>
					                                    <tr class="text-center">
					                                        <th>답변번호</th>
					                                        <th>답변내용</th>
					                                        <th>답변일</th>
					                                    </tr>
					                                </thead>
					                                <tbody>
					                                    <c:forEach items="${replyList}" var="reply">
					                                         <c:if test="${reply.eno == vo.eno}">
					                                            <tr class="text-center">
					                                                <td>${reply.rno}</td>
					                                                <td>${reply.reply_content}</td>
					                                                <td><fmt:formatDate value="${reply.reply_date}" pattern="yyyy-MM-dd"/></td>
					                                            </tr>
					                                        </c:if>
					                                    </c:forEach>
					                                </tbody>
					                            </table>
					                        </div>
					                    </div>
					                </td>
					            </tr>
					                                    
                               </c:forEach>
                           </tbody>
                       </table>
                       
                   </div>
                   <div class="row">
                           <div class="col-md-10"></div>
                           <div class="col-md-2">
                               <a href="/hn/mypage/enqRegisterForm">
                                   <button type="button" class="btn btn-success">1:1문의하기</button>
                               </a>
                           </div>
                       </div>
                   <!-- Pagination -->
            <div class="row">
				<div class="col-md-12">
					<nav>
						<ul class="pagination pagination-sm justify-content-center">
							<c:if test="${pageMaker.prev == true}">
							<li class="page-item">
								<a class="page-link" href="${pageMaker.startPage - 1}">&laquo;</a>
							</li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage}" 
									   end="${pageMaker.endPage}" 
									   var="v">
							<li class="page-item ${v == pageMaker.cri.pageNum ? 'active' : ''}"> <!-- li -->
								<a class="page-link" href="${v}">${v}</a>
							</li>
							</c:forEach>
							<c:if test="${pageMaker.next == true}">
							<li class="page-item">
								<a class="page-link" href="${pageMaker.endPage + 1}">&raquo;</a>
							</li>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>
            <!-- // Pagination -->
                   
               </div>
           </div>
      
<form id="actionForm" action="/hn/mypage/enqList" method="get">
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