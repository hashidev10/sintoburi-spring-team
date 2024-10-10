<%@ include file="/WEB-INF/views/include/header.jsp" %>
        
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 


    
<link rel="stylesheet"
href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
crossorigin="anonymous">

	
<script>

$(function(){
	
	getReply();
	// 게시글 삭제버튼
	$("#btnDelete").click(function() {
		console.log("삭제 버튼 클릭");
		$("#frmDelete").append($("#actionForm > input"));

		$("#frmDelete").submit();
	});
	
	
	// 댓글작성 보이기
	$("#viewCommentEdit").click(function(){
		if(${login.user_id==null}){
			$(location).attr("href","/ds/board/login");
			return;
		}
		
		$("#commentEdit").css("display","block");
		$("#commentModifyEdit").css("display","none");
	});
	
	
	
	$("#replyCommit").click(function(){
		
		let data ={
				"bno":${detail.bno},
				"reply":$("#commentContext").val(),

				"replyer":"${login.user_id}"

			
			};
		
		$.ajax({
			type:"POST",
			url:"/ds/reply/commitComment",
			data:JSON.stringify(data), 
			contentType: "application/json; charset=UTF-8",
			async: false,
			success: function(result){
					
				$("#commentContext").val("");


			}
			,error: function(){
				alert("댓글 등록 실패");
			
			}	
	
		});
		
		 getReply();
		
	});
	
	$("#replyView").on("click", ".btnReplyDel", function() {
		
		let rno = $(this).val();
		//let bno= ${detail.bno};
	
		console.log(rno);
		
		$.ajax({
			type:"delete",
			url:"/ds/reply/del/"+rno,
			success: function(result){
				$("#replyView").html("");
				getReply();
				
				}
			,error: function(){
				//alert("댓글 불러오기 실패");
			
			}	
	
		});

	});
	
	$("#modifyCommit").click(function(){
		let sData={
				"rno":rno,
				"reply": $("#commentModifyContext").val()
		}
		$.ajax({
			type:"POST",
			url:"/ds/reply/mod",
			data:JSON.stringify(sData), 
			async:false,
			contentType: "application/json; charset=UTF-8",
			success: function(result){
						$("#commentModifyEdit").css("display","none");
						$("#replyView").html("");
						getReply();
						
				}
			,error: function(){
				
			
			}	
	
		});
	});
	
	let rno;
	
$("#replyView").on("click", ".btnReplyMod", function() {
		
		rno = $(this).val();
		//let bno= ${detail.bno};
	
		$("#commentEdit").css("display","none");
		$("#commentModifyEdit").css("display","block");

	});
	
	
	function getReply(){
		let bno={
				"bno":${detail.bno}
		}
		$.ajax({
			type:"POST",
			url:"/ds/reply/getReply",
			data:JSON.stringify(bno), 
			async:false,
			contentType: "application/json; charset=UTF-8",
			success: function(result){
				//alert("댓글 불러오기 성공");
				let tr=null;	// 댓글 보기
				let loginUser='${login.user_id}';
				for(let i=result.length-1; i>=0; i--){
					let date = new Date(${result[i].replyDate});
					
					if(loginUser==`\${result[i].replyer}`){
					 tr += `
					<tr>
						<td>\${result[i].reply}</td>
						<td>\${result[i].replyer}</td>
						<td>\${date}</td>
						<td><button type="button" class="btn btn-danger btnReplyDel"
						value=\${result[i].rno}>삭제</button></td>
						<td><button type="button" class="btn btn-warning btnReplyMod"
						value=\${result[i].rno}>수정</button></td>
						
						
					</tr>`;
				} else{
					 tr += `
							<tr>
								<td>\${result[i].reply}</td>
								<td>\${result[i].replyer}</td>
								<td>\${date}</td>
						
								
							</tr>`;
					
				}
			
					$("#replyView").html(tr);
					
					}
				}
			,error: function(){
				//alert("댓글 불러오기 실패");
			
			}	
	
		});
		
	}
	

	$("#btnShowComplain").click(function(){
		if(${login.user_id==null}){
			alert("로그인을 해주세요");
			$(location).attr("href","/ds/board/login");
			return;
		}
		console.log("모달");
		$("#modal-complain").modal("show");
		//$('.modal-title').text("팔로우");
	});
	

	$("#btnComplainOk").click(function(){	// 신고하기 버튼을 눌렀을때
	
		
		let data={
				
				"post_url":"/ds/board/read?bno=",
				"post_id":"${detail.writer}",
				"re_reason":$(".complain:checked").val(),
				"re_id":"${login.user_id}",
				"delete_url":"/ds/board/delete",
				"category":"bno",
				"write_num":${detail.bno}
				
		};		
		console.log(data);
	
		
		$.ajax({
			type:"POST",
			url:"/ds/report/addReport",
			data:JSON.stringify(data), 
			async:false,
			contentType: "application/json; charset=UTF-8",
			success: function(result){
			console.log(result);
			$("#modal-complain").modal("hide");
			
			setTimeout(() => {
				alert("신고가 접수되었습니다");
			}, 500);
			
				}
			,error: function(){
			console.log("에러");
			
			}	
	});
		
});
	
	$("#btnModalClose").click(function(){
		$("#modal-complain").modal("hide");
	});
	
	
	
	if("${result}"=="true"){
		console.log("하트체크")
		$("#heart").css("color","red");
		$("#likeCount").html("${likeCount}");
	} else{
		$("#heart").css("color","white");
		$("#likeCount").html("${likeCount}");
	}
	console.log("${result}");
	// 하트수
	let count = parseInt(${likeCount});
	
	
	$("#likeButton").click(function(){
		
	
		console.log("좋아요");
		let data = {
				"user_id":"${login.user_id}",
				"bno": ${detail.bno}
		}
		
		console.log(data);
		

		if($("#heart").css("color")=="rgb(255, 255, 255)"){
		$.ajax({
			type:"post",
			url:"/ds/board/checkLike",
			data : JSON.stringify(data),
			contentType:"application/json; charset=utf-8",
			success : function(result){
				
				if(result==true){
				
					console.log("좋아요 성공");
					$("#heart").css("color","red");
					$("#likeCount").text(++count);
					return;
					
				} else{
					console.log("좋아요 실패");
				}
				
			}, error : function(){
				$(location).attr("href","/ds/board/login");
			}
		});
		
	}else{
		
		$.ajax({
			type:"post",
			url:"/ds/board/uncheckLike",
			data : JSON.stringify(data),
			contentType:"application/json; charset=utf-8",
			success : function(result){
			
				console.log(result);
				if(result==true){
				
					console.log("좋아요 해제 성공");
					$("#heart").css("color","white");
					
					$("#likeCount").text(--count);
					return;

				} else{
					$(location).attr("href","/ds/board/login");
				}
				
			} , error : function(){
				alert("로그인이 필요합니다");
			}
			
		});
	}
	
		
	});
	
	
	
});




