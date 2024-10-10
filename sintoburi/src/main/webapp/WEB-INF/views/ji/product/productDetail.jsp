<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/views/include/top.jsp"%>

<!-- 별점 관련 아이콘 CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
.card-img-related {
    width: 236.5px;
    height: 132.875px;
    object-fit: cover; /* 이미지가 컨테이너에 맞게 조정되도록 설정 */
}

.star-rating-container {
    margin-top: 10px; /* 별점 위 여백 */
}
</style>

<script>
//별점 생성 함수
function generateStars(rating) {
 let fullStars = Math.floor(rating);
 let halfStars = rating % 1 !== 0 ? 1 : 0;
 let emptyStars = 5 - fullStars - halfStars;
 
 let starHtml = '';
 
 for (let i = 0; i < fullStars; i++) {
     starHtml += '<i class="fas fa-star gold-star"></i>'; // 풀 별
 }
 
 if (halfStars) {
     starHtml += '<i class="fas fa-star-half-alt gold-star"></i>'; // 반 별
 }
 
 for (let i = 0; i < emptyStars; i++) {
     starHtml += '<i class="far fa-star gold-star"></i>'; // 빈 별
 }
 
 return starHtml;
}

$(function() {
 let pno = '${product.product_no}';

 // 평균 평점 불러오기
 $.ajax({
     type: 'get',
     url: '/ji/review/averageRating/' + pno,
     success: function(averageRating) {
         let starHtml = generateStars(averageRating);
         $('#averageRating').html(starHtml); 
         $('#averageRatingTop').html(starHtml);
     },
     error: function() {
         alert('평균 평점을 불러오는데 실패했습니다.');
     }
 });

 // 리뷰 탭 클릭 시 리뷰 목록 가져오기
 $("#reviewTab").on("click", function() {
     sortReviews(); // 리뷰 목록 가져오기
 });
});

//리뷰 목록 정렬 함수
function sortReviews() {
 let sortOrder = document.getElementById('sortOrder').value;
 let pno = '${product.product_no}';

 $.ajax({
     type: 'get',
     url: '/ji/review/list/' + pno + '/' + sortOrder,
     success: function(data) {
    	 console.log("data", data);
         $('#reviewList').html('');
         if (data.length > 0) {
             $.each(data, function(index, review) {
                 let reviewDate = new Date(review.review_reg_date).toLocaleDateString();
                 let starHtml = generateStars(review.review_rating);
                 
                 var reviewHtml = `
                     <div class="card mt-3">
                         <div class="card-body">
                             <h5 class="card-title">\${review.user_id}님의 리뷰</h5>
                             <h6 class="card-subtitle mb-2 text-muted">평점: \${starHtml}</h6>
                             <p class="card-text">\${review.review_content}</p>
                             <small class="text-muted">작성일: \${reviewDate}</small>`;
                             
                 if (review.user_id == "${login.user_id}") {
                     reviewHtml += `
                             <button onclick="deleteReview(\${review.review_no}, \${review.product_no})" class="btn btn-danger btn-sm">삭제</button>`;
                 }

                 reviewHtml += `</div></div>`;
                 $('#reviewList').append(reviewHtml);
             });
         } else {
             $('#reviewList').html('<div class="alert alert-info" role="alert">이 상품에 대한 리뷰가 아직 없습니다.</div>');
         }
     },
     error: function() {
         alert('리뷰를 불러오는데 실패했습니다.');
     }
 });
}

//리뷰 삭제 함수
function deleteReview(review_no, pno) {
 if(confirm('정말로 이 리뷰를 삭제하시겠습니까?')) {
     $.ajax({
         type: 'delete',
         url: '/ji/review/remove/' + review_no + '/' + pno,
         success: function(response) {
             if(response) {
                 alert('리뷰가 삭제되었습니다.');
                 sortReviews();
             } else {
                 alert('리뷰 삭제에 실패했습니다.');
             }
         },
         error: function() {
             alert('리뷰 삭제 중 오류가 발생했습니다.');
         }
     });
 }
}

