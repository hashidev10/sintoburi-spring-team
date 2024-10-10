<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/hn/manager/include/header.jsp" %>
<script>
$(function() {
	// 수정버튼
	$("#btnMod").click(function () {
		$(".editable").prop("readonly", false);
		$(".sEditable").prop("disabled",false);
		$(this).hide();
		$(this).next().show();
		$(".btnImageDelete").show();
		$("#imageUpload").show();
	});

	// 삭제폼전송
	$("#btnDel").click(function () {
		$("#frmDel").submit();
	});
	 
	 $("#noticeForm").submit(function(e) {
	        e.preventDefault(); 
	        
	        let formData = new FormData(this); 

	        $.ajax({
	            type: "post",
	            url: $(this).attr("action"),
	            data: formData,
	            contentType: false,
	            processData: false,
	            success: function(response) {
	                
	                alert("공지사항이 수정되었습니다.");
	                
	                window.location.href = "/hn/manager/notice/noticeList"; 
	            }
	        });
	    });
	 
	 $(".btnImageDelete").click(function(){
//		  	let uuid = $(this).data("uuid");
			let src = $(this).prev().attr("src");
			let imagePath = src.substring(src.indexOf("=") + 1);
			
		  	console.log(imagePath);
			let input = $("<input>").attr({
	        	type: "hidden",
	            name: "imageDel",  
	            value: imagePath
	        });
	        
			$("#noticeForm").append(input);
			
			$(this).parent().remove();

	  });
	
});
  
</script>


<div class="row">

     <!-- Area Chart -->
     <div class="col-xl-12 col-lg-12">
         <div class="card shadow mb-4">
             <!-- Card Header - Dropdown -->
             <div
                 class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                 <h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
                 
             </div>
             <!-- Card Body -->
             <div class="card-body"> 

				<div class="row">
                        <div class="col-md-12">
                            <form id="noticeForm" role="form" action="/hn/manager/notice/noticeMod" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="n_no" value="${noticeVo.n_no}"/>
                                <div class="form-group">
                                    <label for="title">제목</label>
                                    <input  type="text" class="form-control editable" id="title" name="title" value="${noticeVo.title}" readonly />
                                </div>
                                
                                <div class="form-group">
			                    <label for="notice_type">항목</label>
			                     <select id="important" name="important " class="form-control sEditable" style="width: 150px;" disabled>
			                         <option value="N" <c:if test="${noticeVo.important == 'N'}">selected</c:if>>일반</option>
   									 <option value="Y" <c:if test="${noticeVo.important == 'Y'}">selected</c:if>>중요</option>
   									 <option value="M" <c:if test="${noticeVo.important == 'M'}">selected</c:if>>관리자</option>
			                    </select>
			               	 </div>

                                <div class="form-group">
                                    <label for="content">내용</label>
                                    <textarea rows="10" class="form-control editable" id="content" name="content" readonly>${noticeVo.content}</textarea>
                                </div>
                                
								
								 <!-- 첨부파일 리스트 -->
							<div class="form-group" id="uploadedList">
							    <c:forEach items="${noticeVo.imageList}" var="vo">
							        <li  class="d-inline-block mr-2" style="position: relative; display: inline-block;">
							            <img src="/hn/manager/display?fileName=${vo.upload_path}/${vo.uuid}_${vo.image_name}" class="img-thumbnail" style="width: 100px; height: auto;"/>
							            <button type="button" class="btn btn-danger btn-sm btnImageDelete" data-uuid="${vo.uuid}" style="position: absolute; top: 0; right: 0; display: none;">x</button>
							        </li>
							    </c:forEach>
							</div>
							
							<div class="form-group" id= "imageUpload" style="display: none;">
                                    <label for="image">첨부파일</label>
                                    <input  type="file" id="image" name="image" multiple>
                                </div>

                             
                                 <div class="row">
						        <div class="col-md-12 text-right">
						            <button id="btnMod" type="button" class="btn btn-warning btn-submit">수정</button>
						            <button id="btnModOk" type="submit" class="btn btn-warning btn-submit" style="display:none">수정완료</button>
						            <button id="btnDel" type="button" class="btn btn-danger btn-submit">삭제</button>
						        </div>
						    </div>
                            </form>
                            <!-- 삭제 폼 -->
							<form id="frmDel" action="/hn/manager/notice/noticeDel" method="post">
								<input type="hidden" name="n_no" value="${noticeVo.n_no}"/>
							</form>
						<!-- // 삭제 폼 -->
                        </div>
                    </div>
            </div> <!-- card-body -->
        </div>
    </div>
</div>




 <%@ include file="/WEB-INF/views/hn/manager/include/footer.jsp" %>