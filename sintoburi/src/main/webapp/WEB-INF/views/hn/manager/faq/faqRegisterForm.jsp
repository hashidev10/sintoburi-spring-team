<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/hn/manager/include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>
$(function() {
		
	$("form").submit(function(e) {
        e.preventDefault(); // 폼의 기본 제출 동작을 방지
        
        let formData = new FormData(this); // 폼 데이터를 FormData 객체로 변환

        $.ajax({
            type: "post",
            url: $(this).attr("action"),
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                alert("자주하는 질문이 등록되었습니다.");
                
                window.location.href = '/hn/manager/faq/faqList'; 
            },
            error: function() {
                alert("등록 실패 , 다시 시도해 주세요.");
            }
        });
    });
});
</script>



<div class="row">

    <div class="col-xl-12 col-lg-12">
        <div class="card shadow mb-4">
            <!-- Card Header - Dropdown -->
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">자주하는 질문</h6>
            </div>
            <!-- Card Body -->
            <div class="card-body"> 
                <div class="row">
                    <div class="col-md-12">
                        <form role="form" action="/hn/manager/faq/faqRegister" method="post">
                            <div class="form-group">
                                <label for="title">제목</label>
                                <input type="text" class="form-control" id="title" name="title" />
                            </div>

                            <div class="form-group">
                                <label for="content">내용</label>
                                <textarea rows="10" wrap="hard" class="form-control" id="content" name="content"></textarea>
                            </div>
                            
                            <div class="col-md-12 text-right">
                                <button class="btnMod btn btn-primary btn-sm" type="submit">등록하기</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div> <!-- card-body -->
        </div>
    </div>
</div>


 <%@ include file="/WEB-INF/views/hn/manager/include/footer.jsp" %>