//리뷰 작성 폼 제출 (주석 처리된 코드)
$(function() {
 $('#reviewForm').submit(function(event) {
     event.preventDefault();

     let review = {
         product_no: '${product.product_no}',
         user_id: '${login.user_id}',
         review_content: $('#reviewContent').val(),
         review_rating: $('#reviewRating').val()
     };

     $.ajax({
         type: 'post',
         url: '/ji/review/register',
         contentType: 'application/json',
         data: JSON.stringify(review),
         success: function(response) {
             if(response) {
                 alert('리뷰가 등록되었습니다.');
                 $('#reviewModal').modal('hide');
                 $('#suggestionTab').tab('show');
                 sortReviews(); 
             } else {
                 alert('리뷰 등록에 실패했습니다.');
             }
         },
         error: function() {
             alert('리뷰 등록 중 오류가 발생했습니다.');
         }
     });
 });
});

//문의사항 작성 및 등록
$(function() {
    // 질문 등록 버튼 클릭 시
    $('#submitQuestion').on('click', function() {
        let formData = {
            product_no: $('input[name="product_no"]').val(),
            user_id: '${login.user_id}',
            suggestion_content: $('#suggestionContent').val(),
            role_type: 'QUESTION'
        };

        $.ajax({
            type: 'post',
            url: '/ji/suggestion/register',
            contentType: 'application/json; charset=UTF-8',
            data: JSON.stringify(formData),
            success: function(response) {
                alert('문의사항이 등록되었습니다.');
                $('#questionModal').modal('hide');
                loadSuggestions();
            },
            error: function() {
                alert('문의사항 등록 중 오류가 발생했습니다.');
            }
        });
    });

    // 답변 등록 버튼 클릭 시 
    $('#submitAnswer').on('click', function() {
    	let suggestion_no = $(this).attr("data-sno");
        let formData = {
            product_no: $('input[name="product_no"]').val(),
            user_id: '${login.user_id}',
            suggestion_content: $('#answerContent').val(),
            suggestion_no : suggestion_no 
        };
        
        console.log("formData:", formData);

        $.ajax({
            type: 'post',
            url: '/ji/suggestion/registerAnswer',
            contentType: 'application/json; charset=UTF-8',
            data: JSON.stringify(formData),
            success: function(response) {
                alert('답변이 등록되었습니다.');
                $('#answerModal').modal('hide');
                $('#suggestionTab').tab('show');
                loadSuggestions();
            },
            error: function() {
                alert('답변 등록 중 오류가 발생했습니다.');
            }
        });
    });

    // 문의사항 목록 로드
    function loadSuggestions() {
        let pno = '${product.product_no}';

        $.ajax({
            type: "get",
            url: "/ji/suggestion/list/" + pno,
            contentType: "application/json; charset=utf-8",
            success: function(rData) {
            	console.log("rData:" , rData);
                $("#suggestion_table tbody").empty();

                if (rData.length > 0) {
                    $.each(rData, function(index, suggestion) {
                        let tr = `<tr>
                            <td>\${suggestion.suggestion_content}</td>
                            <td>\${suggestion.user_id}</td>
                            <td>\${toDateString(suggestion.suggestion_reg_date)}</td>
                            <td>\${toDateString(suggestion.suggestion_upd_date)}</td>`;

                        // 현재 유저가 문의 작성자일 경우 수정/삭제 버튼 표시
                        if (suggestion.user_id === $('input[name="user_id"]').val()) {
                            tr += `<td><button class="btn btn-sm btn-warning btnSuggestionModify" data-sno="\${suggestion.suggestion_no}">수정</button></td>
                                   <td><button class="btn btn-sm btn-danger btnSuggestionRemove" data-sno="\${suggestion.suggestion_no}">삭제</button></td>`;
                        } else {
                            tr += `<td></td><td></td>`;
                        }

                        // 현재 유저가 상품 등록자일 경우 답변하기 버튼 표시
                        if ('${login.user_id}' === '${product.user_id}' && suggestion.parent_no === 0) {
                            tr += `<td><button class="btn btn-sm btn-primary btnSuggestionAnswer" data-sno="\${suggestion.suggestion_no}" data-toggle="modal" data-target="#answerModal">답변하기</button></td>`;
                        } else if(suggestion.parent_no == -1) {
                            tr += `<td><button class="btn btn-sm btn-success btnGetAnswer" data-sno="\${suggestion.suggestion_no}">답변보기</button></td>`;
                        } else {
                        	tr += `<td></td>`;
                        }

                        tr += `</tr>`;
                        $("#suggestion_table tbody").append(tr);
                    });
                } else {
                    $("#suggestion_table tbody").append('<tr><td colspan="6" class="text-center">아직 등록된 문의사항이 없습니다.</td></tr>');
                }
            },
            error: function() {
                //alert("문의사항을 불러오는 데 실패했습니다.");
            }
        });
    }
    
    // 답변하기 버튼
    $('#suggestion_table').on('click', '.btnSuggestionAnswer', function() {
        let suggestionNo = $(this).data('sno');
        console.log("suggestionNo:", suggestionNo);
        $('#submitAnswer').attr('data-sno', suggestionNo);
    });
    
    // 답변보기 버튼
    $('#suggestion_table').on('click', '.btnGetAnswer', function() {
    	let that = $(this);
        let suggestionNo = that.data('sno');
        $.ajax({
            type: "get",
            url: "/ji/suggestion/get/" + suggestionNo,
            contentType: "application/json; charset=utf-8",
            success: function(rData) {
            	console.log("rData:" , rData);
            	if (!rData) {
            		alert("등록된 답변이 없습니다.");
            		return;
            	}
            	let trTag = `<tr style="font-weight:bold">
                    <td style="padding-left:50px;">ㄴ \${rData.suggestion_content}</td>
                    <td>\${rData.user_id}</td>
                    <td>\${toDateString(rData.suggestion_reg_date)}</td>
                    <td>\${toDateString(rData.suggestion_upd_date)}</td>
                    <td></td><td></td>
                    <td>답변완료</td></tr>`;
                    that.closest("tr").after(trTag).show("slow");
                
            },
            error: function() {
                alert("문의사항을 불러오는 데 실패했습니다.");
            }
        });
        
        
    });

 	// 수정 버튼 클릭 -> 모달에 기존 내용 로드
    $('#suggestion_table').on('click', '.btnSuggestionModify', function() {
        console.log('#btnSuggestionModify');
    	let suggestionNo = $(this).data('sno');
        $('#suggestion_no').val(suggestionNo);
    	
        // 서버로부터 해당 문의 내용을 가져와서 모달에 채움
        $.ajax({
            type: 'get',
            url: '/ji/suggestion/get/' + suggestionNo,
            success: function(suggestion) {
            	console.log("suggestion", suggestion);
                $('#editSuggestionNo').val(suggestion.suggestion_no);
                $('#editSuggestionContent').val(suggestion.suggestion_content);
                
                // 모달을 띄움
                $('#editQuestionModal').modal('show');
            },
            error: function() {
                alert('문의사항을 불러오는데 실패했습니다.');
            }
        });
    });

    // 수정된 문의사항 저장
    $('#submitEditQuestion').on('click', function() {
        let formData = {
            suggestion_no: $('input[name="suggestion_no"]').val(),
            product_no: $('input[name="product_no"]').val(),
            suggestion_content: $('#editSuggestionContent').val(),
            user_id: $('input[name="user_id"]').val(), 
            role_type: $('#role_type').val()
        };
        
        console.log("formData:", formData);
        

        $.ajax({
            type: 'put',
            url: '/ji/suggestion/modify', 
            contentType: 'application/json; charset=UTF-8',
            data: JSON.stringify(formData),
            success: function(response) {
            	console.log("response:", response);
                if(response) {
                    alert('문의사항이 수정되었습니다.');
                    $('#editQuestionModal').modal('hide');
                    loadSuggestions();
                } else {
                    alert('문의사항 수정에 실패했습니다.');
                }
            }
        });
    });
    
    
    // 문의사항 삭제
    $('#suggestion_table').on('click', '.btnSuggestionRemove', function() {
    	console.log('#btnSuggestionRemove');
        if(confirm('정말로 이 문의사항을 삭제하시겠습니까?')) {
            let suggestionNo = $(this).data('sno');

            $.ajax({
                type: 'delete',
                url: '/ji/suggestion/remove/' + suggestionNo + '/' + $('input[name="product_no"]').val(),
                success: function(response) {
                    if(response) {
                        alert('문의사항이 삭제되었습니다.');
                        loadSuggestions();
                    } else {
                        alert('문의사항 삭제에 실패했습니다.');
                    }
                }
            });
        }
    });
    
    // 날짜 형식 변환 함수
    function toDateString(dateString) {
        const date = new Date(dateString);
        return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
    }
    
    loadSuggestions();
    
    
    $("#goBasket").click(function () {
		let p_count = $("#count").val();
		let product_no = $(this).data("product_no");
		let tag = `
			<input type="hidden" name="p_count" value="\${p_count}">
			<input type="hidden" name="product_no" value="\${product_no}">
		`;
		$("#basketForm").append(tag);
		$("#basketForm").submit();
		
		console.log(p_count);
		console.log(product_no);
	})
	
	
    $("#order").click(function () {
		let p_count = $("#count").val();
		let product_no = $(this).data("product_no");
		console.log(p_count);
		console.log(product_no);
		let tag = `
			<input type="hidden" name="p_count" value="\${p_count}">
			<input type="hidden" name="product_no" value="\${product_no}">
		`;
		$("#orderNowForm").append(tag);
		$("#orderNowForm").submit();
		
		
	})
    
    
    
});

