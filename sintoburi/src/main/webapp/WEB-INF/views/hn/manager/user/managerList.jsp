<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <%@ include file="/WEB-INF/views/hn/manager/include/header.jsp" %>
<script>
$(function() {
    // 페이지 이동 핸들러를 페이지 로드 후 바로 바인딩
    $(".managerPage").click(function(e) {
        e.preventDefault(); // 브라우저의 기본 기능 막기
        let pageNum = $(this).attr("href"); // href 값이 페이지 번호임을 가정
        console.log(pageNum);
        $("#managerActionForm > input[name=pageNum]").val(pageNum);
        $("#managerActionForm").attr("action", "/hn/manager/user/managerList");
        $("#managerActionForm").submit();
    });

    $(".btnMod").click(function() {
        let user_id = $(this).attr("data-user-id");
        let grade = $(this).closest('tr').find('select').val();
        console.log(user_id);
        console.log(grade);
        
        let sData = {
            "user_id": user_id,
            "grade": grade
        };

        $.ajax({
            type: "post",
            url: "/hn/manager/user/modGrade",
            data: JSON.stringify(sData),
            contentType: "application/json; charset=utf-8",
            success: function(result) {
                if (result) {
                    let updatedGrade = grade; // 업데이트된 등급
                    $(this).closest('tr').find('.current-grade').text(updatedGrade);
                    alert(grade + "로 변경 되었습니다.");
                } else {
                    alert("변경 실패 , 다시 시도해 주세요.");
                }
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
			    <h6 class="m-0 font-weight-bold text-primary" style="margin-right: 10px;">관리자 변경</h6>
				<form id="searchForm" action="/hn/manager/user/managerList" method="get" style="display: flex; align-items: center;">
			        <select id="selectSearch" name="type" class="form-control ml-4" style="width: 150px; margin-right: 10px;">
			            <option value="A" ${criteria.type == 'A' ? 'selected' : ''}>전체</option>
			            <option value="I" ${criteria.type == 'I' ? 'selected' : ''}>아이디</option>
			            <option value="E" ${criteria.type == 'E' ? 'selected' : ''}>이메일</option>
			            <option value="G" ${criteria.type == 'G' ? 'selected' : ''}>등급</option>
			        </select>
			        <select id="selectBusiness" class="form-control " 
			        	style="width: 150px; margin-right: 10px; display:none">
			            <option value="1">완료</option>
			            <option value="0">미완료</option>
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
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>등급</th>
					<th>마지막 로그인 시간</th>
					<th>등급 권한</th>
					<th>확인</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${managerList}" var="vo">
				<tr class="col-md-8 text-center">
					<td>${vo.user_id}</td>
					<td>${vo.user_name}</td>
					<td>${vo.user_email}</td>
					 <td class="current-grade" style="color: ${vo.grade == '관리자' ? 'green' : ''};">${vo.grade}</td>
					 <td><fmt:formatDate value="${vo.last_login}"
                               		pattern="yyyy-MM-dd"/></td>
                       <td class="d-flex justify-content-center align-items-center">
                       <select class="form-control ml-4" style="width: 120px;">
						  	<option value="관리자" ${vo.grade == '관리자' ? 'selected' : ''}>관리자</option>
						    <option value="구매자" ${vo.grade == '구매자' ? 'selected' : ''}>구매자</option>
						    <option value="판매자" ${vo.grade == '판매자' ? 'selected' : ''}>판매자</option>
                       </select>
                       </td >
                       <td>
                      <button class="btnMod btn btn-outline-dark" data-user-id="${vo.user_id}" type="button">수정</button>
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
                        <a class="page-link managerPage" href="${pageMaker.startPage - 1}">&laquo;</a>
                    </li>
                </c:if>
                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="v">
                    <li class="page-item ${v == pageMaker.cri.pageNum ? 'active' : ''}">
                        <a class="page-link managerPage" href="${v}">${v}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="page-item">
                        <a class="page-link managerPage" href="${pageMaker.endPage + 1}">&raquo;</a>
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

<form id="managerActionForm" action="/hn/manager/user/managerList" method="get">
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