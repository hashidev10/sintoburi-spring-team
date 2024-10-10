<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 <%@ include file="/WEB-INF/views/hn/manager/include/header.jsp" %>

<script>
$(function() {
	$(".btnMod").click(function() {
		  let user_id = $(this).attr("data-user-id");
	      let grade = $(this).closest('tr').find('select').val();
	      console.log(user_id);
	      console.log(grade);
	      
			let sData ={
					"user_id" : user_id,
					"grade" : grade
			};

		$.ajax({
			type: "post",
			url : "/hn/manager/user/modGrade",
			data : JSON.stringify(sData),
			contentType: "application/json; charset=utf-8",
			 success: function(rData) {
				 	console.log("rData:", rData);
	                if (rData) {
	                    alert(grade + "로 변경 되었습니다.");
	                    window.location.reload();
	                } else {
	                    alert("변경 실패 , 다시 시도해 주세요.");
	                }
	            }
		});
	});
	
	// 회원테이블 페이지 블럭
	 $(".userPage").click(function(e) {
		    e.preventDefault(); // 브라우저의 기본 기능 막기
		    let pageNum = $(this).attr("href"); 
		    console.log(pageNum);
		    $("#userActionForm > input[name=pageNum]").val(pageNum);
		    $("#userActionForm > input[name=amount]").val('${criteria.amount}');
		    $("#userActionForm").attr("action", "/hn/manager/user/userList");
		    $("#userActionForm").submit();
		});
	
	 $(".user-id").click(function() {
		 let user_id = $(this).attr("data-id");
		 $("#btnModalOk").attr("data-id", user_id);
		 console.log(user_id);
 		 $.ajax({
				type: "post",
				url: "/hn/manager/user/userDetail/" + user_id,
				contentType: "application/json; charset=utf-8",
				 success: function(rData) {
					  $("#modalUserId").val(rData.user_id || ''); 
		                $("#modalUserName").val(rData.user_name || '');
		                $("#modalEmail").val(rData.user_email || '');
		                $("#modalAddress").val(rData.address || '');
		                $("#modalGrade").val(rData.grade || '');
		                $("#modalPoints").val(rData.point || '');
		                $("#modalBusinessNum").val(rData.business_num || '');
		                
		                if (rData.business_num) {
		                    $("#modalBusinessNum").prop("readonly", true);
		                } else {
		                    $("#modalBusinessNum").prop("readonly", false);
		                }
					 
		            }
			});

		 $("#userModal").modal("show");
	
	}); 
	 
	 $("#btnModalOk").click(function() {
			let user_id = $("#modalUserId").val();
	        let business_num = $("#modalBusinessNum").val();
	        let sData = {
	            "user_id": user_id,
	            "business_num": business_num
	        };
		
		$.ajax({
			type: "post",
			url: "/hn/manager/user/modBusinessNum",
			data : JSON.stringify(sData),
			contentType: "application/json; charset=utf-8",
			 success: function(rData) {
				  if(rData){
					  alert("사업자번호가 업데이트되었습니다.");
		                $("#userModal").modal("hide");
				  }else {
	                    alert("변경 실패 , 다시 시도해 주세요.");
	                }

			}
		 
		});
	});
	 
	 $("#selectSearch").change(function() {
		 let v = $(this).val();
		 console.log("v:", v);
		 if (v == "B") {
			 $("#selectBusiness").show();
			 $("#inputSearch").hide();
			 $("#inputSearch").removeAttr("name");
			 $("#selectBusiness").attr("name", "keyword")
		 } else {
			 $("#selectBusiness").hide();
			 $("#inputSearch").show();
			 $("#selectBusiness").removeAttr("name");
			 $("#inputSearch").attr("name", "keyword")
		 }
		 
	 });
	
});
</script>
<!-- 등급 모달창 -->
<div class="row">
	<div class="col-md-12">
		<div class="modal fade" id="userModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="myModalLabel">
							상세 정보
						</h5> 
						
					</div>
					<div class="modal-body">
						<div class="my-3">
						이름	<input type="text" class="form-control"
								id="modalUserId" name ="user_id" readonly>
						</div>
						<div class="my-3">
						이메일	<input type="text" class="form-control"
								id="modalEmail" name ="user_email" readonly>
						</div>
						<div class="my-3">
						주소	<input type="text" class="form-control"
								id="modalAddress" name ="address" readonly>
						</div>
						
						<div>
						등급	<input type="text" class="form-control"
								id="modalGrade" name ="grade" readonly>
						</div>
						<div>
						포인트	<input type="text" class="form-control"
								id="modalpoint" name ="point" readonly>
						</div>
						<div>
						사업자번호	<input type="text" class="form-control"
								id="modalBusinessNum" name="business_num">
						</div>
					</div>
					<div class="modal-footer">
						 
						<button type="button" class="btn btn-primary"
							id="btnModalOk">
							저장
						</button> 
						<button type="button" class="btn btn-secondary" data-dismiss="modal">
							닫기
						</button>
					</div>
				</div>
				
			</div>
			
		</div>
		
	</div>
