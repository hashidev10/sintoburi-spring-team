<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="/WEB-INF/views/include/top.jsp"%>


<style>
/* 테스트 섹션 */
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





/* // 테스트 섹션 */
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
	} // showImage()
	
	// 선생님 설명 체크이미지
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
			url: "/ji/uploadFormAction",
			contentType: false, 
			processData: false,
			data: formData,
			success: function(rData) {
				console.log(rData);
				$.each(rData, function(index, obj) {
					
					console.log("obj:", obj);
					let isImage = checkImage(obj.img_name);
					let imgTag;
					let fileName = `\${obj.img_path}/\${obj.uuid}_\${obj.img_name}`;
					console.log(fileName);
					if (!isImage) {
							imgTag = `<a href='/download?file_name=\${obj.img_path}/\${obj.uuid}_\${obj.img_name}'>
									<img src='/resources/images/default.png' width='100'></a>`;
					} 
					else {
						let path = `\${obj.img_path}/s_\${obj.uuid}_\${obj.img_name}`;
						console.log("path:" + path);
						let callPath = `\${obj.img_path}/\${obj.uuid}_\${obj.img_name}`;
						imgTag = `<img class="imgImage" src="/display?file_name=\${path}" 
									data-callpath="\${callPath}">`;
					}
					
					let liTag = `<li
									data-filename="\${obj.img_name}"
									data-uploadpath="\${obj.img_path}"
									data-uuid="\${obj.uuid}"
									>\${imgTag} <br> \${obj.img_name} <span style="cursor:pointer;"
									data-filename="\${fileName}">&times;</span></li>`;

					$("#uploadedList").append(liTag);
					
					
				});
			}
		}); // $.ajax({
	} // uploadFiles()
	
	$("#divDrop").on("dragenter dragover", function(e) {
		e.preventDefault();
	});
	
	$("#divDrop").on("drop", function(e) {
		e.preventDefault();
		console.log(e.originalEvent.dataTransfer.files);
		let files = e.originalEvent.dataTransfer.files;
		uploadFiles(files);
	});
	
	// 업로드된 파일 중 이미지인 경우 - 이미지 클릭
	// 1. 업로드 된 파일 중 이미지를 클릭한다.
	// 2. 클릭한 이미지로 부터 서버에 저장된 이미지경로(파일명 포함)를 얻어온다.
	// 3. 해당 이미지를 전체화면 이미지로 보인다.
	$("#uploadedList").on("click", ".imgImage", function() {
		let callPath = $(this).data("callpath"); // data-callpath
		showImage(callPath);
	});
	
	
	// 첨부파일 삭제
	$("#uploadedList").on("click", "li > span", function() {
		let that = $(this);
	  	let filename = that.data("filename");
		let sData = {file_name: filename};
		console.log("sData:", sData);
		$.ajax({
			type: "delete",
			url: "/delete",
			data: sData,
			success: function(rData) {
				console.log(rData); // success
				that.parent().fadeOut(1000); // <li>
			}
		});
	});
	// 첨부파일 삭제
	
	
	// 등록폼 전송
	$("#frmRegister").submit(function(e) {
// 		e.preventDefault();		
		$("#uploadedList > li").each(function(i) {
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
			$("#frmRegister").prepend(inputTag);
		});
// 		return false; // 폼전송 안함
		
	}); // 등록폼 전송
	
});
</script>    

<!-- 등록 폼 -->
<div class="row justify-content-center pt-5 mt-5">
    <div class="col-md-6">
        <form id="frmRegister" action="/ji/manager/register" method="post" role="form">
        	<!-- product name -->
            <div class="form-group">
                <label for="product_name">상품 이름</label>
                <input type="text" class="form-control" id="product_name" name="product_name" placeholder="상품 이름 입력"/>
            </div>
            
            <!-- product content -->
            <div class="form-group">
                <label for="summary">상품 간단설명</label>
                <textarea class="form-control" rows="2" id="summary" name="summary" placeholder="상품 간단내용 입력"></textarea>
            </div>

            <!-- product detial content -->
            <div class="form-group">
                <label for="details">상품 상세설명</label>
                <textarea class="form-control" id="details" name="details" wrap="hard" placeholder="상품 상세내용 입력"></textarea>
            </div>
            
            <!-- product price -->
            <div class="form-group">
                <label for="price">상품 가격</label>
                <input type="number" class="form-control" id="price" name="price" placeholder="상품 가격 입력"/>
            </div>
            
            <!-- product stock -->
            <div class="form-group">
                <label for="stock">상품 재고수량</label>
                <input type="number" class="form-control" id="stock" name="stock" placeholder="상품 재고 입력"/>
            </div>
            
            <!-- product status -->
            <div>
		        <label for="status">상품 판매 상태:</label><br>
		        <input type="radio" id="statusY" name="status" value="Y" checked>
		        <label for="statusY">판매 중</label><br>
		        <input type="radio" id="statusN" name="status" value="N">
		        <label for="statusN">판매 중지</label>
		    </div>
            
            <!-- product cate -->
            <div class="form-group">
                <label for="cate_no">상품 카테고리</label>
                <select class="form-control form-control-lg" id="cate_no" name="cate_no">
		            <option value="1">쌀</option>
		            <option value="2">잡곡</option>
		            <option value="3">과일</option>
		            <option value="4">채소</option>
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
						
							<div id="divDrop" onclick="showImage('a');">
								업로드할 파일을 드래그 &amp; 드롭하세요.
							</div>	
							<ul id="uploadedList">
							
							</ul>
						
	        			</div>
	        		</div>
	        	</div>
	        </div>
	        <!-- // 첨부 파일 -->
	        
            
            <button type="submit" class="btn btn-primary" id="btnUpload">상품 등록 완료</button>
            
        </form>
    </div>
</div>



<%@ include file="/WEB-INF/views/include/bottom.jsp"%>

