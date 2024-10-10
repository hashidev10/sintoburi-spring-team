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
		$(this).hide();
		$(this).next().show();
	});

	// 삭제폼전송
	$("#btnDel").click(function () {
		$("#frmDel").submit();
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
                 <h6 class="m-0 font-weight-bold text-primary">자주하는 질문</h6>
                 
             </div>
             <!-- Card Body -->
             <div class="card-body"> 

				<div class="row">
                        <div class="col-md-12">
                            <form role="form" action="/hn/manager/faq/faqMod" method="post" >
                                <input type="hidden" name="f_no" value="${faqVo.f_no}"/>
                                <div class="form-group">
                                    <label for="title">제목</label>
                                    <input  type="text" class="form-control editable" id="title" name="title" value="${faqVo.title}" readonly />
                                </div>

                                <div class="form-group">
                                    <label for="content">내용</label>
                                    <textarea rows="10" class="form-control editable" id="content" name="content" readonly>${faqVo.content}</textarea>
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
							<form id="frmDel" action="/hn/manager/faq/faqDel" method="post">
								<input type="hidden" name="f_no" value="${faqVo.f_no}"/>
							</form>
						<!-- // 삭제 폼 -->
                        </div>
                    </div>
            </div> <!-- card-body -->
        </div>
    </div>
</div>




 <%@ include file="/WEB-INF/views/hn/manager/include/footer.jsp" %>