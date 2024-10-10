<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%--   <%@ include file ="/WEB-INF/views/hn/manager/include/bs.jsp" %> --%>
 <%@ include file="/WEB-INF/views/hn/manager/include/header.jsp" %>

<script>
$(function() {
		
	// 페이지 블럭
	 $(".reportPage").click(function(e) {
	        e.preventDefault(); // 브라우저의 기본 기능 막기
	        
	        let pageNum = $(this).attr("href");
	        console.log(pageNum);
	        $("#actionForm > input[name=pageNum]").val(pageNum);
	        $("#userActionForm > input[name=amount]").val('${criteria.amount}');
	        $("#actionForm").attr("action", "/hn/manager/report/reportList");
	        $("#actionForm").submit();
	    });
	
	 $("#selectSearch").change(function() {
		 let v = $(this).val();
		 console.log("v:", v);
		 if (v == "S") {
			 $("#selectStatus").show();
			 $("#inputSearch").hide();
			 $("#inputSearch").removeAttr("name");
			 $("#selectStatus").attr("name", "keyword")
		 } else {
			 $("#selectStatus").hide();
			 $("#inputSearch").show();
			 $("#selectStatus").removeAttr("name");
			 $("#inputSearch").attr("name", "keyword")
		 }
		 
	 });
	 
	 // 삭제시 처리권한변경
	 $(".btnDelete").click(function() {
		
		 let re_no = $(this).data("re-no"); 
		 let delete_url = $(this).data("delete-url");
		 let num = $(this).data("num");
		 let cate = $(this).data("cate");
		 let sData = {};
		 sData[cate] = num;
		 console.log(sData);
		 $.ajax({
		  	 type: "post",
		  	url: delete_url,
		  	 data: sData,
             success: function() {
                 
            	 $.ajax({
				  	 type: "post",
                     url: "/hn/manager/report/updateStatus",
                     data: { "re_no" : re_no },
                     success: function() {
                         alert("신고게시글의 상태가 '처리완료'로 업데이트되었습니다.");
                        
                         location.href = "/hn/manager/report/reportList";
                     }
			
				});
             }
	
		});
		 
	});
	
	
});
</script>


<div class="row">

     <!-- Area Chart -->
     <div class="col-xl-12 col-lg-12">
         <div class="card shadow mb-4">
             <!-- Card Header - Dropdown -->
             
             <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			    <h6 class="m-0 font-weight-bold text-primary" style="margin-right: 10px;">신고 게시글</h6>
			    <form id="searchForm" action="/hn/manager/report/reportList" method="get" style="display: flex; align-items: center;">
			        <select id="selectSearch" name="type" class="form-control ml-4" style="width: 150px; margin-right: 10px;">
			            <option value="A" ${criteria.type == 'A' ? 'selected' : ''}>전체</option>
			            <option value="N" ${criteria.type == 'N' ? 'selected' : ''}>게시글번호</option>
			            <option value="W" ${criteria.type == 'W' ? 'selected' : ''}>작성자아이디</option>
			            <option value="S" ${criteria.type == 'S' ? 'selected' : ''}>답변상태</option>
			        </select>
			         <select id="selectStatus" class="form-control " 
			        	style="width: 150px; margin-right: 10px; display:none">
			            <option value="처리완료">답변완료</option>
			            <option value="미처리">미처리</option>
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
        <tr class="text-center">
            <th>번호</th>
            <th>신고게시글</th>
            <th>게시글작성자</th>
            <th>신고유형</th>
            <th>신고일</th>
            <th>처리상태</th>
            <th>권한</th>
            
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${reportList}" var="vo">
            <tr class="text-center">
                <td>${vo.re_no}</td>
                <td><a href="${vo.post_url}${vo.write_num}">${vo.post_url}${vo.write_num}</a></td>
                <td>${vo.post_id}</td>
                <td>${vo.re_reason}</td>
                <td><fmt:formatDate value="${vo.re_date}" pattern="yyyy-MM-dd"/></td>
                <c:choose>
				    <c:when test="${vo.status == '미처리'}">
				        <td style="color: red;">${vo.status}</td>
				    </c:when>
				    <c:otherwise>
				        <td style="color: green;">${vo.status}</td>
				    </c:otherwise>
				</c:choose>
               <td>
				<button class="btn-sm btn-danger btnDelete" data-delete-url="${vo.delete_url}" 
					data-num="${vo.write_num}" data-cate="${vo.category }" data-re-no="${vo.re_no}"	type="button">삭제</button>
				</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

	</div>
</div>
<!-- Pagination -->
<div class="row">
    <div class="col-md-12">
        <nav>
            <ul class="pagination justify-content-center">
                <c:if test="${pageMaker.prev}">
                    <li class="page-item">
                        <a class="page-link reportPage" href="${pageMaker.startPage - 1}">&laquo;</a>
                    </li>
                </c:if>
                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="v">
                    <li class="page-item ${v == pageMaker.cri.pageNum ? 'active' : ''}">
                        <a class="page-link reportPage" href="${v}">${v}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="page-item">
                        <a class="page-link reportPage" href="${pageMaker.endPage + 1}">&raquo;</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>
<!-- // Pagination -->
    </div>
            </div> <!-- card-body -->
        </div>
    </div>
</div>
<form id="actionForm" action="/hn/manager/report/reportList" method="get">
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