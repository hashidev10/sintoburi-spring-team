<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/include/top.jsp"%>   


<script>
$(function() {
	
	//상품 개수 수정
	$(".btnp_count").click(function(){
		let bdno = $(this).attr("data-bdno");
		let p_count = $(this).attr("data-pcount");
		let inputp_count = $(this).siblings(".p_count").val().trim();
		//console.log("bdno:", bdno);
		//console.log("p_count:", p_count);
		//console.log("inputp_count:", inputp_count);	
		let sData = {
			"bdno": bdno,
			"p_count": inputp_count
		};
		
		$.ajax({
			type: "post",
			url : "/gr/basket/modCount",
			data : JSON.stringify(sData),
			contentType: "application/json; charset=utf-8",
			success: function(result) {
				if (result) {
					let modCount = inputp_count; // 업데이트
					if (modCount === p_count) {
						alert("값을 수정해서 입력해주세요");
					} else {
						$(".p_count").text(modCount);
						alert("상품수가 수정되었습니다");
						location.reload();
					}
				} else {
					alert("상품수가 수정되지 않았습니다");
				}
			}
		});
	});
	
	//체크한 것 삭제
	$("#btnRemoveOne").click(function(){
		let bdnos = [];
		let checkedItems = $("[name=selectedItems]:checked");
		$.each(checkedItems, function(idx, val) {
			let bdno = checkedItems.eq(idx).val();
			bdnos.push(bdno);
		});
		
		let sData = {
			"bdnos" : bdnos
		};
		$.ajax({
			type: "post",
			url : "/gr/basket/removeOne",
			data : JSON.stringify(sData),
			contentType: "application/json; charset=utf-8",
			success: function(result) {
				if (result) {
					alert("삭제 완료되었습니다");
					location.reload();
				} else {
					alert("삭제 실패했습니다");
				}
			}
		});
	});

	//모두 삭제, 장바구니 삭제
	$("#btnRemoveAll").click(function(){
	    $.ajax({
	        type: "POST",
	        url: "/gr/basket/removeAll",
	        success: function(result) {
	            if (result) {
	                alert("삭제 성공");
	                location.reload();
	            } else {
	                alert("삭제 실패");
	            }
	        }
	    });
	});
	
	
	// 페이지 블럭
	 $("a.page-link").click(function(e) {
	        e.preventDefault(); // 브라우저의 기본 기능 막기
	        
	        let pageNum = $(this).attr("href");
	        console.log(pageNum);
	        $("#actionForm > input[name=pageNum]").val(pageNum);
	        $("#actionForm > input[name=amount]").val('${pageMaker.cri.amount}');
	        $("#actionForm").attr("action", "/gr/basket/list");
	        $("#actionForm").attr("method","get");
	        $("#actionForm").submit();
	    });
	
	// 체크한 것 주문하기로 넘겨주기
	$("#btnOrder").click(function(e){
		e.preventDefault();
		let checkedItems = $("[name=selectedItems]:checked");
		console.log("checkedItems:", checkedItems);
		$.each(checkedItems, function(idx, val) {
			let bdno = checkedItems.eq(idx).val();
			console.log("bdno:", bdno);
			let inputTag = `<input type='hidden' name='bdnos' value='\${bdno}'>`;
			console.log("inputTag:", inputTag);
			$("#frm_bdnos").append(inputTag);
		});
		
		$("#frm_bdnos").submit();
	});
});

</script>
<%-- ${list} --%>

 <div class="row">
	<div class="col-md-2">
	</div>
		<div class="col-md-8">
			
			<c:set var="user_id" value="${detailDto.user_id}" />
			 <div>
				${login.user_id}님의 장바구니입니다. (합계 금액: ${sumPrice}) 
			 </div>
			 
			<table class="table">
				<thead>
					<tr class="col-md-8 text-center">
						<th>체크</th>
						<th>상품번호</th>
						<th>상품명</th>
						<th>상품사진</th>
						<th>상품수</th>	
						<th>상품금액</th>
						<th>총금액</th>	
						<th>담은날짜</th>	
					</tr>
				</thead>

				<tbody>
				<c:forEach items="${list}" var="detailDto">
					<tr class="col-md-8 text-center" 
						style="height:50px; line-height:50px;vertical-align:middle">
					    <td>
					    	<input type="checkbox" name="selectedItems" 
					    			value="${detailDto.bdno}"
					    			style="height:50px; line-height:50px;vertical-align:middle"></td>
						<td>${detailDto.product_no}</td>
						<td>${detailDto.product_name}</td>
						<td><img style="height:50px" src="/gr/upload/display?fileName=${detailDto.img_path}"></td>
						<td>
							<input type="text" class="p_count" value="${detailDto.p_count}"
								style="height:30px">
							<button type="button" class="btnp_count" data-bdno="${detailDto.bdno}" 
								data-pcount="${detailDto.p_count}"
								style="height:30px;line-height:30px;vertical-align:middle">수정</button>
						</td>	
						<td>${detailDto.price}</td>
						<td>${detailDto.total_price}</td>
						<td><fmt:formatDate value="${detailDto.put_date}" pattern="yyyy-MM-dd"/></td> 
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
			<form id="frm_bdnos" action="/gr/order/pre_order" method="post" style="display:none">
			</form>
									
		<div class="container-fluid">
			<div class="row justify-content-end">
			    <div class="col-auto">
			        <a href="/gr/order/order_form"
			        	id="btnOrder" class="btn btn-warning">주문하기</a>
			    </div>

			    <div class="col-auto">
			        <button type="button" id="btnRemoveOne" name="btnRemoveOne" class="btn btn-danger" >삭제하기</button>
			    </div>

			    <div class="col-auto">
			        <button type="button" id="btnRemoveAll" name="btnRemoveAll" class="btn btn-secondary">장바구니 비우기</button>
			    </div>
			</div>
		</div>
		</div>
		
		<div class="col-md-2">
		</div>
	
	</div>
	
		<!-- Pagination -->
<div class="row">
	<div class="col-md-12 mt-4" >
		<nav>
			<ul class="pagination justify-content-center">
				<c:if test="${pageMaker.prev == true}">
					<li class="page-item"><a class="page-link"
						href="${pageMaker.startPage - 1}">&laquo;</a></li>
				</c:if>
				
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
					var="v">
					<li class="page-item ${v == pageMaker.cri.pageNum?'active' : ''}">
						<a class="page-link" href="${v}">${v}</a>
					</li>
				</c:forEach>
				
				<c:if test="${pageMaker.next == true}">
					<li class="page-item"><a class="page-link"
						href="${pageMaker.endPage + 1}">&raquo;</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
</div>
<!-- // Pagination -->	

</html>
<%@ include file="/WEB-INF/views/gr/include/action_form.jsp" %>
<%@ include file="/WEB-INF/views/include/bottom.jsp"%>