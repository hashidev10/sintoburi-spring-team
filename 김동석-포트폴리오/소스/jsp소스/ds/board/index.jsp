<%@ include file="/WEB-INF/views/include/header.jsp" %>
        
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
    
    <script>
    
    $(function(){
    	$("#vegeStory").click(function(){
    		$("#newPost").css("display","none");
    		$("#recipePost").css("display","none");
    		$("#popularPost").css("display","none");
    		$("#vegePost").css("display","block");
    		$("#pageMover").css("display","none");
    	});
     	$("#recipeStory").click(function(){
    		$("#newPost").css("display","none");
    		$("#vegePost").css("display","none");
    		$("#popularPost").css("display","none");
    		$("#recipePost").css("display","block");
    		$("#pageMover").css("display","none");
    		
    	});
     	
    	$("#newStory").click(function(){
    		$("#vegePost").css("display","none");
    		$("#recipePost").css("display","none");
    		$("#newPost").css("display","block");
    		$("#popularPost").css("display","none");
    		$("#pageMover").css("display","block");
    		
    	});
    	
    	$("#popularStory").click(function(){
    		$("#vegePost").css("display","none");
    		$("#recipePost").css("display","none");
    		$("#newPost").css("display","none");
    		$("#popularPost").css("display","block");
    		$("#pageMover").css("display","none");
    		
    		
    	});
    	
    	// url 파라미터값 구하기
    	let search = window.location.search;
    	let param = new URLSearchParams(search);
    	let keyword = param.get('keyword');
    	
    	console.log(keyword);
    	if(keyword==null||keyword==""){
    		//$("#recipePost").css("display","block");
    		//$("#vegePost").css("display","block");
    		$(".menuTab").eq(0).css("display","block");
    	}else{
    		$("#recipePost").css("display","none");
    		$("#vegePost").css("display","none");
    		$(".menuTab").eq(0).css("display","none");
    		$(".menuTab").eq(1).css("display","block");
    	}
    	
    	
    	
    	$("a.page-link").click(function(e){
    		
    		e.preventDefault();	
    		let pageNum = $(this).attr("href");	
    		console.log(pageNum);
    		$("#actionForm> input[name=pageNum]").val(pageNum);
    		$("#actionForm").attr("action","/ds/board/index");
    		$("#actionForm").submit();
    		
    	});
    	
    })
    // gallery보기 list보기
    
//     $("#viewGallery").click(function(){
    	
//     });
    
 // 페이지 블럭 - 페이지 번호
	
    
    </script>

     <body> 
        
    
      <ul class="buttonMenu" style="margin-left:300px;">
      <div class="menuTab" style="display:none;">
         <p style="font-weight:bold; font-size:20px;">둘러보기</p>
            <button type="button" class="btn btn" style="background-color:rgb(247, 247, 247);margin-right:10px;" id="newStory">
            <span style="font-weight:500;">최신글</span>
            </button>
            
              <button type="button" class="btn btn" style="background-color:rgb(247, 247, 247);margin-right:10px;" id="popularStory">
            <span style="font-weight:500;">인기글</span>
            </button>
            
            <button type="button" class="btn btn" style="background-color:rgb(247, 247, 247);margin-right:10px;" id="vegeStory">
            <span style="font-weight:500;">농산물 이야기</span>
            </button>
            
            <button type="button" class="btn btn" style="background-color:rgb(247, 247, 247);margin-left:3px;" id="recipeStory">
            <span style="font-weight:500; ">레시피 이야기</span>
            </button>
          </div>  
          <div  class="menuTab" style="display:none;"> 
          	<p style="font-weight:bold; font-size:30px; margin-left:100px;">검색결과</p>
          
          </div>
            
            
            <c:if test="${not empty login.user_id}">
              <a class="btn btn-outline-primary" style="margin-left:1100px;" href="/ds/board/write">
                <i class="bi bi-pencil-square"></i>글쓰기
          	 </a>
          	 </c:if>
         </ul>
         
<!--           <div style="margin-left:350px;"> -->
<!--           	<img src="/resources/images/list.png"style="width:30px;height:30px;"> -->
<!--     		<img src="/resources/images/menu.png"style="width:20px;height:20px;"> -->
<!--           </div> -->
<div id="viewGallery">
        <!-- Section-->
        <section class="py-1" id="newPost">
         <div class="container px-4 px-lg-5 mt-5">
 			 <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center" >
                    <c:forEach var="BoardVo" items="${list}">
					
              
                    <div class="col mb-5">
                        <div class="card h-10">
                            <!-- Product image-->
<!--                             <img class="card-img-top"  src="/resources/images/vege.jpg" alt="..." /> -->
                            <!-- Product details-->
                            <div class="card-body p-4">
                      
                          <a href="/ds/board/read?bno=${BoardVo.bno}"><img class="card-img-top" style="width:200px;height:150px;" src="${BoardVo.thumbnail}" alt="..." /></a> 
                            
                                <div class="text-center">
                                    <!-- Product name-->
                                    <a class="fw-bolder" href="/ds/board/read?bno=${BoardVo.bno}">${BoardVo.title}</a>
                                    <br>
                                    <!-- Product price-->
                                      <p>작성자: ${BoardVo.writer}</p>
                                    <hr>
                                    <p>조회수: ${BoardVo.view_count}</p>
                                    <p>추천수: ${BoardVo.like_count}</p>
                                </div>
                            </div>
                         
                        </div>
                    </div>
                 
                     </c:forEach>
                </div>
            </div>
         
        </section>
        
        <section class="py-1" id="popularPost" style="display:none;">
         <div class="container px-4 px-lg-5 mt-5">
 			 <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center" >
                    <c:forEach var="BoardVo" items="${popularList}">
					
              
                    <div class="col mb-5">
                        <div class="card h-10">
                            <!-- Product image-->
