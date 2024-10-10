<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 모달창 스타일  -->
<style>
.modal-dialog.modal-fullscreen {
    max-width: 100%;
    margin: 0;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.modal-content {
    height: 100%;
    border: none;
    border-radius: 0;
}

.modal-body {
    flex-grow: 1;
    overflow-y: auto;
}

.modal-footer {
    display: flex;
    justify-content: space-between; /* 양쪽 끝에 배치 */
    align-items: center; /* 세로 중앙 정렬 */
    width: 100%;
}

.cover{
	border-radius: 8px; /* 둥근 모서리 */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 가벼운 그림자 */
    margin-right: 15px;
    padding-left: 5px;
    padding-right: 5px;
}

.modal-left {
    display: flex;
    align-items: center; /* 아이템들을 수직 중앙 정렬 */
    margin-bottom: 0; /* 부트스트랩의 기본 마진 리셋 */
    padding: 5px;
    background: #fff; /* 흰색 배경 */
    flex-grow: 1; /* 남는 공간을 차지하게 설정 */
}

.modal-left img {
    width: 50px;
    height: 50px;
    border-radius: 8px; /* 이미지 둥근 모서리 */
    margin-right: 5px; /* 이미지와 텍스트 사이 간격 */
}
    
    
        
</style>
<!-- 모달창 jsp 뛰우기 -->
<%-- <div class="modal fade" id="myModal${detailVo.blog_no }" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <iframe src="/hc/blog/detail?blog_no=${detailVo.blog_no}" frameborder="0" style="width: 100%; height: 100%; overflow: hidden;" scrolling="no"></iframe>
            </div>
            <div class="modal-footer">
            	<div class="modal-left">
	            	<c:if test="${not empty detailVo.productTagList }">
            		<c:forEach items="${detailVo.productTagList}" var="tag">
	            		<div class="cover">
	            			<a href="#"><img src="/resources/images/logo.png" alt="Icon 1">${tag.product_name}</a>
	            		</div>
            		</c:forEach>
	            	</c:if>
            	</div>
                <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div> --%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <iframe id="myIframe" src="" frameborder="0" style="width: 100%; height: 100%; overflow: hidden;" scrolling="no"></iframe>
            </div>
            <div class="modal-footer">
            	<div class="modal-left">
            	</div>
                <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>