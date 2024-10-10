<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="/WEB-INF/views/include/top.jsp"%>

<style>
/* 스타일은 기존 등록 폼과 동일하게 유지 */
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
    function showImage(fileCallPath) {
        console.log("showImage...:", fileCallPath);
        
        $(".bigPictureWrapper").css("display", "flex").show();
        $(".bigPicture").html(`<img src="/display?file_name=\${fileCallPath}">`)
                        .animate({
                            width: "100%",    
                            height: "100%"
                        }, 1000, function() {
                            alert("이미지 보이기 완료");
                        });
                        
        setTimeout(function() {
            $(".bigPicture").animate({
                    width: "0%",    
                    height: "0%"
            }, 1000);
            $(".bigPictureWrapper").fadeOut(1000);
            
        }, 2000);            
    } 

    function checkImage(fileName) {
        let dotIndex = fileName.lastIndexOf(".");
        let extName = fileName.substring(dotIndex + 1).toLowerCase();
        console.log("extName:", extName);
        
        if(extName == "jpg" || extName == "png" || extName == "gif") {
            return true;
        }
        return false;
    }
    
    function uploadFiles(files) {
        let formData = new FormData();
    
        for (let i = 0; i < files.length; i++) {
            let fileName = files[i].name;
            let fileSize = files[i].size;
            
            formData.append("uploadFile", files[i]);
        }
        
        console.log(formData);
        
        // 비동기 전송
        $.ajax({
            type: "post",
            url: "/uploadFormAction",
            contentType: false, 
            processData: false,
            data: formData,
            success: function(rData) {
                console.log("rData:", rData);
                $.each(rData, function(index, obj) {
                    
                    console.log("obj:", obj);
                    let isImage = checkImage(obj.img_name);
                    console.log("isImage:", isImage);
                    let imgTag;
                    let fileName = `\${obj.img_path}/\${obj.uuid}_\${obj.img_name}`;
                    console.log("fileName:", fileName);
                    if (!isImage) {
                            imgTag = `<a href='/download?fileName=\${obj.img_path}\/${obj.uuid}_\${obj.img_name}'>
                                    <img src='/resources/images/default.png' width='100'></a>`;
                    } 
                    else {
                        let path = `\${obj.img_path}/s_\${obj.uuid}_\${obj.img_name}`;
                        let callPath = `\${obj.img_path}/\${obj.uuid}_\${obj.img_name}`;
                        console.log("path:", path); 
                        console.log("callPath:", callPath);
                        imgTag = `<img class="imgImage img-thumbnail"
                        			style="width: 100px; height: 100px;"
                        			src="/display?file_name=\${path}" 
                                    data-callpath="\${callPath}">`;
                    }
                    
                    let liTag = `<li
                    				class="new-li"
                    				style="width:150px;text-align:center"
                                    data-filename="\${obj.img_name}"
                                    data-uploadpath="\${obj.img_path}"
                                    data-uuid="\${obj.uuid}"
                                    >\${imgTag}  \${obj.img_name} <span style="cursor:pointer;"
                                    data-filename="\${fileName}">&times;</span></li>`;
                    console.log("liTag:", liTag);
                    $("#uploadedList").append(liTag);
                });
            }
        });
    }

    $("#divDrop").on("dragenter dragover", function(e) {
        e.preventDefault();
    });
    
    $("#divDrop").on("drop", function(e) {
        e.preventDefault();
        console.log(e.originalEvent.dataTransfer.files);
        let files = e.originalEvent.dataTransfer.files;
        uploadFiles(files);
    });

    $("#uploadedList").on("click", ".imgImage", function() {
        let callPath = $(this).data("callpath");
        showImage(callPath);
    });
    
    // 첨부파일 삭제
    $("#uploadedList").on("click", "li > span", function() {
		// x 링크 클릭하면
		// 해당 li를 화면에서 안보이게 - display:none, old-li 클래스 추가
		let li = $(this).parent();
		li.css("display", "none")
		li.addClass("old-li");
    });

    // 수정폼 전송
    $("#frmUpdate").submit(function(e) {
        $("#uploadedList > li.new-li").each(function(i) {
            let fileName = $(this).data("filename");
            let uploadPath = $(this).data("uploadpath");
            let uuid = $(this).data("uuid");
            
            console.log("FileName:", fileName);
            console.log("UploadPath:", uploadPath);
            console.log("UUID:", uuid);
            
            let inputTag = `<input type="hidden" 
                                    name="imgList[\${i}].img_name" 
                                    value="\${fileName}">
                            <input type="hidden" 
                                    name="imgList[\${i}].img_path" 
                                    value="\${uploadPath}">
                            <input type="hidden" 
                                    name="imgList[\${i}].uuid" 
                                    value="\${uuid}">`;
            $("#frmUpdate").prepend(inputTag);
        });
        
        $("#uploadedList > li.old-li").each(function(i) {
            let fileName = $(this).data("filename");
            let uploadPath = $(this).data("uploadpath");
            let uuid = $(this).data("uuid");
            
            console.log("FileName:", fileName);
            console.log("UploadPath:", uploadPath);
            console.log("UUID:", uuid);
            
            let inputTag = `<input type="hidden" 
                                    name="delList[\${i}].img_name" 
                                    value="\${fileName}">
                            <input type="hidden" 
                                    name="delList[\${i}].img_path" 
                                    value="\${uploadPath}">
                            <input type="hidden" 
                                    name="delList[\${i}].uuid" 
                                    value="\${uuid}">`;
            $("#frmUpdate").prepend(inputTag);
        });
//         return false;
    });
});
</script>