<!--                             <img class="card-img-top"  src="/resources/images/vege.jpg" alt="..." /> -->
                            <!-- Product details-->
                            <div class="card-body p-4">
                      
                          <a href="/ds/board/read?bno=${BoardVo.bno}"><img class="card-img-top" style="width:200px;height:150px;" src="${BoardVo.thumbnail}" alt="..." /></a> 
                            
                                <div class="text-center">
                                    <!-- Product name-->
                                    <a class="fw-bolder" href="/ds/board/read?bno=${BoardVo.bno}">${BoardVo.title}</a>
                                    <br>
                                    <!-- Product price-->
                                      <p>작성자: ${BoardVo.writer}</p>
                                    <hr>
                                    <p>조회수: ${BoardVo.view_count}</p>
                                    <p>추천수: ${BoardVo.like_count}</p>
                                </div>
                            </div>
                         
                        </div>
                    </div>
                 
                     </c:forEach>
                </div>
            </div>
         
        </section>
        
        
        	<!-- Pagination -->
            <div class="row" id="pageMover">
				<div class="col-md-12">
					<nav>
						<ul class="pagination justify-content-center">
							<c:if test="${pageMaker.prev == true}">
							<li class="page-item">
								<a class="page-link" href="${pageMaker.startPage-1}">이전</a>
							</li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage}" 
									   end="${pageMaker.endPage}" 
									   var="v">
							<li class="page-item ${v==pageMaker.cri.pageNum ? 'active' : '' }">
								<a class="page-link" href="${v}">${v}</a>
							</li><!-- li -->
							</c:forEach>
							<c:if test="${pageMaker.next == true}">
							<li class="page-item">
								<a class="page-link" href="${pageMaker.endPage+1}">다음</a>
							</li>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>
            <!-- // Pagination -->
          
        
        
        <!-- Section 농산물-->
        <section class="py-1" id="vegePost" style="display:none;">
         <div class="container px-4 px-lg-5 mt-5">
           
         
         <ul class="menu" style="margin-right:50px;">
        
         
          <div>
		<img src="/resources/images/salad.png" alt="농산물 이야기" style="width:56px;height:44px;">
  		<span style="margin-top:20px;font-size:22px;" >농산물 이야기</span>
		</div>
         
            
         </ul>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <c:forEach var="BoardVo" items="${list}">
                      <c:if test="${BoardVo.category=='농산물 이야기'}">
                    <div class="col mb-5">
                        <div class="card h-10">
                            <!-- Product image-->
<!--                             <img class="card-img-top"  src="/resources/images/vege.jpg" alt="..." /> -->
                            <!-- Product details-->
                            <div class="card-body p-4">
                          <a href="/ds/board/read?bno=${BoardVo.bno}"><img class="card-img-top" style="width:200px;height:150px;" src="${BoardVo.thumbnail}" alt="..." /></a> 
                            
                                <div class="text-center">
                                    <!-- Product name-->
                                    <a class="fw-bolder" href="/ds/board/read?bno=${BoardVo.bno}">${BoardVo.title}</a>
                                    <br>
                                    <!-- Product price-->
                                    <p>작성자: ${BoardVo.writer}</p>
                                    <hr>
                                    <p>조회수: ${BoardVo.view_count}</p>
                                    <p>추천수: ${BoardVo.like_count}</p>
                                   
                                </div>
                            </div>
              
                        </div>
                    </div>
                </c:if>
                        </c:forEach>
                    
                   
                </div>
            </div>
        </section>
        
        
        
        
        
         <!-- Section 레시피-->
        <section class="py-1" id="recipePost" style="display:none;">
         <div class="container px-4 px-lg-5 mt-5">
           
         
         <ul class="menu" style="margin-right:50px;">
        
         
          <div>
		<img src="/resources/images/meet.png" alt="레시피 이야기" style="width:56px;height:44px;">
  		<span style="margin-top:20px;font-size:22px;" >레시피 이야기</span>
		</div>
         
            
         </ul>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                   
                      <c:forEach var="BoardVo" items="${list}">
                      <c:if test="${BoardVo.category=='레시피 이야기'}">
                    <div class="col mb-5">
                        <div class="card h-10">
                            <!-- Product image-->
<!--                             <img class="card-img-top"  src="/resources/images/vege.jpg" alt="..." /> -->
                            <!-- Product details-->
                            <div class="card-body p-4">
                          <a href="/ds/board/read?bno=${BoardVo.bno}"><img class="card-img-top" style="width:200px;height:150px;" src="${BoardVo.thumbnail}" alt="..." /></a> 
                            
                                <div class="text-center">
                                    <!-- Product name-->
                                    <a class="fw-bolder" href="/ds/board/read?bno=${BoardVo.bno}">${BoardVo.title}</a>
                                    <br>
                                    <!-- Product price-->
                                        <p>작성자: ${BoardVo.writer}</p>
                                    <hr>
                                    <p>조회수: ${BoardVo.view_count}</p>
                                    <p>추천수: ${BoardVo.like_count}</p>
                                </div>
                            </div>
                      
                        </div>
                    </div>
                </c:if>
                        </c:forEach>
                  
                   
                    
                    
                </div>
            </div>
        </section>
        
    </div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>      
<%@include file="/WEB-INF/views/include/action_form.jsp" %>
    </body>    