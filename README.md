### 목차

> 1. [ERD 구조](#erd-구조)
> 2. [기술 스택](#기술-스택)
> 3. [주요 기능](#주요-기능)


# 프로젝트 소개
> "신토불이" 프로젝트는 귀농 청년들을 대상으로 농작물 판매를 지원하는 온라인 플랫폼 구축을 목표로 했습니다. 
> 
> SpringMVC를 기반으로 REST API를 구현하였습니다.
> 
> ### 개발 기간 및 인원
> 24.08.16 ~ 23.09.3 (3주) \
> 백엔드 5명



# ERD 구조

![image](https://github.com/user-attachments/assets/451945ab-b113-4d8f-a7ac-02c7c056a306)


# 기술 스택
언어 JAVA (JDK11) , HTML/CSS, JavaScript<br>
서버 ApacheTomcat 9.0<br>
프레임워크 SpringMVC, MyBatis 3.4.6<br>
DB Oracle11.2<br>
빌드 maven<br>
IDE eclipse<br>

# 주요 기능

### 요약

<table align="center"><!-- 팀원 표 -->
  <tr>
   <th>
    공통
   </th>
   <th>
    사용자
   </th>
   <th >
    관리자
   </th>
   </tr>
  <tr>
   <td align="left" width="350px" class="공통">
    - 회원가입, 로그인
    <br/>
    - 상품 목록 및 상세 조회
    <br/>
    - 블로그 게시글 목록 및 상세 조회
    <br/>
    - 커뮤니티 게시글 목록 및 상세 조회 
    <br/>
    - 공지사항 및 자주하는 질문
   </td>
    
   <td align="left" width="350px" class="사용자">
    - 상품몰 관리
    <br/>
    - 주문관리 및 장바구니 
    <br/>
    - 블로그 관리
    <br/>
    - 커뮤니티 관리
    <br/>
    - 마이페이지 관리
   </td>

   <td align="left" width="350px" class="관리자">
    - 회원 및 등급 관리
    <br/>
    - 상품 및 카테고리 관리
    <br/>
    - 공지사항 및 faq 관리
    <br/>
    - 신고 게시글 및 문의 관리
   </td>
  </tr>
</table>

## [ 공통 기능 ]

### 회원가입, 로그인
- 사용자는 개인정보를 입력해 회원가입할 수 있다.
- 회원가입 시 사용한 아이디와 비밀번호를 이용해 로그인할 수 있다.

### 상품 목록 및 상세 조회
- 상품 카테고리 별 상품 목록을 조회할 수 있다.


### 블로그 게시글 목록 및 상세 조회
- 블로그 게시글 목록 및 상세 조회를 할 수 있다.


### 커뮤니티 게시글 목록 및 상세 조회 
- 커뮤니티 게시글 목록 및 상세 조회를 할 수 있다.

### 공지사항 및 자주하는 질문
- 공지사항과 자주하는 질문을 조회 할 수 있다.

## [ 사용자 기능 ]

### 상품몰 관리
- 상품몰 CRUD 할 수 있다.

### 주문관리 및 장바구니 
- 장바구니 수정 할 수 있다.
- 주문결제가 할 수 있다.

### 블로그 관리
- 블로그 글 CRUD 할 수 있다.
- 블로그 설정 변경 할 수 있다.


### 커뮤니티 관리
- 커뮤니티 그 CRUD 할 수 있다.
- 퀴즈, 경마게임 할 수 있다.

### 마이페이지 관리
- 1:1 문의사항 등록,수정,삭제가 가능하다.
- 회원수정 및 탈퇴가 가능하다.

## [ 관리자 기능 ]

### 회원 및 등급 관리
- 회원 목록 조회 및 상세 정보 확인을 할 수 있다.
- 회원의 등급 수정 및 사업자번호 업데이트를 할 수 있다.
- 등급 변경이 필요한 회원 리스트 조회를 할 수 있다.

### 상품 및 카테고리 관리


### 공지사항 및 faq 관리
- 게시글 목록 조회 및 등록, 수정, 삭제를 할 수 있다.
- 공지사항 항목에 따라 일반/중요/관리자로 나뉘며 상단에 표시 된다.

### 신고 게시글 및 문의 관리
- 신고된 게시글 목록 조회 및 삭제처리를 할 수 있다.
- 상품 및 등급 관련 문의 사항 관리 및 답변처리를 할 수있다.