</script>

<!-- Product section -->
<section class="py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="row gx-4 gx-lg-5 align-items-center">
            <div class="col-md-6">
                <c:forEach var="image" items="${images}" varStatus="status">
                    <c:if test="${image.product_no == product.product_no && status.index == 0}">
                        <img class="card-img-top mb-5 mb-md-0" 
                             src="/display?file_name=/${image.img_path}/${image.uuid}_${image.img_name}" 
                             alt="${product.product_name}"
                             style="width: 450px; height: 350px; object-fit: cover; border: 1px solid rgba(0, 0, 0, 0.3); border-radius: 5px;" />
                    </c:if>
                </c:forEach>
            </div>
            <div class="col-md-6">
                <h1 class="display-3 fw-bolder" style="font-size:50px;">${product.product_name}</h1>
                <div class="average-rating">
				    <h5><span id="averageRatingTop"></span></h5>
				</div>	
				<hr class="flex-grow-1">
                <div class="fs-3 mb-3">
                    <span class="text-decoration-line-through">판매가 ${product.price}원</span>
                </div>
                <hr class="flex-grow-1">
                <div class="input-group fs-5 mb-5">
                    <div class="input-group-prepend">
                        <input type="hidden" value="${product.stock}" id="stock" name="stock">
                        <span class="input-group-text">주문 수량</span>
                    </div>
                    <input class="form-control text-center me-3" id="count" name="count" type="number" value="1" style=" max-width: 5rem" />
                </div>
                <div class="d-flex">

                	 <form action="/gr/order/order_form_now" id="orderNowForm" method="get">
                    <button id="order"class="btn btn-outline-dark flex-shrink-0" type="button" data-product_no="${product.product_no}">
                        <i class="bi-cart-fill me-1"></i>
                        바로구매▶
                    </button>
                    </form>
                    <form action="/gr/basket/putBasket" id="basketForm" method="post">
                    <button id="goBasket" class="btn btn-outline-dark flex-shrink-0" type="button" data-product_no="${product.product_no}">
                        <i class="bi-cart-fill me-1"></i>
                        장바구니 담기
                    </button><br>
                    </form>

                </div>
                <hr class="flex-grow-1">
                <div class="prod-sale-vender" style="font-size:20px;">
                판매자 : 
                    <a class="prod-sale-vender-name" href="#">${product.user_id}</a>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- //Product section -->

