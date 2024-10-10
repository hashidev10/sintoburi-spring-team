<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="/WEB-INF/views/include/top.jsp"%>

<style>
/* 기존 스타일을 그대로 유지 */
#divDrop {
    margin: auto;
    width: 70%;
    height: 100px;
    line-height: 100px;
    background: aquamarine;
    border: 2px dashed Orange;
    text-align: center;
}

.bigPictureWrapper {
    position: absolute;
    display: none;
    justify-content: center;
    align-items: center;
    top: 0%;
    width: 100%;
    height: 100%;
    background-color: #88cccccc;
    z-index: 100;
}

.bigPicture {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
}

#uploadedList > li {
    list-style-type: none;
    float: left;
}
</style>

<script>
$(function() {
    // 이미지 추가
    $("#newImageUpload").on("change", function(e) {
        let formData = new FormData();
        let files = e.target.files;

        for (let i = 0; i < files.length; i++) {
            formData.append("uploadFiles", files[i]);
        }

        $.ajax({
            url: '/uploadImage',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function(data) {
                // 서버로부터 응답 받은 이미지 리스트를 화면에 표시
                displayUploadedImages(data);
            },
            error: function(error) {
                alert("이미지 업로드 실패");
            }
        });
    });

    // 이미지 삭제
    $("#uploadedList").on("click", ".delete-btn", function() {
        let uuid = $(this).data("uuid");

        $.ajax({
            url: '/deleteImage',
            type: 'DELETE',
            data: { uuid: uuid },
            success: function(response) {
                if (response === "success") {
                    $(this).closest("li").remove(); // 삭제된 이미지를 화면에서 제거
                } else {
                    alert("이미지 삭제 실패");
                }
            }.bind(this),  // 여기서 this는 삭제 버튼
            error: function(error) {
                alert("이미지 삭제 중 오류 발생");
            }
        });
    });

    function displayUploadedImages(images) {
        images.forEach(image => {
            let imgElement = `<li><img src="/display?file_name=${image.imgPath}/s_${image.uuid}_${image.imgName}" alt="${image.imgName}" />
                              <span class="delete-btn" data-uuid="${image.uuid}">&times;</span></li>`;
            $("#uploadedList").append(imgElement);
        });
    }
});
</script>

<!-- 수정 폼 -->
<div class="row justify-content-center pt-5 mt-5">
    <div class="col-md-6">
        <form id="frmUpdate" action="/ji/manager/updateProduct" method="post" role="form">
            <!-- Hidden input for product ID -->
            <input type="hidden" id="pno" name="pno" value="${product.pno}"/>

            <!-- product name -->
            <div class="form-group">
                <label for="name">상품 이름</label>
                <input type="text" class="form-control" id="name" name="name" 
                       placeholder="상품 이름 입력" value="${product.name}" required/>
            </div>
            
            <!-- product content -->
            <div class="form-group">
                <label for="summary">상품 간단설명</label>
                <textarea class="form-control" rows="2" id="summary" name="summary"
                          placeholder="상품 간단내용 입력">${product.summary}</textarea>
            </div>

            <!-- product detailed content -->
            <div class="form-group">
                <label for="details">상품 상세설명</label>
                <textarea class="form-control" id="details" name="details" wrap="hard"
                          placeholder="상품 상세내용 입력">${product.details}</textarea>
            </div>
            
            <!-- product price -->
            <div class="form-group">
                <label for="price">상품 가격</label>
                <input type="number" class="form-control" id="price" name="price"
                       placeholder="상품 가격 입력" value="${product.price}" required/>
            </div>
            
            <!-- product stock -->
            <div class="form-group">
                <label for="stock">상품 재고수량</label>
                <input type="number" class="form-control" id="stock" name="stock"
                       placeholder="상품 재고 입력" value="${product.stock}" required/>
            </div>
            
            <!-- product status -->
            <div>
                <label for="status">상품 판매 상태:</label><br>
                <input type="radio" id="statusY" name="status" value="Y" 
                       ${product.status == 'Y' ? 'checked' : ''}>
                <label for="statusY">판매 중</label><br>
                <input type="radio" id="statusN" name="status" value="N" 
                       ${product.status == 'N' ? 'checked' : ''}>
                <label for="statusN">판매 중지</label>
            </div>
            
            <!-- product category -->
            <div class="form-group">
                <label for="cate_no">상품 카테고리</label>
                <select class="form-control form-control-lg" id="cate_no" name="cate_no">
                    <c:forEach var="category" items="${categoryList}">
                        <option value="${category.cate_no}" 
                                ${category.cate_no == product.cate_no ? 'selected' : ''}>
                            ${category.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <!-- Existing uploaded files (if any) -->
            <div class="form-group">
                <label>기존 이미지:</label>
                <ul id="uploadedList">
                    <c:forEach var="img" items="${product.imgList}">
                        <li data-filename="${img.img_name}" data-uploadpath="${img.img_path}" data-uuid="${img.uuid}">
                            <img src="/display?file_name=${img.img_path}/s_${img.uuid}_${img.img_name}" 
                                 class="img-thumbnail" width="100">
                            <span class="delete-btn" data-uuid="${img.uuid}">&times;</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <!-- File upload for new images -->
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">첨부 파일</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div id="divDrop">
                                업로드할 파일을 드래그 & 드롭하세요.
                                <input type="file" id="newImageUpload" name="newImageUpload" multiple />
                            </div>    
                            <ul id="uploadedList"></ul>
                        </div>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary" id="btnUpdate">상품 수정 완료</button>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/include/bottom.jsp"%>