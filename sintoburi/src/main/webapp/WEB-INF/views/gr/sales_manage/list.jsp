<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/hn/manager/include/header.jsp"%>     
<script>
</script>
  
		  <!-- Card Body -->
             <div class="card-body"> 
<div class="row">
	<div class="col-md-12">
		<table class="table">
			<thead>
				<tr class="col-md-8 text-center">
					<th>주문번호</th>
					<th>주문아이디</th>
					<th>수취인이름</th>
					<th>수취인 전화번호</th>
					<th>총상품금액</th>
					<th>결제금액</th>
					<th>배송상태</th>
					<th>결제일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${deliveryList}" var="orderDto">
				    <tr class="col-md-8 text-center">
				        <td><a href="http://localhost/gr/order/detail/${orderDto.ono}">${orderDto.ono}</a></td>
				        <td>${orderDto.user_id}</td>
				        <td>${orderDto.user_name}</td>
				        <td>${orderDto.user_phone}</td>
				        <td>${orderDto.sum_total}</td>
				        <td>${orderDto.pay_amount}</td>
				        <td>${orderDto.delivery_status}</td>
				        <td><fmt:formatDate value="${orderDto.order_date}" pattern="yyyy-MM-dd"/></td>
				    </tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<!-- <!-- Pagination --> -->
<!-- <div class="row"> -->
<!--     <div class="col-md-12"> -->
<!--         <nav> -->
<!--             <ul class="pagination justify-content-center"> -->
<%--                 <c:if test="${pageMaker.prev}"> --%>
<!--                     <li class="page-item"> -->
<%--                         <a class="page-link userPage" href="${pageMaker.startPage - 1}">&laquo;</a> --%>
<!--                     </li> -->
<%--                 </c:if> --%>
<%--                 <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="v"> --%>
<%--                     <li class="page-item ${v == pageMaker.cri.pageNum ? 'active' : ''}"> --%>
<%--                         <a class="page-link userPage" href="${v}">${v}</a> --%>
<!--                     </li> -->
<%--                 </c:forEach> --%>
<%--                 <c:if test="${pageMaker.next}"> --%>
<!--                     <li class="page-item"> -->
<%--                         <a class="page-link userPage" href="${pageMaker.endPage + 1}">&raquo;</a> --%>
<!--                     </li> -->
<%--                 </c:if> --%>
<!--             </ul> -->
<!--         </nav> -->
<!--     </div> -->
<!-- </div> -->
<!-- // Pagination --> 
            </div> <!-- card-body -->
    

<%@ include file="/WEB-INF/views/gr/sales_manage/include/footer.jsp"%> 