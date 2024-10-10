<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <%@ include file="/WEB-INF/views/hn/manager/include/header.jsp" %>
<script>
$(function(){
	
	
	// 페이지 블럭
	 $(".faqPage").click(function(e) {
		    e.preventDefault(); // 브라우저의 기본 기능 막기
		    let pageNum = $(this).attr("href"); 
		    console.log(pageNum);
		    $("#actionForm > input[name=pageNum]").val(pageNum);
		    $("#actionForm > input[name=amount]").val('${criteria.amount}');
		    $("#actionForm").attr("action", "/hn/manager/faq/faqList");
		    $("#actionForm").submit();
		});
	
	
	
});


</script>
 <div class="row">

     <!-- Area Chart -->
     <div class="col-xl-12 col-lg-12">
         <div class="card shadow mb-4">
             <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			    <h6 class="m-0 font-weight-bold text-primary" style="margin-right: 10px;">자주하는 질문</h6>
			    <form id="searchForm" action="/hn/manager/faq/faqList" method="get" style="display: flex; align-items: center;">
			        <select id="selectSearch" name="type" class="form-control ml-4" style="width: 150px; margin-right: 10px;">
			            <option value="A" ${criteria.type == 'A' ? 'selected' : ''}>전체</option>
			            <option value="F" ${criteria.type == 'F' ? 'selected' : ''}>게시글번호</option>
			            <option value="T" ${criteria.type == 'T' ? 'selected' : ''}>제목</option>
			        </select>
			      <input class="form-control" id="inputSearch" type="text" name="keyword" style="margin-right: 10px;width: 226px;">
			        <button id="btnSearch" type="submit" class=" btn btn-primary btn-sm">검색</button>
			    </form>
			</div>
             <!-- Card Body -->
             <div class="card-body"> 
<div class="row">
	<div class="col-md-12">
		<table class="table">
			<thead>
				<tr class="col-md-8 text-center">
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${faqList}" var="vo">
				<tr class="col-md-8 text-center">
					<td>${vo.f_no}</td>
					<td><a href="/hn/manager/faq/faqDetail/${vo.f_no}">${vo.title}</a></td>
					<td><fmt:formatDate value="${vo.write_date}" pattern="yyyy-MM-dd"/></td> 
 				</tr> 
 			</c:forEach>	 
			</tbody>
		</table>
		
		
		<div class="row">
		    <div class="col-md-12 text-right">
		        <a href="/hn/manager/faq/faqRegisterForm">
		            <button class="btn btn-primary btn" type="button">작성하기</button>
		        </a>
		    </div>
		</div>
	</div>
</div>

<!-- Pagination -->
<div class="row">
    <div class="col-md-12">
        <nav>
            <ul class="pagination justify-content-center">
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
            </div> <!-- card-body -->
        </div>
    </div>
</div>

<form id="actionForm" action="/hn/manager/faq/faqList" method="get">
	<input type="hidden" name="pageNum" 
		value="${criteria.pageNum}" />
	<input type="hidden" name="amount" 
		value="${criteria.amount}" />
	<input type="hidden" name="type"
		value="${criteria.type}"/>
	<input type="hidden" name="keyword"
		value="${criteria.keyword}"/>
</form>

 <%@ include file="/WEB-INF/views/hn/manager/include/footer.jsp" %>