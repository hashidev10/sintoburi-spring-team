<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/include/top.jsp"%>     
    
<script>

</script>

<div class="row">
	<div class="col-md-2">
	</div>
		<div class="col-md-8">
		   <form action="#" method="post">
			<c:set var="user_id" value="${detailDto.user_id}" />
			 <div>
				${login.user_id}님의 결제내역입니다. 
			 </div>
			 
			<table class="table">
				<thead>
					<tr class="col-md-8 text-center">
						<th>주문번호</th>
						<th>수취인 이름</th>
						<th>수취인 전화번호</th>
						<th>배송지</th>
						<th>총상품금액</th>
						<th>배송비</th>
						<th>결제금액</th>
						<th>배송상태</th>
						<th>결제일</th>
<!-- 						<th>결제취소</th> -->
					</tr>
				</thead>

				<tbody>
					<c:forEach items="${paymentList}" var="orderDto">
						<tr class="col-md-8 text-center">
						    <td><a href="http://localhost/gr/order/detail/${orderDto.ono}">${orderDto.ono}</a></td>
							<td>${orderDto.user_name}</td>
							<td>${orderDto.user_phone}</td>
							<td>${orderDto.address}</td>
							<td>${orderDto.sum_total}</td>
							<td>${orderDto.delivery_charge}</td>
							<td>${orderDto.pay_amount}</td>
							<td>${orderDto.delivery_status}</td>
							<td><fmt:formatDate value="${orderDto.order_date}" pattern="yyyy-MM-dd"/></td>
<%-- 							<td><button type="button" data-ono="${orderDto.ono}"  id="btnCancel" name="btnCancel" class="btn btn-danger cancel" style="width:103px;" >결제취소</button></td> --%>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
<!-- 		<div class="container-fluid"> -->
<!-- 			<div class="row justify-content-end"> -->
<!-- 			    <div class="col-auto"> -->
<!-- 			        <a href="/hc/main/home"  id="btnMain" class="btn btn-warning">쇼핑몰 홈</a> -->
<!-- 			    </div> -->
<!-- 			</div> -->
<!-- 		</div>	 -->
									
		</div>
		
		<div class="col-md-2">
		</div>
	</div>

<%@ include file="/WEB-INF/views/gr/include/action_form.jsp" %>
<%@ include file="/WEB-INF/views/gr/include/bottom.jsp"%>