</div>
<!-- // 등급 모달창 -->

 <!-- Content Row -->

 <div class="row">

     <!-- Area Chart -->
     <div class="col-xl-12 col-lg-12">
         <div class="card shadow mb-4">
             <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			    <h6 class="m-0 font-weight-bold text-primary" style="margin-right: 10px;">회원 목록</h6>
			    <form id="searchForm" action="/hn/manager/user/userList" method="get" style="display: flex; align-items: center;">
			        <select id="selectSearch" name="type" class="form-control ml-4" style="width: 150px; margin-right: 10px;">
			            <option value="A" ${criteria.type == 'A' ? 'selected' : ''}>전체</option>
			            <option value="I" ${criteria.type == 'I' ? 'selected' : ''}>아이디</option>
			            <option value="E" ${criteria.type == 'E' ? 'selected' : ''}>이메일</option>
			            <option value="G" ${criteria.type == 'G' ? 'selected' : ''}>등급</option>
			            <option value="B" ${criteria.type == 'B' ? 'selected' : ''}>등급변경요청</option>
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
					<th >아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>등급</th>
					<th>마지막 로그인 시간</th>
					<th>등급 권한</th>
					<th>확인</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${userList}" var="vo">
				<tr class="col-md-8 text-center">
					<td class="user-id" style="font-weight: bold; cursor: pointer;" data-id ="${vo.user_id}">${vo.user_id}</td>
					<td>${vo.user_name}</td>
					<td>${vo.user_email}</td>
					 <td class="current-grade">
                  	  ${vo.grade} <c:if test="${vo.business == 1 && vo.grade != '판매자'}">
			  			<span style="color: green;">[승인요청]</span>
						</c:if>
              		  </td>
              		 
					 <td><fmt:formatDate value="${vo.last_login}"
                               		pattern="yyyy-MM-dd"/></td>
                       <td class="d-flex justify-content-center align-items-center" >
                       <select  class="form-control ml-4" style="width: 120px;">
						  <option value="구매자" ${vo.grade == '구매자' ? 'selected' : '구매자'}>구매자</option>
    					  <option value="판매자" ${vo.grade == '판매자' ? 'selected' : '구매자'}>판매자</option>   
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
                        <a class="page-link userPage" href="${pageMaker.startPage - 1}">&laquo;</a>
                    </li>
                </c:if>
                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="v">
                    <li class="page-item ${v == pageMaker.cri.pageNum ? 'active' : ''}">
                        <a class="page-link userPage" href="${v}">${v}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageMaker.next}">
                    <li class="page-item">
                        <a class="page-link userPage" href="${pageMaker.endPage + 1}">&raquo;</a>
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

<form id="userActionForm" action="/hn/manager/user/userList" method="get">
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