<!-- 수정 폼 -->
<div class="row justify-content-center pt-5 mt-5">
    <div class="col-md-6">
        <form id="frmUpdate" action="/ji/manager/modifyProduct" method="post" role="form">
            <input type="hidden" name="product_no" value="${productVo.product_no}">
        
            <!-- product name -->
            <div class="form-group">
                <label for="name">상품 이름</label>
                <input type="text" class="form-control" id="name" name="product_name" 
                    placeholder="상품 이름 입력" value="${productVo.product_name}"/>
            </div>
            
            <!-- product content -->
            <div class="form-group">
                <label for="summary">상품 간단설명</label>
                <textarea class="form-control" rows="2" id="summary" name="summary" 
                    placeholder="상품 간단내용 입력">${productVo.summary}</textarea>
            </div>

            <!-- product detailed content -->
            <div class="form-group">
                <label for="details">상품 상세설명</label>
                <textarea class="form-control" rows="3" id="details" name="details" 
                    placeholder="상품 상세내용 입력">${productVo.details}</textarea>
            </div>
            
            <!-- product price -->
            <div class="form-group">
                <label for="price">상품 가격</label>
                <input type="number" class="form-control" id="price" name="price" 
                    placeholder="상품 가격 입력" value="${productVo.price}"/>
            </div>
            
            <!-- product stock -->
            <div class="form-group">
                <label for="stock">상품 재고수량</label>
                <input type="number" class="form-control" id="stock" name="stock" 
                    placeholder="상품 재고 입력" value="${productVo.stock}"/>
            </div>
            
            <!-- product status -->
            <div>
                <label for="status">상품 판매 상태:</label><br>
                <input type="radio" id="statusY" name="status" value="Y" ${productVo.status == 'Y' ? 'checked' : ''}>
                <label for="statusY">판매 중</label><br>
                <input type="radio" id="statusN" name="status" value="N" ${productVo.status == 'N' ? 'checked' : ''}>
                <label for="statusN">판매 중지</label>
            </div>
            
            <!-- product cate -->
            <div class="form-group">
                <label for="cate_no">상품 카테고리</label>
                <select class="form-control form-control-lg" id="cate_no" name="cate_no">
                    <option value="1" ${productVo.cate_no == 1 ? 'selected' : ''}>쌀</option>
                    <option value="2" ${productVo.cate_no == 2 ? 'selected' : ''}>잡곡</option>
                    <option value="3" ${productVo.cate_no == 3 ? 'selected' : ''}>과일</option>
                    <option value="4" ${productVo.cate_no == 4 ? 'selected' : ''}>채소</option>
                </select>
            </div>
            
             <!-- 첨부 파일 -->
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">첨부 파일</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div id="divDrop">
                                업로드할 파일을 드래그 &amp; 드롭하세요.
                            </div>    
                            <ul id="uploadedList">
                                <c:forEach var="image" items="${productVo.imgList}">
                                    <li data-filename="${image.img_name}" data-uploadpath="/upload" data-uuid="${image.uuid}"
                                    	style="width:150px;text-align:center">
                                        <img src="/display?file_name=/${imgae_path}/${image.uuid}_${image.img_name}" 
                                             class="img-thumbnail" style="width: 100px; height: 100px;">
                                        
                                        ${image.img_name}
                                        <span class="delete-btn" style="cursor:pointer;" data-filename="/upload/${image.uuid}_${image.img_name}">&times;</span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <button type="submit" class="btn btn-primary" id="btnUpload">상품 수정 완료</button>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/views/include/bottom.jsp"%>