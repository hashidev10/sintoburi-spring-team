<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/include/top.jsp"%>
<%@ include file="/WEB-INF/views/hn/mypage/include/myPageSide.jsp" %>


<script>
$(function () {
	let resultRemove = "${resultRemove}";
	
	if (resultRemove === 'true') {
		let message = '삭제 성공';
	}
	
	
	$(".btn-danger").click(function() {
        let pno = $(this).closest('tr').find('td:first').text();
        
        if(confirm('정말로 삭제하시겠습니까?')) {
            $.ajax({
                type: 'POST',
                url: '/ji/manager/remove',
                data: { pno: pno },
                success: function(response) {
                    location.href = '/ji/manager/productList';
                },
                error: function() {
                    alert('삭제에 실패했습니다.');
                }
            });
        }
    });
	
});

</script>

<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
			<table class="table">
				<thead>
					<tr class="col-md-8 text-center">
						<th>상품 번호</th>
						<th>상품 이름</th>
						<th>상품 가격</th>
						<th>상품 재고</th>
						<th>상품 판매상태</th>
						<th>상품 등록일</th>
						<th>상품 수정일</th>
						<th>상품 수정</th>
						<th>상품 삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="productListDto">
					<tr class="col-md-8 text-center">
						<td>${productListDto.product_no}</td>
						<td>${productListDto.product_name}</td>
						<td>${productListDto.price}</td>
						<td>${productListDto.stock}</td>
						<td>${productListDto.status}</td>
						<td><fmt:formatDate value="${productListDto.reg_date}" pattern="yyyy/MM/dd"/></td>
						<td><fmt:formatDate value="${productListDto.upd_date}" pattern="yyyy/MM/dd"/></td>
						<td><a href="/ji/manager/modifyProduct?pno=${productListDto.product_no}" class="btn btn-warning" >상품수정</a></td>
						<td><button type="button" class="btn btn-danger" id="btnDelete" >상품 삭제</button></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
			<div class="col-md-2">
			</div>
	</div>


<%@ include file="/WEB-INF/views/include/bottom.jsp"%>


