<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/include/top.jsp"%> 

<script>
$(function(){
	let ordernow = '${ordernow}';
	
	if (ordernow == "Y") {
		$("#frmOrder").attr("action", "/gr/order/ordernow");
	}
	
	//주문자와 수취인이 같을 때
	$("#chkSame").change(function(){
		let checked = $(this).prop("checked");
		console.log("checked:", checked);
		if(checked == true){
			$.ajax({
				type: "get",
				url : "/gr/order/getDeliveryInfo",
				success: function(result) {
					console.log("result:", result);
					
					if (result){
						$("#user_name").val(result.user_name);
						$("#user_phone").val(result.user_phone);
						$("#address").val(result.address);
					}
				}
			});
		} else {
			$("#user_name").val("");
			$("#user_phone").val("");
			$("#address").val("");
		}
	});
});
</script>


<div class="row">
	<div class="col-md-2">
	</div>
	
		<div class="col-md-8">
		   <form id="frmOrder" action="/gr/order/run_order" method="post">
		   		<input type="hidden" name="product_no" value="${product_no}">
		   		<input type="hidden" name="p_count" value="${p_count}">
			 <div>
				${login.user_id}님, 수취인의 주문정보를 입력해주세요. 
			 </div>
			 <div>
				<table class="table">
					<tbody>
						<tr>
							<th>수취인 이름</th>
							<td><input type="text" id="user_name" name="user_name"></td>
						</tr>
						<tr>
							<th>수취인 전화번호</th>	
							<td><input type="text" id="user_phone" name="user_phone"></td>
						</tr>
						<tr>
							<th>배송지</th>
							<td><input type="text" id="address" name="address"></td>
							<hr>
							<td colspan="2"><input type="checkbox" id="chkSame">주문자 정보와 동일</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div>
		            <button type="submit" id="btnDetail" name="btnDetail" class="btn btn-warning">주문 계속하기</button>
		    </div>
			</form>
		</div>
		
		<div class="col-md-2">
		</div>
	</div>

<%@ include file="/WEB-INF/views/gr/include/action_form.jsp" %>
<%@ include file="/WEB-INF/views/gr/include/bottom.jsp"%>