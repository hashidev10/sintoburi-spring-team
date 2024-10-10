<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
</main>
<style>
.footer {
    background-color: D6EFD8;
    padding: 20px 0;
    border-top: 1px solid #e7e7e7;
}

.footer .footer-container {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
}

.footer-column {
    flex: 1;
    margin: 0 10px;
}

.footer-logo {
    text-align: center;
}

.footer-logo img {
    height: 200px;
}

.footer-details {
    text-align: left;
}

.footer-contact {
    text-align: right;
}

.footer-contact p, .footer-details p {
    margin: 5px 0;
}

.footer-social a {
    margin-left: 10px;
}

.footer-copy {
    margin-top: 10px;
    font-size: 0.9em;
    color: #777;
}



</style>
<footer class="footer">
    <div class="footer-container">
        <div class="footer-column footer-logo">
            <img src="/resources/images/logo.png" alt="신토불이 로고">
        </div>
        <div class="footer-column footer-details">
            <p>(주)KH인재교육원</p>
            <p>대표자 : 이호면 | 사업자번호 : 610-86-10288 | 통신판매업신고번호 : 제 2012-울산남구-0050호</p>
            <p>주소 44677 울산광역시 남구 삼산로35번길 19 (신정동)9 </p>
            <p>팀 신토불이에서 만든 프로젝트용 쇼핑몰입니다.</p>
            <div class="footer-copy">
                <p>copyright (C) 2014 by nongsarang. all rights reserved.</p>
            </div>
        </div>
        <div class="footer-column footer-contact">
            <p>고객센터 Tel : 052-257-7600</p>
            <p>평일 10:00 ~ 17:00 / 점심시간 12:00 ~ 13:00</p>
            <p>주말, 공휴일 휴무</p>
            <p><a href="#">교환/환불문의</a></p>
            <div class="footer-social">
        <!--         <a href="#"><img src="/resources/images/social/kakao.png" alt="Kakao"></a>
                <a href="#"><img src="/resources/images/social/instagram.png" alt="Instagram"></a>
                <a href="#"><img src="/resources/images/social/facebook.png" alt="Facebook"></a>
                <a href="#"><img src="/resources/images/social/blog.png" alt="Blog"></a>
                <a href="#"><img src="/resources/images/social/naver.png" alt="Naver"></a> -->
            </div>
        </div>
    </div>
</footer>
</body>
</html>