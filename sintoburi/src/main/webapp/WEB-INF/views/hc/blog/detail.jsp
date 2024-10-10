<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<!-- 글리피콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<head>
    <meta charset="UTF-8">
    <title>디테일 뷰</title>
<%
   /*  // 현재 요청의 URL을 가져와서 세션에 저장
    String prefixToRemove = "/WEB-INF/views";
    String uri = request.getRequestURI().substring(prefixToRemove.length()); // ? 앞에 문자열
    uri = uri.substring(0, uri.length() - 4);
	String query = request.getQueryString(); // ? 뒤에 문자열
	if(query != null && !query.equals("")) {
		query = "?" + query;
		System.out.println("합쳐진 쿼리는" + query);
	} else {
		query = "";
	}
    session.setAttribute("targetLocation", uri + query); */
%>
    
<script type="text/javascript">


$(function () {
    const textarea = document.getElementById('comment-textarea');

    textarea.addEventListener('input', function() {
        this.style.height = 'auto'; // 먼저 높이를 자동으로 설정
        this.style.height = (this.scrollHeight <= 90 ? this.scrollHeight : 90) + 'px'; // 스크롤 높이를 계산하여 3줄까지만 확장
    });
});

$(function () {
	
	
	
	
	$("#replyBtn").click(function () {
		let replyer = '${login.user_id}';
		let comment = $("#comment-textarea").val();
		let sData = {
				'replyer' : replyer,
				'blog_no' : '${blogVo.blog_no}',
				'reply_content' : comment
		}
		
		$.ajax({
			type : "post",
			url : "/hc/reply/setReply",
			data : JSON.stringify(sData),
			contentType : "application/json; charset=utf-8",
			success : function (rData) {
				if(rData) {
					location.reload();
				}
			} ,
			error: function(xhr, status, error) {
				console.log("에러발생");
		        if (xhr.status === 401) {
		    	   console.log("401에러 발견 작동");
		           // 로그인 페이지로 리디렉션
		           window.location.href = "/ds/board/login";
		        } else {
		           // 다른 오류 처리
		           console.error("Error occurred: " + error);
		        }
			}
		});
	});
	$(".replyModifyBtn").click(function () {
		let commentBox = $(this).closest(".comment-box");
		commentBox.find(".modify-comment").hide();
		commentBox.find(".modify-input").show();
		commentBox.find(".replyModifyOkBtn").show();
		$(this).hide();
	})
	
	
	$(".replyModifyOkBtn").click(function () {
		let replyer = '${login.user_id}';
		let comment = $(this).closest(".comment-box").find(".modify-input").val();
		let blog_rno = $(this).data("blog_rno");
		let sData = {
				'replyer' : replyer,
				'blog_no' : '${blogVo.blog_no}',
				'reply_content' : comment,
				'blog_rno' : blog_rno
		}
		$.ajax({
			type : "post",
			url : "/hc/reply/modify",
			data : JSON.stringify(sData),
			contentType : "application/json; charset=utf-8",
			success : function (rData) {
				if(rData) {
					location.reload();					
				}
			}
		});
	});
	
	$(".replyDeleteBtn").click(function () {
		let blog_rno = $(this).data("blog_rno");
		$.ajax({
			type : "post",
			url : "/hc/reply/delete",
			data : {"blog_rno" : blog_rno},
			success : function(rData) {
				if(rData) {
					location.reload();
				}
			}
		});
	});
	
	$("#likeBtn").click(function () {
		let that = $(this);
		let login_id = '${login.user_id}';
		let blog_no = that.attr("data-blog_no");
		let liked = that.attr("data-liked");
		let sData = {
			'user_id' : login_id,
			'blog_no' : blog_no
		};
		console.log(sData);
		console.log(liked);
		if (liked == "true") {
			$.ajax({
				type : "post",
				url : "/hc/like/removeLike",
				data : JSON.stringify(sData),
				contentType : "application/json; charset=utf-8",
				success : function (rData) {
					//alert("좋아요 취소");
					$.ajax({
						type : "get",
						url : "/hc/like/getSumLike?blog_no=" + blog_no,
						success : function (rData) {
							$(window.parent.document).find("#sumLike" + blog_no).text(rData);
							$(window.parent.document).find("#likeBtn" + blog_no).attr("data-liked", false);
							$(window.parent.document).find("#likeBtn" + blog_no).html('<i class="fa-regular fa-thumbs-up">좋아요</i>');
							
						}
					})
					location.reload();
					
				}  ,
				error: function(xhr, status, error) {
					console.log("에러발생");
			        if (xhr.status === 401) {
			    	   console.log("401에러 발견 작동");
			           // 로그인 페이지로 리디렉션
			           window.location.href = "/ds/board/login";
			        } else {
			           // 다른 오류 처리
			           console.error("Error occurred: " + error);
			        }
				}
			});
		} else {
			$.ajax({
				type : "post",
				url : "/hc/like/addLike",
				data : JSON.stringify(sData),
				contentType : "application/json; charset=utf-8",
				success : function (rData) {
					//alert("좋아요 클릭");
					$.ajax({
						type : "get",
						url : "/hc/like/getSumLike?blog_no=" + blog_no,
						success : function (rData) {
							$(window.parent.document).find("#sumLike" + blog_no).text(rData);
							$(window.parent.document).find("#likeBtn" + blog_no).attr("data-liked", true);
							$(window.parent.document).find("#likeBtn" + blog_no).html('<i class="fa-solid fa-thumbs-up">좋아요</i>');
						}
					})
					location.reload();
				}  ,
				error: function(xhr, status, error) {
					console.log("에러발생");
			        if (xhr.status === 401) {
			    	   console.log("401에러 발견 작동");
			           // 로그인 페이지로 리디렉션
			           window.location.href = "/ds/board/login";
			        } else {
			           // 다른 오류 처리
			           console.error("Error occurred: " + error);
			        }
				}
			});
		}
	});
	
	$("#followBtn").click(function () {
		let that = $(this);
		let login_id = '${login.user_id}';
		let followed_id = that.attr("data-followedId");
		let check = that.attr("data-check");
		let sData = {
			'user_follower' : login_id,
			'user_following' : followed_id
		};
		console.log(sData);
		console.log(check);
		if (check == "true") {
			$.ajax({
				type : "post",
				url : "/hc/follow/removeFollow",
				data : JSON.stringify(sData),
				contentType : "application/json; charset=utf-8",
				success : function (rData) {
					//alert("팔로우 취소");
					$.ajax({
						type : "get",
						url : "/hc/follow/getSumFollow?follow_id=" + followed_id ,
						/* data : { 'follow_id' : followed_id}, */
						success : function (rData) {
							$(window.parent.document).find("#sumFollow" + ${blogVo.blog_no}).text(rData);
						}
					})
					location.reload();
					
				}  ,
				error: function(xhr, status, error) {
					console.log("에러발생");
			        if (xhr.status === 401) {
			    	   console.log("401에러 발견 작동");
			           // 로그인 페이지로 리디렉션
			           window.location.href = "/ds/board/login";
			        } else {
			           // 다른 오류 처리
			           console.error("Error occurred: " + error);
			        }
				}
			});
		} else {
			$.ajax({
				type : "post",
				url : "/hc/follow/addFollow",
				data : JSON.stringify(sData),
				contentType : "application/json; charset=utf-8",
				success : function (rData) {
					//alert("팔로우 클릭");
					$.ajax({
						type : "get",
						url : "/hc/follow/getSumFollow?follow_id=" + followed_id,
						/* data : { 'follow_id' : followed_id}, */
						success : function (rData) {
							$(window.parent.document).find("#sumFollow" + ${blogVo.blog_no}).text(rData);
						}
					})
					location.reload();
				}  ,
				error: function(xhr, status, error) {
					console.log("에러발생");
			        if (xhr.status === 401) {
			    	   console.log("401에러 발견 작동");
			           // 로그인 페이지로 리디렉션
			           window.location.href = "/ds/board/login";
			        } else {
			           // 다른 오류 처리
			           console.error("Error occurred: " + error);
			        }
				}
			});
		}
	});
	
	
	
	
	
});