</script>

<body>




<!-- 신고 모달창 -->
<!------------- Modal --------------->
 <div class="row">
	<div class="col-md-12">
		<div class="modal fade" id="modal-complain" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="myModalLabel">
							신고하기
						</h5> 
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">
					
						<div class="my-3">
							부적절한 표현/욕설<input type="radio" class="complain" name="complain" value="욕설" checked><br>
							제한된 품목을 판매하거나 홍보함<input type="radio" class="complain" name="complain" value="욕설" ><br>
							스캠, 사기 또는 스팸<input type="radio" class="complain" name="complain" value="사기" ><br>
							거짓정보<input type="radio" class="complain" name="complain" value="거짓">
						</div>
					</div>
					<div class="modal-footer">
						 
						<button type="button" class="btn btn-primary"
							id="btnComplainOk">
							신고하기
						</button> 
						<button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnModalClose">
								취소
						</button>
					</div>
				</div>
				
			</div>
			
		</div>
		
	</div>
</div>
<!-- // 신고 모달창 -->







	<!-- 삭제 폼 -->
	<form id="frmDelete" action="/ds/board/delete" method="post">
		<input type="hidden" name="bno" value="${detail.bno}" />
	</form>
	<!-- // 삭제 폼 -->

	<div class="row">
		<div class="col-md-12">
			<form role="form">
			<br>
				<div class="form-group" style="margin-left:px;font-weight:bold;font-size:25px;">
			 제목<input type="text" value="${detail.title}" class="form-control" readonly >		
				</div>
				<div class="form-group">
			 카테고리<input type="text" value="${detail.category}" class="form-control" readonly >		
				</div>
			<div class="form-group">
			 작성자<input type="text" value="${detail.writer}" class="form-control" readonly >		
				</div>
				<div class="form-group">
			 조회수<input type="text" value="${detail.view_count}" class="form-control" readonly >		
				</div>
				<hr>
				<div class="form-group">
					 
					<label for="" style="margin-left:px;font-size:20px;margin-bottom:300px;">
							${detail.content}
					</label>
				
				</div>
				<!-- 이모티콘	추가할지 검토 -->
				
			

			<hr>	
				<div style="margin-left:1741px;">
					
					<a class="btn btn-danger"  id="btnShowComplain">신고</a>
					
					
				</div>
			<hr>
<!-- 좋아요 -->
			<div style="clear: both; text-align: center">
				<button type="button" class="btn btn-success" id="likeButton">
					<span id="heart" style="color: white; font-size: 30px;"><i
						class="fas fa-solid fa-heart"></i></span> <span
						style="margin-left: 10px; font-size: 30px; display:;" id="likeCount"></span>
				</button>
			</div>
<!-- //좋아요 -->	
		<c:if test="${login.user_id == detail.writer}">
				<div style="margin-left:1680px;">
				<a type="button" class="btn btn-outline-warning" href="/ds/board/modify?bno=${detail.bno}">
					수정
				</a>
				<button type="button" class="btn btn-outline-danger" id="btnDelete">
					삭제
				</button>
				</div>	
		</c:if>	
<!-- 댓글 -->
				<div>
				<h3>
				댓글
				</h3>
				<button type="button" class="btn btn-primary" id="viewCommentEdit">댓글쓰기</button>
				
	<div style="display:none;" id="commentEdit">
	<textarea rows="10" cols="100" id="commentContext"></textarea>
	<button type="button" class="btn btn-primary" id="replyCommit">작성</button>			
	</div>	
	
	<div style="display:none;" id="commentModifyEdit">
	<textarea rows="10" cols="100" id="commentModifyContext"></textarea>
	<button type="button" class="btn btn-warning" id="modifyCommit">댓글수정</button>			
	</div>	
				
	<div class="row">
		<div class="col-md-12">
			<table class="table">
				<thead>
					<tr>
						<th>
							내용
						</th>
						<th>
							작성자
						</th>
						<th>
							작성일
						</th>
					</tr>
				</thead>
				<tbody id="replyView">
				
					
				</tbody>
			</table>
		</div>
	</div>

		
				</div>
<!-- /댓글 -->				
				
				
			</form>
		</div>
	</div>

</body>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>  