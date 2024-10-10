<%@ include file="/WEB-INF/views/include/header.jsp" %>
        
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 


<script>

$(function() {
	let category = $(".btnCate:first").text();
	let thumb=null;
	$("#category").val(category);
	$(".btnCate").click(function(){
		category = $(this).text();
		$("#category").val(category);
		console.log(category);
   });
	
	console.log(category);
	
	
	$('.summernote').summernote({
	      
		
		  height: 800,
		  lang: 'ko-KR',
		  // 에디터에 커서 이동 (input창의 autofocus)
		  toolbar: [
			    // 글자 크기 설정
			    ['fontsize', ['fontsize']],
			    // 글자 [굵게, 기울임, 밑줄, 취소 선, 지우기]
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    // 글자색 설정
			    ['color', ['color']],
			    // 표 만들기
			    ['table', ['table']],
			    // 서식 [글머리 기호, 번호매기기, 문단정렬]
			    ['para', ['ul', 'ol', 'paragraph']],
			    // 줄간격 설정
			    ['height', ['height']],
			    // 이미지 첨부
			    ['insert',['picture']]
			  ],
		
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
			
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72','96'],
	    
			focus : true,
	        // callbacks
			callbacks : {                                                    
				onImageUpload : function(files, editor, welEditable) {   
	               
					for (var i = 0; i < files.length; i++) {
						imageUploader(files[i], this);
					}
				}
			}
			
	  });
	


	
	function imageUploader(file, el) {
		var formData = new FormData();
		formData.append('file', file);
	  	//console.log(formData);
		$.ajax({                                                              
			data : formData,
			type : "POST",
			url : '/ds/upload/image-upload',  
			contentType : false,
			processData : false,
			enctype : 'multipart/form-data',                                  
			success : function(data) {   
				$(el).summernote('insertImage', "${pageContext.request.contextPath}/resources/assets/images/upload/"+data, function($image) {
					//$image.css('width', "25%"); // 기본 이미지 크기
				
				});
	      
				console.log(data);
			}
		});
	}

	$("#btnWrite").click(function(){
		let content  =$("#content").val();
		let img = $(content).find("img").attr('src');

// 		if(img===undefined){  
			// 이미지가 없어도 되는 게시판을 만드는 경우 사용
// 		}
			
		console.log(content);
		console.log(img);
		
		let data ={
			"title":$("#title").val(),
			"writer":"${login.user_id}",
			"content":$("#content").val(),
			"category":category,
			"thumbnail":img
		
		};

		
		$.ajax({
			type:"POST",
			url:"/ds/board/writePost",
			data:JSON.stringify(data), 
			contentType: "application/json; charset=UTF-8",
			success: function(result){
				if(result){
					// 글작성에 성공하면 index로 이동
					$(location).attr("href","/ds/board/index");
				}
			}
			,error: function(){
				alert("이미지를 등록해주세요!");
			
			}	
	
		});
	
	});
});

</script>
<body>
<div class="row" style="margin-left:300px;margin-right:auto;">
		<div class="col-md-10">
			<span style="font-size:25px;">글제목</span>      
				<input type="text" class="form-control" id="title" name="title" required/>
				
			<form role="form">
				<div class="form-group">
			
				<!-- 글 카테고리 -->
				<div>
                 <a class="nav-link dropdown-toggle" id="navbarDropdown"  href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">카테고리</a>
                     <ul class="dropdown-menu" aria-labelledby="navbarDropdown" >
                         <li><a type="button" class="dropdown-item btnCate">자유게시판</a></li>
                             <li ><hr class="dropdown-divider"/></li>
                             <li><a class="dropdown-item btnCate" >농산물 이야기</a></li>
                             <li><hr class="dropdown-divider" /></li>
                              <li><a class="dropdown-item btnCate" >레시피 이야기</a></li>
                            
                      </ul>
                   </div>
               
                   <input type="text" class="form-control" id="category" name="category" readonly />
                   
                   
             
                   
				</div>
				<!-- 글내용 입력 -->
				<textarea class="summernote" name="content" id="content" required></textarea>
<!-- 				<span style="font-size:25px;">태그</span>       -->
<!-- 				<input type="text" class="form-control" id="title" /> -->
				
			<br>
			<div style="margin-left:1170px;">
				<a type="button" class="btn btn-outline-danger" id="btnCancel" href="/ds/board/index">
					취소
				</a>
				<button class="btn btn-outline-success"  id="btnWrite" type="button">
					글쓰기
				</button>
			</div>
			<br>	
			</form>
		</div>
	</div>
	


</body>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>  