</script>
<style>
body {
    display: flex;
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    height: 100vh;
    box-sizing: border-box;
    background-color: white;
}
.main {
    display: flex;
    flex-direction: row;
    width: 100%;
    box-sizing: border-box;
}

#followBtn{
	margin-right: 10px;
}

.side-bar {
    /* width: 40%; */
    width: 100%;
    border-left: 1px solid black;
    display: flex;
    flex-direction: column;
    padding: 10px;
    box-sizing: border-box;
    background-color: #F2F2F2;
}

.profile img {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    margin-right: 10px;
}
.content {
    flex-grow: 1;
    margin-bottom: 10px;
}
.comments {
    display: flex;
    flex-direction: column;
}
.comment-input {
    display: flex;
    align-items: center;  /* 버튼과 텍스트가 중앙에 맞춰지도록 */
    width: 100%;
    border: 1px solid black;
    box-sizing: border-box;
    padding: 10px;
    background-color: white;
    border-radius: 10px;
}

.comment-input textarea {
    flex-grow: 1;  /* textarea가 가능한 모든 공간을 차지하도록 설정 */
    height: 30px; /* 초기 높이 설정 */
    max-height: 90px; /* 최대 3줄 높이 */
    overflow-y: auto; /* 3줄 이상일 때 스크롤 표시 */
    resize: none; /* 사용자가 크기 조절 불가 */
    padding: 5px;
    margin-right: 10px;
    box-sizing: border-box;
    border: 1px solid #ddd;
    border-radius: 5px;
}

