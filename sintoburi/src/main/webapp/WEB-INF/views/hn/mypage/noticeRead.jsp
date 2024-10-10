<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/top.jsp" %>
<%@ include file="/WEB-INF/views/hn/mypage/include/myPageSide.jsp" %>
  
<hr style="border: 0; height: 1px; background: #000; margin: 20px 0;">
<style>
   .section-divider-top {
        border: 0;
        height: 2px; /* 선의 두께 */
        background-color: #999; /* 연한 진한 회색 */
        margin: 0 0 20px 0; /* 제목 위 선과 다른 요소 사이의 간격 */
    }
    
    .section-divider-middle {
        border: 0;
        height: 1px; /* 얇은 선의 두께 */
        background-color: #ddd; /* 더 연한 회색 */
        margin: 10px 0; /* 제목과 내용 사이의 간격 */
    }

    .section-divider-bottom {
        border: 0;
        height: 2px; /* 선의 두께 */
        background-color: #999; /* 연한 진한 회색 */
        margin: 20px 0; /* 내용 아래 선과 다른 요소 사이의 간격 */
    }

    .divider {
        border: 0;
        height: 1px; /* 얇은 선의 두께 */
        background-color: #ddd; /* 연한 회색 */
        margin: 10px 0; /* 구분선과 다른 요소 사이의 간격 */
    }
    
    .navigation-links {
        margin-top: 20px;
    }

    .navigation-item {
        margin-bottom: 10px; /* 항목 사이의 간격 */
    }

    .navigation-link {
        text-decoration: none;
        color: #007bff; /* 링크 색상 */
    }
</style>
 
<div class="col-md-8" style="margin-top: 20px;">
    <hr class="section-divider-top">
    
    <div style="display: flex; justify-content: space-between; align-items: center;">
        <h3 style="margin: 0;">
            ${noticeVo.title}
        </h3>
        <p style="margin: 0;">
            <fmt:formatDate value="${noticeVo.write_date}" pattern="yyyy-MM-dd"/>
        </p>
    </div>
    <hr class="section-divider-middle">
    
    <div class="row">
        <div class="col-md-12 text-left">
            <p><pre>${noticeVo.content}</pre></p>
        </div>
    </div>
    
     <!-- 첨부파일 리스트 -->
<div class="form-group" id="uploadedList">
<c:forEach items="${noticeVo.imageList}" var="vo">
	<li>
		<img src="/hn/manager/display?fileName=${vo.upload_path}/${vo.uuid}_${vo.image_name}"/>
	</li>
</c:forEach>
</div>
    
    <hr class="section-divider-bottom">
    
    <div class="navigation-links">
       <div class="navigation-links">
    <c:if test="${nextNotice != null}">
        <div class="navigation-item" style="margin-top: 20px;">
            <label> 다음글 </label>
            <a href="/hn/mypage/noticeRead?n_no=${nextNotice.n_no}" class="navigation-link">${nextNotice.title}</a>
        </div>
    </c:if>
    
    <hr class="divider">
    
    <c:if test="${previousNotice != null}">
        <div class="navigation-item">
            <label > 이전글 </label>
            <a href="/hn/mypage/noticeRead?n_no=${previousNotice.n_no}" class="navigation-link">${previousNotice.title}</a>
        </div>
    </c:if>
</div>
        
    </div>
    
    <hr class="divider">
    
    <div class="row">
        <div class="col-md-12 text-center">
            <a href="/hn/mypage/noticeList">
               <button type="button" class="btn btn-success btn" style=" margin-top: 30px;">목록보기</button>
            </a>
        </div>
    </div>
</div>

   
    

 <%@ include file="/WEB-INF/views/include/bottom.jsp" %>