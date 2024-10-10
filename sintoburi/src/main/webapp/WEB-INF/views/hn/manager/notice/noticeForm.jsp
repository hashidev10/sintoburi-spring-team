<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/hn/manager/include/header.jsp" %>
<script>
$(function() {
    $("#noticeForm").submit(function(e) {
        e.preventDefault(); // 폼의 기본 제출 동작을 방지

        let formData = new FormData(this); // 폼 데이터를 FormData 객체로 변환

        $.ajax({
            type: "post",
            url: $(this).attr("action"),
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                
                alert("공지사항이 등록되었습니다.");
              
                window.location.href = '/hn/manager/notice/noticeList'; 
            },
            error: function(xhr, status, error) {
               
                console.error("등록 실패:", xhr.responseText);
                alert("등록 실패. 다시 시도해 주세요.");
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
                <h6 class="m-0 font-weight-bold text-primary">공지 사항</h6>
            </div>
            <!-- Card Body -->
            <div class="card-body"> 
                <div class="row">
                    <div class="col-md-12">
                        <form id="noticeForm" role="form" action="/hn/manager/notice/noticeRegister" method="post" enctype="multipart/form-data">
                          
                            <div class="form-group">
                                <label for="title">제목</label>
                                <input type="text" class="form-control" id="title" name="title" />
                            </div>
                            
                            <div class="form-group">
			                    <label for="notice_type">항목</label>
			                     <select id=important name="important" class="form-control" style="width: 150px;">
			                        <option value="N" >일반</option>
			                        <option value="Y" >중요</option>
			                        <option value="M" >관리자</option>
			                    </select>
			                </div>

                            <div class="form-group">
                                <label for="content">내용</label>
                                <textarea rows="10" wrap="hard" class="form-control" id="content" name="content"></textarea>
                            </div>

                            <div class="form-group">
                                <label for="image">첨부파일</label>
                                <input type="file" id="image" name="image" multiple>
                            </div>

                            <div class="col-md-12 text-right">
                                <button id="btnNotice" class="btnMod btn btn-primary btn-sm" type="submit">등록하기</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div> <!-- card-body -->
        </div>
    </div>
</div>



 <%@ include file="/WEB-INF/views/hn/manager/include/footer.jsp" %>