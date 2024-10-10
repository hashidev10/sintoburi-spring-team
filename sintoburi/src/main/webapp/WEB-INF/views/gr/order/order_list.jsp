<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/include/top.jsp"%>     
    
    
    
<script>
$(function(){
	$(".payment").click(function(e) {
		
		//e.preventDefault(); 
		let user_id = "${login.user_id}";
        let ono = $(this).attr("data-ono");
        let pay_amount = $(this).attr("data-pay_amount");
        let current_point = $(this).attr("data-user_point");
        let remain_point = $(this).attr("data-remain_point");
        let payment_state = $(this).attr("data-payment_state");
        
//         if (current_point < pay_amount) {
	       if (remain_point < 0) {
            alert("포인트가 부족합니다.");
            return; 
        }
        
        let data = {
        		"user_id":user_id,
        		"ono": ono,
                "pay_amount" : pay_amount,
                "current_point" : current_point,
                "remain_point" : remain_point,
                "payment_state" : payment_state
        }
        console.log("data:",data);
        
        $.ajax({
            url: '/gr/order/do_pay', //결제 처리 요청을 보낼 URL
            type: 'POST',
            contentType: 'application/json',  //JSON 형식으로 전송
            data: JSON.stringify(data),
            success: function(response) {
             alert("결제 완료되었습니다.");
               $(location).attr("href","/gr/order/payment_list"); //서버에서 리다이렉트 URL을 받아서 이동
            },
            error: function() {
                alert("결제 처리 중 오류가 발생했습니다.");
            }
        });
    });
});
</script>


<div class="row">
	<div class="col-md-1">
	</div>
		<div class="col-md-10">
			
			<c:set var="user_id" value="${detailDto.user_id}" />
			 <div> 
				${login.user_id}님의 주문서입니다. 주문번호를 누르면 상세 내역을 볼 수 있습니다. 
			 </div>
			 
			<table class="table">
				<thead>
					<tr class="col-md-8 text-center">
						<th>주문번호</th>
						<th>수취인 이름</th>
						<th>수취인 전화번호</th>
						<th>배송지</th>
<!-- 						<th>결제방법</th> -->
						<th>남은포인트</th>
						<th>총상품금액</th>
						<th>배송비</th>
						<th>결제금액</th>
						<th>결제상태</th>
						<th>배송상태</th>
						<th>송장번호</th>
					</tr>
				</thead>

				<tbody>
				<c:forEach items="${orderList}" var="orderDto">
					<tr class="col-md-8 text-center"
						<c:if test="${orderDto.p_state == '결제완료'}">
						style="background-color:gray;"
						</c:if>
					>
					    <td class="onos"><a href="http://localhost/gr/order/detail/${orderDto.ono}">${orderDto.ono}</a></td>
						<td>${orderDto.user_name}</td>
						<td>${orderDto.user_phone}</td>
						<td>${orderDto.address}</td>
<%-- 						<td>${orderDto.payment_type}</td> --%>
						<td>${orderDto.user_point}</td>
						<td>${orderDto.sum_total}</td>
						<td>${orderDto.delivery_charge}</td>
						<td>${orderDto.pay_amount}</td>
						<td>${orderDto.p_state}</td>
						<td>${orderDto.delivery_status}</td>
						<td>${orderDto.delivery_number}</td>
						
<%-- 						<c:choose> --%>
<%-- 						<c:when test="${orderDto.p_state=='결제완료'}"> --%>
<!-- 						<td><button type="button" id="btnPaymentCancel" name="btnPaymentCancel" class="btn btn-danger" style="width:103px;">결제취소</button></td> -->
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
						<td>
						<c:if test="${orderDto.p_state == '결제전'}">
							<button type="button" id="btnPayment" name="btnPayment" class="btn btn-warning payment"
								data-ono="${orderDto.ono}"  
								data-pay_amount="${orderDto.pay_amount}"  
								data-user_point="${orderDto.user_point}"  
								data-remain_point="${orderDto.user_point - orderDto.pay_amount}"  
								data-payment_state="${orderDto.payment_state}"  
							>결제</button>
						</c:if>
						</td>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
					
					</tr>
				</c:forEach>
					
				</tbody>
			</table>
									
		</div>
		
		<div class="col-md-1">
		</div>
	</div>

<%@ include file="/WEB-INF/views/gr/include/action_form.jsp" %>
<%@ include file="/WEB-INF/views/gr/include/bottom.jsp"%>