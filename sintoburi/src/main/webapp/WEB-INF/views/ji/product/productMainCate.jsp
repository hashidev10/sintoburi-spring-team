<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/views/include/top.jsp"%>
<!-- 별점 관련 아이콘css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
.card-img-top {
    width: 236.5px;
    height: 193.578px;
    object-fit: cover; /* 이미지가 컨테이너에 맞게 조정되도록 설정 */
}
</style>

<script>
$(function() {
    $('.product-item').each(function() {
        let pno = $(this).data('pno');
        
        let starContainer = $(this).find('.star-rating-container');
        
        $.ajax({
            type: 'get',
            url: '/ji/review/averageRating/' + pno,
            success: function(averageRating) {
                let starHtml = generateStars(averageRating);
                starContainer.html(starHtml);
            },
            error: function() {
                console.log('평균 평점을 불러오는데 실패했습니다.');
            }
        });
    });
});

function generateStars(rating) {
    let fullStars = Math.floor(rating);
    let halfStars = rating % 1 !== 0 ? 1 : 0;
    let emptyStars = 5 - fullStars - halfStars;
    
    let starHtml = '';
    
    for (let i = 0; i < fullStars; i++) {
        starHtml += '<i class="fas fa-star gold-star"></i>'; // 가득 찬 별
    }
    
    if (halfStars) {
        starHtml += '<i class="fas fa-star-half-alt gold-star"></i>'; // 반 별
    }
    
    for (let i = 0; i < emptyStars; i++) {
        starHtml += '<i class="far fa-star gold-star"></i>'; // 빈 별
    }
    
    return starHtml;
}
</script>

		<section class="py-1">
			<c:if test="${isLoggedIn}">
		        <a id="btnRegister" class="btn btn-outline-success" href="/ji/manager/register" style="margin-left: 985px;">상품등록</a>
		    </c:if>
		</section>
		
		<%@include file="/WEB-INF/views/ji/include/cateMenu.jsp" %>
		
		<hr>
		
		<section class="py-1 d-flex align-items-center">
		    <!-- productList / 출력 -->
		    <div class="btn-product-register mX-auto">
		    	<form action="/ji/product/selectSearchProducts">
		    		<select name="type">
		    			<option value="P"
		    				${type == 'P' ? 'selected' : '' }
		    			>상품이름</option>
		    			<option value="U"
		    				${type == 'U' ? 'selected' : '' }
		    			>작성자</option>
		    		</select>
		    		<input type="text" name="keyword" value="${keyword}">
		    		<button type="submit" class="btn btn-success">검색</button>
		    	</form>
		    </div>
		</section>
		
		<section class="py-1 product-list">
					<div class="container px-4 px-lg-5 mt-3">
						
		                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4">
		                <c:forEach items="${list}" var="dto" varStatus="status">
		                
		                    <div class="col mb-5 float-left product-item" data-pno="${dto.product_no}">
		                        <div class="card h-100">
									<a href="/ji/product/productDetail?pno=${dto.product_no}">
					                    <img class="card-img-top" 
					                         src="/display?file_name=/${dto.img_path}/${dto.uuid}_${dto.img_name}"
					                         alt="${dto.product_name}"/>
		                            </a>
		                            <div class="card-body p-4">
		                                <div class="text-center">
		                                    <h5 class="fw-bolder">${dto.product_name}</h5>
		                                    ${dto.price}원
		                                    <div class="star-rating-container"></div>
		                                </div>
		                                
		                            </div>
		                            <!-- Product actions-->
		                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
		                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">${dto.user_id}</a></div>
		                            </div>
		                        </div>
		                    </div>
		                 </c:forEach>
					     </div>
				     </div>
			
            
        </section>
        
<%@ include file="/WEB-INF/views/include/bottom.jsp"%>