.comment-input button {
    height: auto; /* 버튼 높이를 textarea 높이에 맞추도록 설정 */
    padding: 5px 10px;
    box-sizing: border-box;
    flex-shrink: 0; /* 버튼이 줄어들지 않도록 설정 */
}


.image-area {
    position: relative;
    /* width: 60%; */
    width : 100%;
    height: 90vh; /* 높이를 전체 화면 높이로 설정 */
    display: flex;
    max-width: 800px; /* 최대 너비 설정 */
    justify-content: center;
    align-items: center;
    overflow: hidden;
    box-sizing: border-box;
    margin-top: 20px;
    margin-left: 20px; 
    margin-right: 20px;
    
}        

.carousel-inner {
    width: 100%;
    height: 100%;
}

.carousel-item img {
    width: 100%;
    height: 100%;
    min-width: 800px; /* 최소 너비 설정 */
    min-height: 800px; /* 최소 높이 설정 */
    object-fit: cover;
}


.carousel-control-prev-icon,
.carousel-control-next-icon {
    background-color: black; /* 화살표 배경색 설정 */
    border-radius: 50%; /* 원형으로 만들기 */
    width: 30px;
    height: 30px;
}

.carousel-control-prev-icon {
    background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns%3D"http://www.w3.org/2000/svg" fill%3D"%23ffffff" viewBox%3D"0 0 8 8"%3E%3Cpath d%3D"M4.5 0l-4 4 4 4 1.5-1.5L3 4l2.5-2.5L4.5 0z"/%3E%3C/svg%3E');
}

.carousel-control-next-icon {
    background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns%3D"http://www.w3.org/2000/svg" fill%3D"%23ffffff" viewBox%3D"0 0 8 8"%3E%3Cpath d%3D"M3.5 0l4 4-4 4-1.5-1.5L5 4 2.5 1.5 3.5 0z"/%3E%3C/svg%3E');
}

