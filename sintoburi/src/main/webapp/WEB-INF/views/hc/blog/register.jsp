<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="/resources/css/hc/register.css">
<head>
    <meta charset="UTF-8">
    <title>작성창</title>
			        
    <!-- css 끝 -->
</head>
<script type="text/javascript">
$(function () {
	// 파일 타입 확인
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz|pdf|txt)$");
	// run.exe , smile.zip...
	let maxSize = 5242880; // 5MB 업로드 최대 크기 확인
	let imageNum = 0;
	function checkExtension (file_name, fileSize) {
		if (fileSize > maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		if (regex.test(file_name)) {
			alert("해당 파일 종류는 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	
	function uploadFiles(files) {
		// <form>
		let formData = new FormData();
		for (let i = 0; i < files.length; i++) {
			let file_name = files[i].name;
			let fileSize = files[i].size;
			if(!checkExtension(file_name, fileSize)){
				return false;
			};
			// <input name="전송값">
			formData.append("uploadFiles", files[i]);
		}
		console.log(formData);
		
		// 비동기 전송
		$.ajax({
			type: "post",
			url: "/uploadFormAction",
			contentType: false,
			processData: false,
			data : formData,
			success: function(rData) {
				console.log(rData); // List<attachFileDto>
				$.each(rData,function(index, obj){
					let imgcard;
					let file_name = `\${obj.file_path}/\${obj.uuid}_\${obj.file_name}`;
					if(!obj.image){
						imgTag = `<a href='/download?file_name=\${obj.file_path}/\${obj.uuid}_\${obj.file_name}'><img src='/resources/default.png' width='100'></a>`;
					} else {
						let path = obj.file_path + "/"+ obj.uuid + "_" + obj.file_name;
						console.log("파일패스는?", path);
						let callPath = obj.file_path + "/" + obj.uuid + "_" + obj.file_name;
						imgTag = `
							<img class="d-block w-100" alt="First Image" src="/display?file_name=\${path}" data-callpath="\${callPath}">
							<span class="delete-button" style="cursor:pointer; position: absolute; top: 10px; right: 10px;" data-file_name="\${file_name}">이미지 삭제</span>
							`;
					}
					if(imageNum == 0) {
						imgcard =`<div class="carousel-item active"
								   		data-file_name="\${obj.file_name}"
										data-file_path="\${obj.file_path}"
										data-uuid="\${obj.uuid}"
										data-type="\${obj.image}">
										\${imgTag}</div>`;					
					} else {
						imgcard =`<div class="carousel-item"
								   		data-file_name="\${obj.file_name}"
										data-file_path="\${obj.file_path}"
										data-uuid="\${obj.uuid}"
										data-type="\${obj.image}">
										\${imgTag}</div>`;					
					}											
					imageNum++;
					$("#carousel-list").append(imgcard);
				})
			}
		})
	}
	
	
	
	
	const inputFile = $("input[name=uploadFiles]");
	
	 $("#divDrop").on("dragenter dragover", function(e) {
        e.preventDefault();
        $(this).addClass("dragover");
    });

    $("#divDrop").on("dragleave drop", function(e) {
        e.preventDefault();
        $(this).removeClass("dragover");
    });

	
	$("#divDrop").on("drop", function (e) {
		e.preventDefault();
		console.log(e.originalEvent.dataTransfer.files);
		let files = e.originalEvent.dataTransfer.files;
		uploadFiles(files);
	});
	
	$(document).on("click", ".delete-button", function () {
	    let file_name = $(this).data("file_name");
	    let that = $(this);
	    let sData = { file_name : file_name };
	    console.log("삭제클릭" + sData);
	    imageNum--;
	    // 서버에서 파일 삭제 요청
	    $.ajax({
	        type: "delete",
	        url: "/delete",
	        data: sData,
	        success: function(rData) {
	            // 현재 삭제하려는 이미지가 active 클래스가 있는지 확인
	            if (that.closest('.carousel-item').hasClass('active')) {
	                let nextItem = that.closest('.carousel-item').next('.carousel-item');
	                let prevItem = that.closest('.carousel-item').prev('.carousel-item');

	                // 다음 이미지가 있으면 다음 이미지를 active로 만들고, 없으면 이전 이미지를 active로 만듦
	                if (nextItem.length) {
	                    nextItem.addClass('active');
	                } else if (prevItem.length) {
	                    prevItem.addClass('active');
	                }
	            }

	            that.closest('.carousel-item').remove(); // 이미지와 삭제 버튼을 포함한 전체 div를 삭제
	        },
	        error: function(err) {
	            console.error("파일 삭제 실패:", err);
	        }
	    });
	});
	
	
	// 등록폼 전송
	$("#frmRegister").submit(function () {
		$("#carousel-list > div").each(function (i) {
			let file_name = $(this).data("file_name");
			let file_path = $(this).data("file_path");
			let uuid = $(this).data("uuid");
			let inputTag = `
				<input type="hidden" name="fileList[\${i}].file_name" value="\${file_name}" >
			    <input type="hidden" name="fileList[\${i}].file_path" value="\${file_path}" >
		 		<input type="hidden" name="fileList[\${i}].uuid" value="\${uuid}" >
		 		`;
		 		console.log("시작");
		 		console.log(file_name);
		 		console.log(file_path);
		 		console.log(uuid);
			$("#frmRegister").prepend(inputTag);
		});
		
		$("#productList > li").each(function (i) {
			let product_no = $(this).attr("data-product_no");
			let product_name = $(this).attr("data-product_name");
			let productTag = `
				<input type="hidden" name="productTagList[\${i}].product_no" value="\${product_no}" >
				<input type="hidden" name="productTagList[\${i}].product_name" value="\${product_name}" >
			`;
			$("#frmRegister").prepend(productTag);
		});											
		
		//return false;
	});
	
	
	// 상품태그 삭제
	// server.xml 에서<connerct port="80" parseBodyMethods="POST,PUT,PATCH,DELETE">
	$("#productList").on("click", "li", function () {
		console.log("삭제작동");
		$(this).remove();
	});
	
	$("#modal-product-tag-list").on("click", "a", function () {
		let productId = $(this).attr("data-product_no");
        let productName = $(this).attr("data-product_name");
        
        let isExist = false;
        $("#productList li").each(function() {
			if($(this).attr("data-product_no") == productId) {
				isExist = true;
				return false;
			}
		})
        if(!isExist) {
	        let liTag = `
	        	<li class="tag-delete" style="cursor:pointer" ;
	        		data-product_no="\${productId}"
					data-product_name="\${productName}"
	        	>(<span>\${productId}</span>)\${productName}</li>
	        `;
			$("#productList").append(liTag);
			$("#modal-product-tag-list").empty(); // 모달의 리스트 초기화
			$("#modal-tag-value").val(''); // 입력 필드 초기화
			$('#product-tag-modal').modal('hide');
        } else {
			alert("추가한 상품태그입니다.");     	
        }
	});
	
	$("#product-modal-btn").click(function () {
		$("#product-tag-modal").modal('show');
	});
	
	$("#ProductSearchBtn").click(function () {
		let type = $("#tag-search").val();
		let value = $("#modal-tag-value").val().trim();
		console.log(type);
		console.log(value);
		let sData;
		if(type == 'tag-number') {
			sData = { 'product_no' : parseInt(value) };
		} else {
			sData = { 'product_name' : value };
		}
		$.ajax({
			type : "post",
			url : "/hc/product/getList",
			data : JSON.stringify(sData),
			contentType: "application/json; charset=utf-8",
			success : function (rData) {
				$("#modal-product-tag-list").empty();
				$.each(rData, function (index, vo) {
					let tag = `
					<tr>
						<td>\${vo.product_no }</td>
						<td><a class="text-primary"
							data-product_no="\${vo.product_no }"
							data-product_name="\${vo.product_name }"
							>\${vo.product_name }</a></td>
					</tr>
					`;						
					$("#modal-product-tag-list").append(tag);
				});
			}
		});
	});
	
	
});
</script>
<!-- 스크립트 끝  -->
<body>
 <div class="main">
     <div class="image-area">
     <!-- 카루셀 시작 -->
<!-- 카루셀 아이디에 특정값을 넣을것 같으면 삑남 -->
<div id="imageCarousel2"  class="carousel slide" data-ride="carousel" data-interval="false">
    <div id="carousel-list" class="carousel-inner">
    	<!-- 이미지 시작  -->
     <!--   <div class="carousel-item active">
           <img src="/resources/images/black.png" class="d-block w-100" alt="First Image">
       </div> -->
       <!-- 더 많은 이미지가 필요하면 이곳에 추가 -->
   </div>
   <!-- 여기에 위에 넣은 id 넣을것 아래 2개에  -->
    <a class="carousel-control-prev" href="#imageCarousel2" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#imageCarousel2" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
<!-- 카루셀 끝 -->
     
     
     </div>
     <div class="side-bar">
         <div class="container">
<div class="profile-end">
	<!-- 프로필 -->
	<form id="frmRegister" action="/hc/blog/registerAction" method="post">
	
 <div class="profile head-profile">
		  <div class="profile ">
	          <h3 ><img src="/resources/images/logo.png" alt="프로필 사진"><input name="user_id" value="${login.user_id}" type="hidden">${login.user_name}님의 스토리<input name="user_name" value="${login.user_name}" type="hidden"></input></h3>
		  </div>
      </div>
      <!-- 본문 내용  -->
      <div class="profile-section main-content">
          <h3 class="text-end">본문내용</h3>
          <textarea name="blog_content" id="main-content"></textarea>
      </div>
      <!-- 본문 내용끝  -->
      <!-- 첨부 파일 -->
		<div class="card shadow mb-4">
	        <div class="card-header py-3">
	            <h6 class="m-0 font-weight-bold text-primary">첨부파일</h6>
	        </div>
	        <div class="card-body">
	     	   <div class="row">
					<div class="col-md-12">
					
					<div id="divDrop">
						업로드할 파일을 드래그 &amp; 드롭 하세요.
					</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 첨부 파일 끝 -->
		<!-- 상품 태그 -->
		<div class="card shadow mb-4">
	        <div class="card-header py-3 product-tag" style="display: flex; justify-content: space-between; align-items: center;">
	            <h6 class="m-0 font-weight-bold text-primary">상품 태그</h6>
	            <button type="button" id="product-modal-btn" class="btn btn-primary" >검색</button>
	        </div>
	        <div class="card-body">
	     	   <div class="row">
					<div class="col-md-12">
						<ul id="productList">
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- 상품 태그 끝 -->
                    
                 <button type="submit" class="btn btn-success">등록</button>
                 <a href="/hc/main/home" class="btn btn-danger">목록으로</a>
	</form>
                   
       </div>
<!-- 프로필 끝  -->
	</div>
     </div>
 </div>
<!-- 상품 태그 모달 창  -->
<div class="modal fade" id="product-tag-modal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myModalLabel">
					상품태그 검색
				</h5> 
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<div>
					<select id="tag-search">
						<option value="tag-number">상품번호</option>
						<option value="tag-name">이름</option>
					</select><input id="modal-tag-value" type="text" placeholder="여기에 입력하세요" >
					<button id="ProductSearchBtn" type="button" class="btn btn-primary">검색</button>
				</div>
				<div>
					<table class="table">
						<thead>
							<tr>
								<th>상품번호</th>
								<th>상품이름</th>
							</tr>
						</thead>
						<tbody id="modal-product-tag-list">
							
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				 
				<button type="button" class="btn btn-danger" data-dismiss="modal">
					취소
				</button>
			</div>
		</div>
		
	</div>
				
</div>



<!-- 상품 태그 모달 창 끝  -->
    
</body>
</html>