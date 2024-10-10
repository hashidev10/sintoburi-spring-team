<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/top.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/hc/main.css">
<link rel="stylesheet" href="/resources/css/hc/complaint.css">
<!-- 글리피콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
/* 부모 요소를 화면의 전체 높이를 차지하도록 설정하고, 세로 중앙 정렬 */
.story-container-wrapper {
    display: flex;
    justify-content: center; /* 가로 중앙 정렬 제거 */
    align-items: center; /* 세로 중앙 정렬 */
    width: 100%;
    box-sizing: border-box;
    margin-bottom: 20px;
}

.story-card {
    display: flex;
    align-items: center;
    padding: 10px 20px;
    width: 400px;
    border-radius: 10px;
    background-color: white;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.story-icon {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 40px;
    height: 40px;
    margin-right: 15px;
    border-radius: 50%;
    background-color: #e7f3ff;
    color: #007bff;
    font-size: 24px;
    font-weight: bold;
}

.story-text {
    display: flex;
    flex-direction: column;
}

.story-text strong {
    font-size: 16px;
    color: #333;
}

.story-text span {
    font-size: 14px;
    color: #666;
}

/* 검색 바 스타일 */
.search-container {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}

.search-container form {
    display: flex;
    align-items: center;
    background-color: #f8f9fa;
    padding: 10px;
    border-radius: 25px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.search-container select,
.search-container input[type="text"] {
    border: none;
    outline: none;
    padding: 8px 12px;
    margin-right: 10px;
    font-size: 14px;
    border-radius: 5px;
    background-color: #e9ecef;
}

.search-container button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 25px;
    cursor: pointer;
    font-size: 14px;
}

.search-container button:hover {
    background-color: #0056b3;
}



</style>
<%
    /* // 현재 요청의 URL을 가져와서 세션에 저장
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

<script>
$(function () {
	$(document).on("click",".likeBtn",function () {
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
					let container = that.closest(".post-container");
					let countLike = container.find(".sumLike");
					let count = parseInt(countLike.text(), 10);
					countLike.text(count - 1);
					that.attr("data-liked", "false"); // data-liked 값을 "false"로 변경
					that.html('<i class="fa-regular fa-thumbs-up">좋아요</i>');
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
					let container = that.closest(".post-container");
					let countLike = container.find(".sumLike");
					let count = parseInt(countLike.text(), 10);
					countLike.text(count + 1);
					that.attr("data-liked", "true"); // data-liked 값을 "true"로 변경
					that.html('<i class="fa-solid fa-thumbs-up">좋아요</i>');
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
	
	$(document).on("click",".open-modal",function(){
		let blog_no = $(this).data("blog_no");
		$("#myIframe").attr("src", "/hc/blog/detail?blog_no=" + blog_no);
		$(".modal-left").empty();
		$.ajax({
			type : "get",
			url : "/hc/product/getListByBlogNo",
			data : {"blog_no" : blog_no},
			success : function (rData) {
				
				$.each(rData, function (index, obj) {
					let tag = `
						<div class="cover">
	            			<a href="/ji/product/productDetail?pno=\${obj.product_no}"><img src="/display?file_name=\${obj.file_path }/\${obj.uuid}_\${obj.file_name}" alt="/resources/images/logo.png">\${obj.product_name}</a>
	            		</div>`;
					$(".modal-left").append(tag);
				})
			}
		});
		$("#myModal").modal("show");
	});
	
	/* // 모달이 열릴 때마다 실행 
    $('#myModal').on('show.bs.modal', function () {
        let iframe = $(this).find('iframe');
        let src = iframe.attr('src'); // 현재 src를 가져와서
        iframe.attr('src', ''); // 잠시 빈 값으로 변경한 후
        iframe.attr('src', src); // 다시 원래 src로 복원하여 새로고침 효과
    }); */
	
    $('.post-content').each(function() {
        let contentText = $(this).find('.content-text');
        let moreLink = $(this).find('.more-link');
        contentText.css({
            "-webkit-line-clamp": "unset",
            "display": "block",
            "overflow": "visible"
        });

        // 초기 높이 저장
        let originalHeight = contentText.outerHeight();
        //	contentText.outerHeight();

        // 클램프 적용
        contentText.css({
        	"-webkit-line-clamp": "3",
            "display": "-webkit-box",
            "overflow": "hidden"
        });

        // 클램프 적용 후 높이 계산
        let clampedHeight = contentText.outerHeight();

        // 높이 비교
        if (originalHeight > clampedHeight) {
            moreLink.show(); // 원래 높이가 클램프된 높이보다 크다면 "더보기" 링크를 표시
        } else {
            moreLink.hide(); // 그렇지 않으면 "더보기" 링크를 숨김
        }

        // "더보기" 클릭 이벤트
        moreLink.click(function(event) {
            event.preventDefault(); // 링크 기본 동작 막기
            contentText.css({
                "overflow": "visible",
                "-webkit-line-clamp": "unset",
                "-webkit-box-orient": "unset",
                "display": "block"
            });
            $(this).hide(); // "더보기" 링크 숨기기
        });
    });
    
    // 데이터 변수 선언
    let reportData = {
        category : "blog_no",
        delete_url : "/hc/blog/delete",
        post_url : "/hc/blog/detail?blog_no=",
        post_id : '',
        re_id: '',
        write_num: '',
        re_reason: ''
    };
	
 	// 신고하기 버튼 클릭 시 모달 창 열기
    $(document).on("click",'.report-btn',function() {
    	// 버튼에서 data-reg_id와 data-blog_no를 가져와 저장
        reportData.post_id = $(this).data('reg_id');
        reportData.write_num = $(this).data('blog_no');
        
        $('#reportModal').show();
    });

    // 모달 닫기 버튼 클릭 시 모달 창 닫기
    $(document).on("click",'.close-modal',function() {
        $('#reportModal').hide();
    });

    // 모달 외부 클릭 시 모달 창 닫기
    $(window).click(function(event) {
        if ($(event.target).is('#reportModal')) {
            $('#reportModal').hide();
        }
    });

    // 확인 버튼 클릭 시 처리
    $(document).on("click",'#reportSubmit',function() {
    	reportData.re_reason = $('input[name="reason"]:checked').val();
    	reportData.re_id = '${login.user_id}';
        if (reportData.re_reason) {
            // 서버로 전송하기 위해 데이터를 콘솔에 출력 (여기서 AJAX 등을 사용하여 서버로 전송 가능)
            console.log('신고 데이터:', reportData);

            // AJAX 요청으로 서버로 데이터 전송 (예시)
            $.ajax({
                type: "POST",
                url: "/ds/report/addReport", // 서버에서 처리할 URL
                data: JSON.stringify(reportData), // JSON 형식으로 전송
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    alert('신고가 접수되었습니다.');
                    $('#reportModal').hide(); // 모달 창 닫기
                },
                error: function (error) {
                    console.log('에러 발생:', error);
                }
            });

        } else {
            alert('신고할 이유를 선택해주세요.');
        }
    });
    // 페이징 처리
    let page = 1;
    let isFetching = false;
    let loginUserId = "${login != null ? login.user_id : ''}";
    
    $(window).on('scroll', function() {
    	console.log($(window).scrollTop());
    	console.log($(window).height());
    	console.log($(document).height() - 10);
        if (!isFetching 
        		&& $(window).scrollTop() >= $(document).height() - 2000) {
        	$(window).scrollTop();
            console.log("맨밑 감지");

            // 페이징 처리가 필요하다면, AJAX로 콘텐츠를 로드하고 isFetching을 사용하여 중복 실행 방지
            isFetching = true;
            page += 1;
            limit = 10;
            let type = $("#searchType").val();
            let keyword = $("#searchValue").val();

            $.ajax({
                type: 'GET',
                url: '/hc/main/data?pageNum=' + page + "&limit=" + limit 
                		+ "&type=" + type + "&keyword=" + keyword, 
                success: function(data) {
                	console.log(data);
                	$.each(data, function (index, vo) {
	                    // 새로운 콘텐츠를 추가
	                    let uniqueIndex = index + page * 10;
	                    let tag = `
	                    	<div class="post-container">
	                    	\${vo.fileList.length > 0 ? `
	                    			 <div id="imageCarousel2\${uniqueIndex}"  class="carousel slide" data-ride="carousel" data-interval="false">
		                             <div class="carousel-inner">
		                                 \${vo.fileList.map((file, innerIndex) => `
		                                 <div class="carousel-item \${innerIndex == 0 ? 'active' : ''}">
		                                     <a class="open-modal" data-blog_no="\${vo.blog_no}"><img src="/display?file_name=\${file.file_path}/\${file.uuid}_\${file.file_name}" class="d-block w-100" alt="Image"></a>
		                                 </div>
		                            	 `).join('')}
		                             </div>
		                             <a class="carousel-control-prev" href="#imageCarousel2\${uniqueIndex}" role="button" data-slide="prev">
		                                 <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		                                 <span class="sr-only">Previous</span>
		                             </a>
		                             <a class="carousel-control-next" href="#imageCarousel2\${uniqueIndex}" role="button" data-slide="next">
		                                 <span class="carousel-control-next-icon" aria-hidden="true"></span>
		                                 <span class="sr-only">Next</span>
		                             </a>
		                         </div>`:''}
	                    			
	                    	
	                    	\${vo.productTagList.length > 0 ? `
	                    		 <div class="post-icons">
	                    			\${vo.productTagList.map((tag, inIndex) => `
			                             <a href="/ji/product/productDetail?pno=\${tag.product_no}"><img src="/display?file_name=\${tag.file_path }/\${tag.uuid}_\${tag.file_name}" alt="/resources/images/logo.png">\${tag.product_name}</a>
	                    			`).join('')}
		                         </div>
	                    			`: ''}
	                    	
	                         <div class="post-user-info">
	                      	  <div class="user-details">
	                           <img src="/resources/images/logo.png" alt="User Image">
	                           <div class="user-info-text">
	                               <div><a href="/hc/blog/blog?user_id=\${vo.user_id}">\${vo.user_name}</a></div>
	                               <div>
	                               \${vo.updatedate ? 
	                            		   new Date(vo.updatedate).toLocaleDateString('ko-KR', {year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'}) + ' 수정' 
	                            		   : new Date(vo.regdate).toLocaleDateString('ko-KR', {year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'})}
	                               </div>
	                           </div>
	                         </div>
	                         <div class="user-stats">
	                           <div><i class="fa fa-thumbs-up"> 좋아요<span class="sumLike" id="sumLike\${vo.blog_no }">\${vo.sumLike }</span></i></div>
	                           <div><i class="fa fa-handshake">팔로워<span class="sumFollow" id="sumFollow\${vo.blog_no }">\${vo.sumFollower }</span></i></div>
	                         </div>
	                    </div>
	                        <div class="post-content">
	                             <span class="content-text">\${vo.blog_content}</span> 
	                        	 <a href="#" class="more-link" style="display: none;">더보기</a>
	                        </div>
	                        <div class="post-actions">
	                            <button id="likeBtn\${vo.blog_no}" class="likeBtn" data-blog_no="\${vo.blog_no}" data-liked="\${vo.checkLike}">
	                            <i class="\${vo.checkLike ? 'fa-solid' : 'fa-regular'} fa-thumbs-up">좋아요</i>
	                        	</button>
	                            <button><a class="open-modal" data-blog_no="\${vo.blog_no}"><i class="fa fa-comment">댓글 달기</i></a></button>
	                            <button class="report-btn" data-reg_id="\${vo.user_id}" data-blog_no="\${vo.blog_no}"><i class="fa fa-exclamation-triangle">신고하기</i></button>
	                            <button>\${vo.user_id == loginUserId ? `<a href="/hc/blog/modify_form?blog_no=\${vo.blog_no}"><i class="fa fa-pen-to-square">수정하기</i></a>` : `<a href="/hc/blog/register"><i class="fa fa-pen-to-square">글쓰기</i></a>`}</button>
	                        </div>
	                    </div>
	                    `;
	                    $('#main-content-box').append(tag);
						
					})
                    isFetching = false; // 페이징 완료 후 다시 false로 설정
                },
                error: function() {
                    console.log("에러 발생");
                    isFetching = false;
                }
            });
        }
    });
	
	
	
	
});
</script>
<%@ include file="/WEB-INF/views/hc/include/modal.jsp" %>