<!-- Related user items section -->
<section class="py-5">
    <div class="container px-4 px-lg-5 mt-5">
        <hr class="flex-grow-1">
        <h2 class="fw-bolder mb-4 mx-3 text-center">유저 연관 추천상품</h2>
        <hr class="flex-grow-1">
        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
            <c:forEach var="relatedProducts" items="${relatedProducts}" begin="0" end="3">
                <div class="col mb-5">
                    <div class="card h-100" data-pno="${relatedProducts.product_no}">
                        <a href="/ji/product/productDetail?pno=${relatedProducts.product_no}">
                            <img class="card-img-related" 
                                 src="/display?file_name=/${relatedProducts.img_path}/${relatedProducts.uuid}_${relatedProducts.img_name}" 
                                 alt="${relatedProducts.product_name}" />
                        </a>
                        <div class="card-body p-4">
                            <div class="text-center">
                                <h5 class="fw-bolder">${relatedProducts.product_name}</h5>
                                ₩${relatedProducts.price}
                                <!-- 별점 표시 -->
                                <div class="star-rating-container"></div>
                                <a class="btn btn-outline-dark btn-sm mt-auto" style="margin-top: 10px;" href="#">${relatedProducts.user_id}</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <hr class="flex-grow-1">
    </div>
</section>
<!-- //Related user items section -->

