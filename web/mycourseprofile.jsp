<%-- 
    Document   : userchangepassword
    Created on : May 31, 2023, 11:49:53 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : ''}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="text" />
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>My Course</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


        <link href="https://fonts.googleapis.com/css?family=Muli:300,400,700,900" rel="stylesheet">
        <link rel="stylesheet" href="/SWP391_Group3/fonts/icomoon/style.css">

        <link rel="stylesheet" href="/SWP391_Group3/css/bootstrap.min.css">
        <link rel="stylesheet" href="/SWP391_Group3/css/jquery-ui.css">
        <link rel="stylesheet" href="/SWP391_Group3/css/owl.carousel.min.css">
        <link rel="stylesheet" href="/SWP391_Group3/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="/SWP391_Group3/css/owl.theme.default.min.css">

        <link rel="stylesheet" href="/SWP391_Group3/css/jquery.fancybox.min.css">

        <link rel="stylesheet" href="/SWP391_Group3/css/bootstrap-datepicker.css">

        <link rel="stylesheet" href="/SWP391_Group3/fonts/flaticon/font/flaticon.css">

        <link rel="stylesheet" href="/SWP391_Group3/css/aos.css">
        <link href="/SWP391_Group3/css/jquery.mb.YTPlayer.min.css" media="all" rel="stylesheet" type="text/css">

        <link rel="stylesheet" href="/SWP391_Group3/css/style.css">
        <link rel="stylesheet" href="/SWP391_Group3/css/user-profile.css">
        <link rel="stylesheet" href="/SWP391_Group3/themify-icons/themify-icons.css">
        <link rel="stylesheet" href="/SWP391_Group3/css/profile.css">
    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

        <div class="site-wrap">

            <%@include file="header.jsp"%>


            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4" style="background-image: url('images/bg_1.jpg')">
                <div class="container">
                    <div class="row align-items-end justify-content-center text-center">
                        <div class="col-lg-7">
                            <h2 class="mb-0"><fmt:message key="profile.myProfile" /></h2>
                        </div>
                    </div>
                </div>
            </div>


            <div class="custom-breadcrumns border-bottom">
                <div class="container">
                    <a href="index.html"><fmt:message key="header.Home" /></a>
                    <span class="mx-3 icon-keyboard_arrow_right"></span>
                    <span class="current"><fmt:message key="profile.myProfile" /></span>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-3 menu" style="background-color: white;">
                                <nav class="navbar" style="padding: 0">
                                    <!-- Links -->
                                    <ul class="navbar-nav">
                                        <li class="nav-item">
                                            <a href="/SWP391_Group3/userinformation"><fmt:message key="profile.AccountInformation" /> &nbsp;<i class="ti-user"></i></a> <br />
                                        </li>
                                        <li class="nav-item" >
                                            <a href="/SWP391_Group3/userchangepassword"><fmt:message key="profile.ChangePassword" /> &nbsp;<i class="ti-exchange-vertical"></i></a> <br />
                                        </li>
                                        <li class="nav-item" style="background-color: rgb(239, 239, 239); padding-left: 5px; padding-right: 20px;">
                                            <a href=""><fmt:message key="profile.MyCourses" /> &nbsp;<i class="ti-shopping-cart-full"></i></a>
                                        </li>
                                        <li class="nav-item" >
                                            <a href="/SWP391_Group3/transactionhistory"><fmt:message key="profile.TransactionHistory" /> &nbsp;<i class="ti-book"></i></a>
                                        </li>
                                    </ul>

                                </nav>
                            </div>
                            <div class="col-md-9 main">
                                <h1><fmt:message key="header.MyCourse" /></h1>
                                <div style="display:block; width: 98%; height: 1px; background-color: rgb(155, 155, 155);">
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <c:forEach items="${listcourse}" var="lc">
                                            <div class="col-md-5 card" style="padding: 0; margin: 10px;">
                                                <img class="card-img-top" src="${lc.course.image}" alt="Card image">
                                                <div class="card-body">
                                                    <h4 class="card-title">${lc.course.name}</h4>
                                                    <p class="card-text">${lc.category.name}</p>
                                                    <a href="/SWP391_Group3/course/${lc.course.slug}" class="btn btn-primary"><fmt:message key="button.learn" /></a>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>



            <%@include file="footer.jsp"%>



        </div>
        <!-- .site-wrap -->

        <!-- loader -->
        <div id="loader" class="show fullscreen"><svg class="circular" width="48px" height="48px">
            <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" />
            <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10"
                    stroke="#51be78" />
            </svg></div>

        <script src="/SWP391_Group3/js/jquery-3.3.1.min.js"></script>
        <script src="/SWP391_Group3/js/jquery-migrate-3.0.1.min.js"></script>
        <script src="/SWP391_Group3/js/jquery-ui.js"></script>
        <script src="/SWP391_Group3/js/popper.min.js"></script>
        <script src="/SWP391_Group3/js/bootstrap.min.js"></script>
        <script src="/SWP391_Group3/js/owl.carousel.min.js"></script>
        <script src="/SWP391_Group3/js/jquery.stellar.min.js"></script>
        <script src="/SWP391_Group3/js/jquery.countdown.min.js"></script>
        <script src="/SWP391_Group3/js/bootstrap-datepicker.min.js"></script>
        <script src="/SWP391_Group3/js/jquery.easing.1.3.js"></script>
        <script src="/SWP391_Group3/js/aos.js"></script>
        <script src="/SWP391_Group3/js/jquery.fancybox.min.js"></script>
        <script src="/SWP391_Group3/js/jquery.sticky.js"></script>
        <script src="/SWP391_Group3/js/jquery.mb.YTPlayer.min.js"></script>
        <script src="/SWP391_Group3/js/main.js"></script>

    </body>

</html>