<!-- 이벤트  -->
<div class="row">
	<div class="col-md-12">
		<div class="carousel slide" id="carousel-514190" data-ride="carousel"
			data-interval="5000">
			<ol class="carousel-indicators">
				<li data-slide-to="0" data-target="#carousel-514190" class="active">
				</li>
				<li data-slide-to="1" data-target="#carousel-514190"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img class="d-block w-100" alt="Carousel Bootstrap First"src="/resources/images/quiz.webp" />
					<a href="javascript:void(0);" onclick="openEventQuizPopup();" class="btn btn-success" id="event">
					<div class="carousel-caption">
						<h4>퀴즈 게임</h4>
						<p>이벤트를 통해 포인트를 획득하세요!!.</p>
					</div>
					</a>
				</div>
				<div class="carousel-item">
					<img class="d-block w-100" alt="Carousel Bootstrap Second" src="/resources/images/run.webp" />
					<a href="javascript:void(0);" onclick="openEventRunPopup();" class="btn btn-success" id="event">
					<div class="carousel-caption">
						<h4>경마 게임</h4>
						<p>이벤트를 통해 포인트를 획득하세요!!.</p>
					</div>
					</a>
				</div>
			</div>
			<a class="carousel-control-prev" href="#carousel-514190"
				data-slide="prev"><span class="carousel-control-prev-icon"></span>
				<span class="sr-only">Previous</span></a> <a
				class="carousel-control-next" href="#carousel-514190"
				data-slide="next"><span class="carousel-control-next-icon"></span>
				<span class="sr-only">Next</span></a>
		</div>
	</div>
