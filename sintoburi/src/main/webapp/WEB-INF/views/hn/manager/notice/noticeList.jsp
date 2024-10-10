<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <%@ include file="/WEB-INF/views/hn/manager/include/header.jsp" %>
<script>
$(function(){
	$(".btnMod").click(function(){
		 let $button = $(this);
		let n_no = $(this).data('n_no');
	    let important = $(this).closest('tr').find('select').val();
	    console.log(n_no);
	    console.log(important);
		let sData = {
			"n_no" : n_no,
			"important" :important
		};
		
		
		$.ajax({
			type: "post",
			url : "/hn/manager/notice/updateImportant",
			data : JSON.stringify(sData),
			contentType: "application/json; charset=utf-8",
			 success: function(result) {
	                if (result) {
	                    alert("공지사항 항목이 변경 되었습니다.");
	                } else {
	                    alert("변경 실패 , 다시 시도해 주세요.");
	                }
	            }
		});
		
		
	});
	
	// 페이지 블럭
	 $(".noticePage").click(function(e) {
		    e.preventDefault(); // 브라우저의 기본 기능 막기
		    let pageNum = $(this).attr("href"); 
		    console.log(pageNum);
		    $("#actionForm > input[name=pageNum]").val(pageNum);
		    $("#actionForm > input[name=amount]").val('${criteria.amount}');
		    $("#actionForm").attr("action", "/hn/manager/notice/noticeList");
		    $("#actionForm").submit();
		});

	
	$("#selectSearch").change(function(){
		let v = $(this).val();
		console.log(v);
		
		if(v === "I"){
			$("#selectImportant").show();
			$("#inputSearch").hide();
			$("#inputSearch").removeAttr("name");		
			$("#selectImportant").attr("name","keyword");
			
		}else {
			$("#inputSearch").show();
			$("#selectImportant").hide();
			$("#selectImportant").removeAttr("name");		
			$("#inputSearch").attr("name","keyword");
			
		}
		
	});

	
	
	
});


</script>

 <div class="row">

     <!-- Area Chart -->
     <div class="col-xl-12 col-lg-12">
         <div class="card shadow mb-4">
             <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			    <h6 class="m-0 font-weight-bold text-primary" style="margin-right: 10px;">공지사항</h6>
			   <form id="searchForm" action="/hn/manager/notice/noticeList" method="get" style="display: flex; align-items: center;">
			        <select id="selectSearch" name="type" class="form-control ml-4" style="width: 150px; margin-right: 10px;">
			            <option value="A" ${criteria.type == 'A' ? 'selected' : ''}>전체</option>
			            <option value="N" ${criteria.type == 'N' ? 'selected' : ''}>게시글번호</option>
			            <option value="T" ${criteria.type == 'T' ? 'selected' : ''}>제목</option>
			            <option value="I" ${criteria.type == 'I' ? 'selected' : ''}>항목</option>
			        </select>
			        <select id="selectImportant" class="form-control " 
			        	style="width: 150px; margin-right: 10px; display:none">
			            <option value="N">일반</option>
			            <option value="Y">중요</option>
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
					<th>항목</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${noticeList}" var="vo">

				<tr class="col-md-8 text-center">
					<td>${vo.n_no}</td>
					<td><a href="/hn/manager/notice/noticeDetail/${vo.n_no}">${vo.title}</a></td>
                     
					<td>
				    <c:choose>
				        <c:when test="${vo.important == 'N'}">
				            일반
				        </c:when>
				        <c:when test="${vo.important == 'Y'}">
				            중요
				        </c:when>
				        <c:otherwise>
				           
				        </c:otherwise>
				    </c:choose>
				</td>
					<td><fmt:formatDate value="${vo.write_date}"
							pattern="yyyy-MM-dd" /></td>
					
                       
				</tr>
			</c:forEach>	 
			</tbody>
		</table> 
		<div class="row">
    <div class="col-md-12 text-right">
        <a href="/hn/manager/notice/noticeForm">
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
            </div> <!-- card-body -->
        </div>
    </div>
</div>


<div class="row">

     <!-- Area Chart -->
     <div class="col-xl-12 col-lg-12">
         <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			    <h6 class="m-0 font-weight-bold text-primary" style="margin-right: 10px;">관리자 공지사항</h6>
			</div>
			
             <!-- Card Body -->
             <div class="card-body"> 
<div class="row">
	<div class="col-md-12">
		<table class="table">
			<thead>
				<tr class="col-md-8 text-center">
					<th>제목</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${managerNoticeList}" var="vo">
			<c:if test="${vo.important == 'M'}">

				<tr class="col-md-8 text-center">
					<td><a href="/hn/manager/notice/noticeDetail/${vo.n_no}">${vo.title}</a></td>
					<td><fmt:formatDate value="${vo.write_date}"
							pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:if> 
			</c:forEach>	
			</tbody>
		</table> 
		<div class="row">
  
</div>
	</div>
</div>

            </div> <!-- card-body -->
        </div>
    </div>
</div>

<form id="actionForm" action="/hn/manager/notice/noticeList" method="get">
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