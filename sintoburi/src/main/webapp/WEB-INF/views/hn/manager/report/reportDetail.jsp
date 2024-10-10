<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/hn/manager/include/header.jsp" %>

<script>

$(function() {
	let eno = '${enquiryVo.eno}'; 
	let status = '${enquiryVo.status}';
    let replyContent = '${replyVo.reply_content}';
	
	// 문의사항 데이터 가져오기
    $.ajax({
        type: "get",
        url : "/hn/manager/gradeEnqDetail/" + eno,
        contentType: "application/json; charset=utf-8",
        success : function(rData) {
 

        	 if (status === "처리완료") {
                 $("#replyContent").val(replyContent).prop("readonly", true);
                 $("#btnReplyRegister").hide(); // 답변 등록 버튼 숨기기
             } else {
                 $("#replyContent").prop("readonly", false);
                 $("#btnReplyRegister").show(); // 답변 등록 버튼 보이기
                 $("#btnReplyMod").hide();
             }
        }
    });
	
	// 문의사항 답변 등록하기
	$("#btnReplyOk").click(function() {
		
		let reply_Content = $("#replyContent").val(); 
	    let eno = '${enquiryVo.eno}'; 
	    let user_id = '${enquiryVo.user_id}'; 
	    let manager_id = 'manager';
		
		let sData = {
				"eno": eno,
		        "user_id": user_id,
		       	"reply_content": reply_Content,
		        "manager_id": manager_id
	        };

		
		$.ajax({
			type: "post",
			url : "/hn/reply/registerReply",
			data : JSON.stringify(sData),
			contentType: "application/json; charset=utf-8",
			success : function(rData) {
				console.log(rData);
				console.log(sData);
			    
				$.ajax({
				  	 type: "post",
                     url: "/hn/manager/gradeupdateStatus",
                     data: { eno: eno },
                     success: function() {
                         alert("문의사항 상태가 '처리완료'로 업데이트되었습니다.");
                         location.href = "/hn/manager/gradeEnqList";
                     }
			
				});
				
			}
		});
	});
		
	

 
});
</script>

 <!-- Content Row -->

 <div class="row">

     <!-- Area Chart -->
     <div class="col-xl-12 col-lg-12">
         <div class="card shadow mb-4">
             <!-- Card Header - Dropdown -->
             <div
                 class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                 <h6 class="m-0 font-weight-bold text-primary">문의 사항</h6>
                 
             </div>
             <!-- Card Body -->
             <div class="card-body"> 

<div class="row">
	<div class="col-md-12">
		
		<div >
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-12">
          
                <div class="form-group">
                    <label for="re_id">신고자</label>
                    <input value="${reportPostVo.re_id}" type="text" class="form-control"  readonly>
                </div>
                
                 <div class="form-group">
                    <label for="post_id ">글작성자</label>
                    <input value="${reportPostVo.post_id}" type="text" class="form-control"  readonly>
                </div>
                <div class="form-group">
                    <label for="enquiry_type">신고 유형</label>
                     <select id="report_type" name="report_type" class="form-control" style="width: 150px;" disabled>
                        <option value="스팸" <c:if test="${enquiryVo.enquiry_type =='스팸'}">selected</c:if>>스팸</option>
                        <option value="거짓정보" <c:if test="${enquiryVo.enquiry_type =='거짓정보'}">selected</c:if>>거짓정보</option>
                        <option value="불법또는규제상품판매" <c:if test="${enquiryVo.enquiry_type =='불법또는규제상품판매'}">selected</c:if>>불법또는규제상품판매</option>
                        <option value="혐오발언" <c:if test="${enquiryVo.enquiry_type =='혐오발언'}">selected</c:if>>혐오발언</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea class="form-control" id="content" name="content" rows="10" readonly></textarea>
                </div>
                
                       <!-- 첨부파일 리스트 -->
				<div class="form-group" id="uploadedList">
				<c:forEach items="${enquiryVo.imageList}" var="vo">
					<li>
						<img src="/hn/manager/display?fileName=${vo.upload_path}/${vo.uuid}_${vo.image_name}"/>
					</li>
				</c:forEach>
				</div>
               
            
        </div>
        <div class="col-md-2"></div>
    </div>
</div>
		
		
		
	</div>
</div>
            </div> <!-- card-body -->
        </div>
    </div>
</div>



<div class="row">

     <!-- Area Chart -->
     <div class="col-xl-12 col-lg-12">
         <div class="card shadow mb-4">
            <div
                 class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                 <h6 class="m-0 font-weight-bold text-primary">답변</h6>
                 
             </div>
             <div class="card-body"> 

<div class="row">
	<div class="col-md-12">

				<!-- 답변 입력 -->

					<div class="form-group">
					    <textarea class="form-control" id="replyContent" name="replyContent" rows="5"
					    <c:if test="${enquiryVo.status == '처리완료'}">readonly</c:if>
					    ><c:if test="${enquiryVo.status == '처리완료'}">${replyVo.reply_content}</c:if></textarea>
					</div>
					<div class="col-md-12 text-right">
					    <button id="btnReplyOk" type="button" class="btn btn-primary btn"
					        <c:if test="${enquiryVo.status == '처리완료'}">disabled</c:if>>처리 완료</button>
					</div>
						
				<!-- // 답변 입력 -->
	</div>
</div>
            </div> <!-- card-body -->
        </div>
    </div>
</div>


 <%@ include file="/WEB-INF/views/hn/manager/include/footer.jsp" %>