</div>
<div>


</div>
<!-- 이벤트  끝 -->

<!-- 검색 -->
<div class="search-container">
    <form action="/hc/main/home" method="get">
        <div>
            <select id="searchType" name="type">
                <option value="T" ${BlogPageDto.type == 'T'? 'selected' : '' }>내용</option>
                <option value="P" ${BlogPageDto.type == 'P'? 'selected' : '' }>상품이름</option>
                <option value="W" ${BlogPageDto.type == 'W'? 'selected' : '' }>작성자</option>
            </select>
            <input id="searchValue" type="text" name="keyword" value="${BlogPageDto.keyword}">
            <button>검색</button>
        </div>
    </form>
</div>
<!-- 검색끝 -->

<!-- 글쓰기 탭  -->
<div class="story-container-wrapper">	
	<a href="/hc/blog/register">
    <div class="story-card">
        <div class="story-icon">
            <span>+</span>
        </div>
        <div class="story-text">
            <strong>스토리 만들기</strong><br>
            <span>사진을 공유하거나 글을 남겨보세요.</span>
        </div>
    </div>
    </a>
</div>
<!-- 글쓰기 탭 끝 -->


<div id="main-content-box">
<!-- 메인의 내용 시작 -->
<c:forEach items="${list}" var="vo" varStatus="status">
<div class="post-container">
	<c:if test="${not empty vo.fileList }">
     <!-- 카루셀 시작 -->
     <!-- 카루셀 아이디에 특정값을 넣을것 같으면 삑남 -->
     <div id="imageCarousel2${status.index }"  class="carousel slide" data-ride="carousel" data-interval="false">
         <div class="carousel-inner">
             <!-- 더 많은 이미지가 필요하면 이곳에 추가 -->
             <c:forEach items="${vo.fileList}" var="file" varStatus="innerstatus">
             <div class="carousel-item ${innerstatus.index == 0 ? 'active' : '' }">
                 <a class="open-modal" data-blog_no="${vo.blog_no}"><img src="/display?file_name=${file.file_path }/${file.uuid}_${file.file_name}" class="d-block w-100" alt="First Image"></a>
             </div>
             </c:forEach>
         </div>
         <!-- 여기에 위에 넣은 id 넣을것 아래 2개에  -->
         <a class="carousel-control-prev" href="#imageCarousel2${status.index }" role="button" data-slide="prev">
             <span class="carousel-control-prev-icon" aria-hidden="true"></span>
             <span class="sr-only">Previous</span>
         </a>
         <a class="carousel-control-next" href="#imageCarousel2${status.index }" role="button" data-slide="next">
             <span class="carousel-control-next-icon" aria-hidden="true"></span>
             <span class="sr-only">Next</span>
         </a>
     </div>
     <!-- 카루셀 끝 -->
     </c:if>
     <c:if test="${not empty vo.productTagList }">
     <div class="post-icons">
     	<c:forEach items="${vo.productTagList }" var="tag" >
         <a href="/product/productDetail?pno=${tag.product_no}"><img src="/display?file_name=${tag.file_path }/${tag.uuid}_${tag.file_name}" alt="/resources/images/logo.png">${tag.product_name}</a>
     	</c:forEach>
     </div>
     </c:if>
     <div class="post-user-info">
  	  <div class="user-details">
       <img src="/resources/images/logo.png" alt="User Image">
       <div class="user-info-text">
           <div><a href="/hc/blog/blog?user_id=${vo.user_id}">${vo.user_name}</a></div>
           <div><c:choose> <c:when test="${empty vo.updatedate}"><fmt:formatDate value="${vo.regdate}" pattern="yyyy.MM.dd hh:mm"/></c:when>
           	<c:otherwise><fmt:formatDate value="${vo.updatedate}" pattern="yyyy.MM.dd hh:mm"/>수정</c:otherwise>
            </c:choose></div>
       </div>
     </div>
     <div class="user-stats">
       <div><i class="fa fa-thumbs-up"> 좋아요<span class="sumLike" id="sumLike${vo.blog_no }">${vo.sumLike }</span></i></div>
       <div><i class="fa fa-handshake">팔로워<span class="sumFollow" id="sumFollow${vo.blog_no }">${vo.sumFollower }</span></i></div>
     </div>