<!-- Product summary and images -->
<section class="py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="row justify-content-center align-items-center">
            <div class="col-md-8 text-center">
                <div style="margin-bottom:30px">
                    <h3 class="content-test"><pre>${product.summary}</pre></h3>
                </div>
                <c:forEach var="image" items="${images}">
                    <c:if test="${image.product_no == product.product_no}">
                        <img class="card-img-top mb-5 mb-md-0" 
                             src="/display?file_name=/${image.img_path}/${image.uuid}_${image.img_name}" 
                             alt="${product.product_name}"
                             style="width: 450px; height: 350px; object-fit: cover; border: 1px solid rgba(0, 0, 0, 0.3); border-radius: 5px; margin-bottom: 30px;" />
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
</section>
<!-- //Product summary and images -->

<!-- 탭 -->
<div class="row justify-content-center pt-5 mt-5">
    <div class="col-md-10">
        <hr class="flex-grow-1">
        <div class="tabbable" id="tabs-358860">
            <ul class="nav nav-tabs justify-content-center" >
                <li class="nav-item">
                    <a class="nav-link active show" href="#tab1" data-toggle="tab">상품안내</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#tab2" data-toggle="tab" id="reviewTab">상품후기</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#tab3" data-toggle="tab" >배송/교환/반품 안내</a>
                </li>
                <li class="nav-item">
                	<a class="nav-link" href="#tab4" data-toggle="tab" id="suggestionTab">문의사항</a>
                </li>
            </ul>
            <div class="tab-content" style="margin-top:20px">
                <div class="tab-pane active show text-center" id="tab1">
                    <p>상품안내</p>
                    ${product.details}
                </div>
                
                <!-- 상품 리뷰 탭 -->
                <div class="tab-pane" id="tab2">
                    <div class="col-md-12">
                        <div class="jumbotron card card-block"  style="background-color: white">
                            <h2>상품평</h2>
                            
                            <!-- 별점 -->
							<div class="average-rating">
							    <h3><span id="averageRating"></span></h3>
							</div>								
                            <!-- 별점 -->
                            
                            <div style="display: flex; justify-content: space-between; align-items: center;">
							    <!-- 리뷰 정렬 드롭다운 -->
							    <div class="form-group" style="margin: 0;">
							        <label for="sortOrder">
							            <select class="form-control" id="sortOrder" name="sortOrder" onchange="sortReviews()">
							                <option value="recent">최신순</option>
							                <option value="highest">높은 평점순</option>
							                <option value="lowest">낮은 평점순</option>
							            </select>
							        </label>
							    </div>
							    
							    <!-- 리뷰 작성 버튼 -->
							    <c:if test="${login.user_id != product.user_id}">
							        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#reviewModal">
							            리뷰 작성
							        </button>
							    </c:if>
							    <!-- 상품 등록자와 로그인한 유저가 다를 경우에만 문의하기 버튼을 표시 -->
							</div>
							
                            <!-- 작성된 리뷰 리스트 -->
                            <div id="reviewList">
                                <!-- 리뷰가 없을 경우 -->
                                <c:if test="${empty reviews}">
                                    <div class="alert alert-info" role="alert">
                                        이 상품에 대한 리뷰가 아직 없습니다.
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //상품 리뷰 탭 -->

                <!-- 리뷰 작성 모달-->
                <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="reviewModalLabel">리뷰 작성</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="reviewForm" action="/ji/product/addReview" method="post">
                                    <input type="hidden" name="product_no" value="${product.product_no}">
                                    <input type="hidden" name="user_id" value="${login.user_id}"> <!-- 로그인된 유저 ID -->
                                    
                                    <div class="form-group">
                                        <label for="reviewContent">리뷰 내용</label>
                                        <textarea class="form-control" id="reviewContent" name="reviewContent" rows="3" required placeholder="다른 고객님께 도움이 되도록 상품에 대한 솔직한 평가를 남겨주세요."></textarea>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="reviewRating">평점</label>
                                        <select class="form-control" id="reviewRating" name="reviewRating" required>
                                            <option value="1">1점</option>
                                            <option value="2">2점</option>
                                            <option value="3">3점</option>
                                            <option value="4">4점</option>
                                            <option value="5">5점</option>
                                        </select>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-primary">리뷰 작성</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 리뷰 작성 모달-->
                
                <div class="tab-pane" id="tab3">
                    <h5 class="delivery-return-policy-title">배송정보</h5>
                    <table class="delivery-return-policy-table" style="width: 100%; border-collapse: collapse;">
                        <colgroup>
                            <col style="width: 20%;">
                            <col style="width: 40%;">
                            <col style="width: 20%;">
                            <col style="width: 60%;">
                        </colgroup>
                        <tr>
                            <td style="border: 1px solid #ddd; padding: 10px;">배송방법</td>
                            <td style="border: 1px solid #ddd; padding: 10px;">순차배송</td>
                            <td style="border: 1px solid #ddd; padding: 10px;">배송비</td>
                            <td style="border: 1px solid #ddd; padding: 10px;">무료배송<br>- 15,000원 이상 구매 시 무료배송<br>- 도서산간 지역 추가비용 없음</td>
                        </tr>
                        <tr>
                            <td style="border: 1px solid #ddd; padding: 10px;">묶음배송 여부</td>
                            <td style="border: 1px solid #ddd; padding: 10px;">가능</td>
                            <td style="border: 1px solid #ddd; padding: 10px;" colspan="2"></td>
                        </tr>
                        <tr>
                            <td style="border: 1px solid #ddd; padding: 10px;">배송기간</td>
                            <td style="border: 1px solid #ddd; padding: 10px;" colspan="3">
                                - 배송 지역: 주문 및 결제 완료 후, 1-2일 이내 도착<br>
                                - 미배송 지역: 주문 및 결제 완료 후, 2-3일 이내 도착<br>
                                - 도서 산간 지역 등은 하루 추가될 수 있습니다.<br>
                                - 천재지변, 물량 수급 변동 등 예외적인 사유 발생 시, 다소 지연될 수 있는 점 양해 부탁드립니다.
                            </td>
                        </tr>
                    </table>
                </div>
                
                	<!-- 문의사항 탭 -->
					<div class="tab-pane" id="tab4">
					    <div class="col-md-12">
					        <div class="jumbotron card card-block" style="background-color: white;">
					        
					            <div class="clearFix" style="display: flex; align-items: center;">
					                <h4 class="prod-suggestion-list-title">상품문의</h4>
					                
					                <!-- 상품 등록자와 로그인한 유저가 다를 경우에만 문의하기 버튼을 표시 -->
					                <c:if test="${login.user_id != product.user_id}">
					                    <button type="button" class="btn prod-suggestion-list-write-btn btn-outline-primary" data-toggle="modal" 
					                        data-target="#questionModal" style="margin-left: auto;">
					                        문의하기
					                    </button>
					                </c:if>
					            </div>
					        
					            <div class="prod-suggestion-list">
					                <ul>
					                    <li>구매한 상품의 취소/반품은 마이페이지에서 신청 가능합니다.</li>
					                    <li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
					                    <li>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 고객센터 내 1:1 문의하기를 이용해주세요.</li>
					                    <li>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
					                    <li>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
					                </ul>
					            </div>
					            
					            <table class="table" id="suggestion_table">
					                <thead>
					                    <tr>
					                        <th>문의 내용</th>
					                        <th>작성자</th>
					                        <th>작성일</th>
					                        <th>수정일</th>
					                        <th>수정</th>
					                        <th>삭제</th>
					                        <th>답변</th>
					                    </tr>
					                </thead>
					                <tbody>
					                </tbody>
					            </table>
					            
					        </div>
					    </div>
					</div>
					
					<!-- 질문 작성 모달 -->
					<div class="modal fade" id="questionModal" tabindex="-1" role="dialog" aria-labelledby="questionModalLabel" aria-hidden="true">
					    <div class="modal-dialog" role="document">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h5 class="modal-title" id="questionModalLabel">상품 문의</h5>
					                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					                    <span aria-hidden="true">&times;</span>
					                </button>
					            </div>
					            <div class="modal-body">
					                <form id="questionForm">
					                    <input type="hidden" name="product_no" value="${product.product_no}">
					                    <input type="hidden" name="user_id" value="${login.user_id}">
					                    <div class="form-group">
					                        <label for="suggestionContent">문의 내용</label>
					                        <textarea class="form-control" id="suggestionContent" name="suggestion_content" rows="4" required></textarea>
					                    </div>
					                    <p class="text-muted">
					                        * 개인정보(주민번호, 연락처, 주소, 계좌번호, 카드번호 등)가 포함되지 않도록 유의해주세요.
					                    </p>
					                </form>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					                <button type="button" class="btn btn-primary" id="submitQuestion">확인</button>
					            </div>
					        </div>
					    </div>
					</div>
					<!-- 질문 작성 모달 -->
					
					<!-- 답변 작성 모달 -->
					<div id="answerModal" class="modal fade" tabindex="-1" role="dialog">
					    <div class="modal-dialog" role="document">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h5 class="modal-title">답변 등록</h5>
					                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					                    <span aria-hidden="true">&times;</span>
					                </button>
					            </div>
					            <div class="modal-body">
					                <textarea id="answerContent" class="form-control" rows="4" placeholder="답변을 입력하세요..."></textarea>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-primary" id="submitAnswer">답변 등록</button>
					                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					            </div>
					        </div>
					    </div>
					</div>
					<!-- 답변 작성 모달 -->
					
					<!-- 수정 모달 -->
					<div class="modal fade" id="editQuestionModal" tabindex="-1" role="dialog" aria-labelledby="editQuestionModalLabel" aria-hidden="true">
					    <div class="modal-dialog" role="document">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h5 class="modal-title" id="editQuestionModalLabel">문의사항 수정</h5>
					                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					                    <span aria-hidden="true">&times;</span>
					                </button>
					            </div>
					            <div class="modal-body">
					                <form id="editQuestionForm">
					                    <input type="hidden" name="suggestion_no" id="suggestion_no" value="${suggestion.suggestion_no}">
					                    <input type="hidden" name="product_no" id="product_no" value="${product.product_no}">
					                    <input type="hidden" name="user_id" id="user_id" value="${login.user_id}">
					                    <div class="form-group">
					                        <label for="editSuggestionContent">문의 내용</label>
					                        <textarea class="form-control" id="editSuggestionContent" name="suggestion_content" rows="4" required></textarea>
					                    </div>
					                    <p class="text-muted">
					                        * 개인정보(주민번호, 연락처, 주소, 계좌번호, 카드번호 등)가 포함되지 않도록 유의해주세요.
					                    </p>
					                </form>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					                <button type="button" class="btn btn-primary" id="submitEditQuestion">수정</button>
					            </div>
					        </div>
					    </div>
					</div>
            </div>
        </div>
    </div>
</div>
<!-- //탭 -->

<%@ include file="/WEB-INF/views/ji/include/bottom.jsp"%>
</html>