/* 프로필 */
.profile-section {
    padding: 10px;
    margin-top : 10px;
    margin-bottom: 10px;
    border-radius: 5px;
    border: 1px solid #ddd;
    background-color: #f8f9fa;
}
.profile-section h3 {
    border-bottom: 2px solid #ddd;
    padding-bottom: 10px;
    margin-bottom: 20px;
}
.profile-header {
	display: flex;
    justify-content: space-between; /* 공간을 양쪽으로 분산하여 버튼이 오른쪽에 위치 */
    align-items: center; /* 버튼과 텍스트가 중앙에 맞춰지도록 정렬 */
}
.profile-section div {
    margin-bottom: 10px;
}
.profile-section span {
    font-weight: bold;
}

.content-text{
	white-space: pre-line;
}

.text-end {
	border-bottom: 2px solid #ddd; /* 테두리 추가 */
	display: flex;
    justify-content: space-between;
    align-items: center;
}
.comment-box {
    display: flex;
    align-items: flex-start;
    padding: 10px;
    margin-top: 10px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 10px;
}

.comment-box img {
         width: 60px;
         height: 60px;
         border-radius: 50%;
         margin-right: 10px;
     }
.comment-box .comment-content {
    background-color: #F2F2F2;
    padding: 10px;
    border-radius: 10px;
    width: 100%;
}
.comment-box .comment-content .author {
    font-weight: bold;
}
.comment-box .comment-content .author-time {
    display: flex;
    justify-content: flex-start;
 	align-items: center;
    margin-bottom: 5px;
}
.time {
	margin-left: 10px;
}
.comment-box .comment-content p {
    margin: 0;
}

.reply {
	max-height: 300px;
	overflow-y: auto; /* 세로 스크롤을 가능하게 설정 */
}
.main-content{
	max-height: 400px;
	overflow-y: auto; /* 세로 스크롤을 가능하게 설정 */
}
.btn-reply{
	margin-left: 10px;
	margin-right: 10px;
}

.comment-input {
	position: sticky;
	bottom: 10px;
	background-color: white;
	padding: 10px;
	border-top: 2px solid #666666;
	border: 1px solid black;  /* 전체 테두리를 검은색으로 설정 */
	z-index: 1;  /* 다른 요소 위에 나타나도록 설정 */
	width: 100%;  /* 너비를 100%로 설정하여 부모 요소의 너비를 꽉 채움 */
	box-sizing: border-box;  /* 패딩과 보더를 포함하여 요소의 전체 너비를 계산 */
	border-radius: 10px;
}
.head-profile{
	border-radius: 5px;
    border: 1px solid #ddd;
    background-color: #f8f9fa;
    padding-top: 3px;
}
		        