</div>
    <div class="post-content">
         <span class="content-text">${vo.blog_content}</span> 
    	 <a href="#" class="more-link" style="display: none;">더보기</a>
    </div>
    <div class="post-actions">
        <button id="likeBtn${vo.blog_no}" class="likeBtn" data-blog_no="${vo.blog_no}" data-liked="${vo.checkLike}"><c:choose>
        	<c:when test="${vo.checkLike eq true }">
        	<i class="fa-solid fa-thumbs-up">좋아요</i>
        	</c:when>
        	<c:otherwise>
        	<i class="fa-regular fa-thumbs-up">좋아요</i>
        	</c:otherwise>
        	</c:choose></button>
        <button><a class="open-modal" data-blog_no="${vo.blog_no}"><i class="fa fa-comment">댓글 달기</i></a></button>
        <button class="report-btn" data-reg_id="${vo.user_id}" data-blog_no="${vo.blog_no}"><i class="fa fa-exclamation-triangle">신고하기</i></button>
        <button><c:choose>
        	<c:when test="${vo.user_id eq login.user_id }">
        	<a href="/hc/blog/modify_form?blog_no=${vo.blog_no}"><i class="fa fa-pen-to-square">수정하기</i></a>
        	</c:when>
        	<c:otherwise>
        	<a href="/hc/blog/register"><i class="fa fa-pen-to-square">글쓰기</i></a>
        	</c:otherwise>
        </c:choose></button>
    </div>
</div>

</c:forEach>    
<!-- 메인 내용 끝 -->
</div>
<!-- 신고하기 모달 창 -->
<div id="reportModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>신고 이유 선택</h2>
        <form id="reportForm">
            <label><input type="radio" name="reason" value="욕설"> 부적절한 표현/욕설 </label><br>
            <label><input type="radio" name="reason" value="홍보"> 제한된 품목을 판매하거나 홍보함</label><br>
            <label><input type="radio" name="reason" value="사기"> 스캠, 사기 또는 스팸</label><br>
            <label><input type="radio" name="reason" value="거짓"> 거짓정보</label><br><br>
            <div class="button-container">
		        <button type="button" id="reportSubmit">확인</button>
		        <button type="button" class="close-modal">취소</button>
		    </div>
        </form>
    </div>
</div>

<script>
    
</script>
<%@ include file="/WEB-INF/views/include/bottom.jsp"%>
