<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html lang="en">


<head>
<style>
.alert.alert-info {
    padding: 0.5rem 1rem; /* 상하 패딩을 줄여서 세로 폭을 줄입니다 */
    line-height: 1.2; /* 줄 간격을 줄여서 세로 폭을 줄입니다 */
   

}



</style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
	<!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="/resources/vendor/chart.js/Chart.min.js"></script>

<!--     <script src="/resources/js/demo/chart-area-demo.js"></script> -->
<!--     <script src="/resources/js/demo/chart-pie-demo.js"></script> -->
<script >

$(function() {
	
	// 관리자 중요 공지사항 안내
	$.ajax({
	    type: "get",
	    url: "/hn/manager/notice/managerNoticeShow",
	    success: function(rData) {
	        console.log(rData);
	        $('#noticeShow').html('<strong>관리자 중요 공지사항:</strong> <a href="/hn/manager/notice/noticeDetail/' + rData.n_no + '">' + rData.title + '</a>');
	    }
	});
	
	
	// 등급알람
	$("#alarmShow").click(function() {
		
	});
});

</script>
 
</head>


<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/hn/manager/user/userList">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">관리자 페이지 </div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="/hc/main/home">
               
                    <span>SINTOBURI MAIN</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                상품관리 
            </div>

<!--             Nav Item - Pages Collapse Menu -->
<!--             <li class="nav-item"> -->
<!--                 <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" -->
<!--                     aria-expanded="true" aria-controls="collapseTwo"> -->
<!--                     <i class="fas fa-fw fa-cog"></i> -->
<!--                     <span>주문/배송관리</span> -->
<!--                 </a> -->
<!--                 <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar"> -->
<!--                     <div class="bg-white py-2 collapse-inner rounded"> -->
<!--                         <h6 class="collapse-header">Custom Components:</h6> -->
<!--                         <a class="collapse-item" href="buttons.html">Buttons</a> -->
<!--                         <a class="collapse-item" href="cards.html">Cards</a> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </li> -->

			 <li class="nav-item">
                <a class="nav-link" href="/gr/sales_manage/list">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>결제/배송관리</span>
                </a>

            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                게시글관리 
            </div>
            
           
            <!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item">
			    <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapseMember" aria-expanded="true" aria-controls="collapseMember">
			         <i class="fas fa-fw fa-table"></i>
			        <span>회원관리</span>
			    </a>
			    <div id="collapseMember" class="collapse" aria-labelledby="headingMember" data-parent="#accordionSidebar">
			        <div class="bg-white py-2 collapse-inner rounded">
			            <a class="collapse-item" href="/hn/manager/user/userList">회원목록</a>
			            <a class="collapse-item" href="/hn/manager/user/managerList">관리자목록</a>
			        </div>
			    </div>
			</li>
			
			 <!-- Nav Item - Inquiry Collapse Menu -->
			<li class="nav-item">
			    <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapseInquiry" aria-expanded="true" aria-controls="collapseInquiry">
			        <i class="fas fa-fw fa-folder"></i>
			        <span>문의사항</span>
			    </a>
			    <div id="collapseInquiry" class="collapse" aria-labelledby="headingInquiry" data-parent="#accordionSidebar">
			        <div class="bg-white py-2 collapse-inner rounded">
			            <a class="collapse-item" href="/hn/manager/enquiry/goodsList">상품문의</a>
			            <a class="collapse-item" href="/hn/manager/enquiry/gradeList">등급문의</a>
			        </div>
			    </div>
			</li>   
            
			
            
              <li class="nav-item">
                <a class="nav-link" href="/hn/manager/notice/noticeList">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>공지사항</span>
                </a>

            </li>
            
             <li class="nav-item">
                <a class="nav-link" href="/hn/manager/faq/faqList">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>자주하는질문</span>
                </a>

            </li>

          


            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="/hn/manager/report/reportList">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>신고게시글</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

           
            <!-- Sidebar Message -->
           
               <div class="logo">
                  <img src="/resources/images/logo.png" alt="신토불이 로고" style="width: 230px;">
                </div>
           

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">
            <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

<!--                     Topbar Search -->
<!--                     <form -->
<!--                         class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"> -->
<!--                         <div class="input-group"> -->
<!--                             <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." -->
<!--                                 aria-label="Search" aria-describedby="basic-addon2"> -->
<!--                             <div class="input-group-append"> -->
<!--                                 <button class="btn btn-primary" type="button"> -->
<!--                                     <i class="fas fa-search fa-sm"></i> -->
<!--                                 </button> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </form> -->
				<div class="container-fluid" style="
				    width: 900px; 
			    	margin-left: 0px; 
			    	margin-right: 0px; 
					">
			    <div id="noticeShow" class="alert alert-info" role="alert">
			        <strong>관리자 중요 공지사항:</strong> 
			    </div>
			    
			</div>
			
			
			
                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- Nav Item - Alerts -->
                        <li  id="alarmShow" class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i  class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    Alerts Center
                                </h6>
                                    <c:forEach var="vo" items="${alarmList}">
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">${vo.user_id}</div>
                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                    </div>
                                </a>
                             </c:forEach>
                               
                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                            </div>
                        </li>

                        <!-- Nav Item - Messages -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-envelope fa-fw"></i>
                                <!-- Counter - Messages -->
                                <span class="badge badge-danger badge-counter">7</span>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="messagesDropdown">
                                <h6 class="dropdown-header">
                                    Message Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="/resources/img/undraw_profile_1.svg"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">Hi there! I am wondering if you can help me with a
                                            problem I've been having.</div>
                                        <div class="small text-gray-500">Emily Fowler Â· 58m</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="/resources/img/undraw_profile_2.svg"
                                            alt="...">
                                        <div class="status-indicator"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">I have the photos that you ordered last month, how
                                            would you like them sent to you?</div>
                                        <div class="small text-gray-500">Jae Chun Â· 1d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="/resources/img/undraw_profile_3.svg"
                                            alt="...">
                                        <div class="status-indicator bg-warning"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Last month's report looks great, I am very happy with
                                            the progress so far, keep up the good work!</div>
                                        <div class="small text-gray-500">Morgan Alvarez Â· 2d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="/resources/default.png" style="width:60px; height:60px"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Am I a good boy? The reason I ask is because someone
                                            told me that people say this to all dogs, even if they aren't good...</div>
                                        <div class="small text-gray-500">Chicken the Dog Â· 2w</div>
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                            </div>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                       <!-- Nav Item - User Information -->
                        <c:choose>
                        	<c:when test="${not empty login}">
                        
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${login.user_id}(${login.grade})</span>
                                <img class="img-profile rounded-circle"
                                    src="/resources/img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                        	</c:when>
                        	<c:otherwise>
                        		 <li class="nav-item dropdown no-arrow">
                        		 	<a href="/hn/main/login" class="btn btn-primary my-3 btnLogin">로그인</a>
                        		 </li>
                        	</c:otherwise>
                        </c:choose>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">