</style>
</head>
<body>
	<div class="main">
	<c:if test="${not empty blogVo.fileList }">
    <!-- 카루셀 시작 -->
    <!-- 카루셀 아이디에 특정값을 넣을것 같으면 삑남 -->
    <div id="imageCarousel"  class="carousel slide" data-ride="carousel" data-interval="false">
        <div class="carousel-inner">
            <!-- 더 많은 이미지가 필요하면 이곳에 추가 -->
            <c:forEach items="${blogVo.fileList}" var="file" varStatus="innerstatus">
            <div class="carousel-item ${innerstatus.index == 0 ? 'active' : '' }">
                <img src="/display?file_name=${file.file_path }/${file.uuid}_${file.file_name}" class="d-block w-100" alt="First Image">
            </div>
            </c:forEach>
        </div>
        <a class="carousel-control-prev" href="#imageCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#imageCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <!-- 카루셀 끝 -->
    </c:if>
        </div>
        <div class="side-bar">
            <div class="container">
			<div class="profile-end">
				<!-- 프로필 -->
			 <div class="profile head-profile">
					  <div class="profile profile-header ">
				          <h3><img src="/resources/images/logo.png" alt="프로필 사진">(${blogVo.user_name})님의 스토리</h3>
				          <c:if test="${blogVo.user_id ne login.user_id }">
				          <c:choose>
				          <c:when test="${blogVo.checkFollow eq true }">
				          	<button id="followBtn" class="btn btn-danger" data-followedId="${blogVo.user_id}" data-check="${blogVo.checkFollow }"><i class="fa fa-handshake">취소(<span>${blogVo.sumFollower }</span>)</i></button>
				          </c:when>
				          <c:otherwise>
				          	<button id="followBtn" class="btn btn-primary" data-followedId="${blogVo.user_id}" data-check="${blogVo.checkFollow }"><i class="fa fa-handshake">팔로우(<span>${blogVo.sumFollower }</span>)</i></button>
				          </c:otherwise>
				          </c:choose>
				          </c:if>
					  </div>
			      </div>
			      <!-- 본문 내용  -->
			      <div class="profile-section main-content">
			      	<div class="content-hearder">
			          <h3 class="text-end">본문내용
			          <c:choose>
				          <c:when test="${blogVo.checkLike eq true}">
				          <button id="likeBtn" class="btn btn-danger" data-blog_no="${blogVo.blog_no }" data-liked="${blogVo.checkLike}"><i class="fa-solid fa-thumbs-up">취소(${blogVo.sumLike })</i></button>
				          </c:when>
				          <c:otherwise>
				          <button id="likeBtn" class="btn btn-primary" data-blog_no="${blogVo.blog_no }" data-liked="${blogVo.checkLike}"><i class="fa-regular fa-thumbs-up">좋아요(${blogVo.sumLike })</i></button>
				          </c:otherwise>
				      </c:choose></h3>
			      	</div>
			        <div class="content-text">${blogVo.blog_content }</div>
			      </div>
			      <!-- 본문 내용끝  -->
			        <div class="profile-section reply">
			          <h3 id="comment-line" class="text-end">댓글</h3>
			          <c:forEach items="${replyList}" var="reply">
						  <!-- 댓글 시작 -->
						  <div class="comment-box">
				         	 <img src="/resources/images/logo.png" alt="댓글 작성자 사진">
		                     <div class="comment-content">
		                     	<div class="author-time">
			                       <div class="author">${reply.replyer }</div>
			                       <div class="time">
			                       <c:choose>
			                       		<c:when test="${empty reply.updatedate }"><fmt:formatDate value="${reply.regdate }" pattern="yyyy.MM.dd hh:mm"/></c:when>
			                       		<c:otherwise><fmt:formatDate value="${reply.updatedate }" pattern="yyyy.MM.dd hh:mm"/> (수정)</c:otherwise>
			                       </c:choose> 
			                       </div>
			                       <c:if test="${login.user_id eq reply.replyer }">
			                       <div><button class="btn btn-primary btn-reply replyModifyBtn"  data-blog_rno="${reply.blog_rno}">수정</button></div>
			                       <div><button class="btn btn-success btn-reply replyModifyOkBtn" style="display: none;"  data-blog_rno="${reply.blog_rno}">수정완료</button></div>
			                       <div><button class="btn btn-danger btn-reply replyDeleteBtn"  data-blog_rno="${reply.blog_rno}">삭제</button></div>
			                       </c:if>
		                     	</div>
		                       <p>
		                       <div class="modify-comment">${reply.reply_content }</div>
		                       <input style="display: none;" class="modify-input" value="${reply.reply_content }">
		                       </p>
		                     </div>
		                     </div>
			              <!-- 댓글 끝 -->
			          </c:forEach>
				    </div>
	                  <div class="comment-input">
	                    <textarea  id="comment-textarea" placeholder="댓글 입력창"></textarea>
	                    <button id="replyBtn" class="btn btn-success">등록</button>
	                  </div>
			        </div>
			<!-- 프로필 끝  -->
				</div>
        </div>
    </div>
</body>
</html>