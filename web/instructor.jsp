<%-- 
    Document   : about.jsp
    Created on : May 14, 2023, 9:28:22 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : ''}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="text" />
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Instructor</title>
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

        <link rel="stylesheet" href="/SWP391_Group3/themify-icons/themify-icons.css">

    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

        <div class="site-wrap">

            <%@include file="header.jsp" %>

            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4" style="background-image: url('images/bg_1.jpg')">

            </div> 


            <div class="custom-breadcrumns border-bottom">
                <div class="container">
                    <a href="Home"><fmt:message key="header.Home" /></a>
                    <span class="mx-3 icon-keyboard_arrow_right"></span>
                    <span class="current"><fmt:message key="header.Instructor" /></span>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <div class="row mb-5 justify-content-center text-center">
                        <div class="col-lg-4 mb-5">
                            <h2 class="section-title-underline mb-5">
                                <span><fmt:message key="header.Instructor" /></span>
                            </h2>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach items="${listInstructor}" var="i">    
                            <div class="col-lg-4 col-md-6 mb-5 mb-lg-5">
                                <div class="feature-1 border person text-center">
                                    <img src="${i.img}" alt="Image" class="img-fluid" style="object-fit: cover">
                                    <div class="feature-1-content">
                                        <h2>${i.name}</h2>
                                        <span class="position mb-3 d-block">${i.job}</span>    
                                        <p>${i.bio}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>


            <%@include file="footer.jsp" %>

        </div>
        <!-- .site-wrap -->

        <!-- loader -->
        <div id="loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#51be78"/></svg></div>

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




        <script src="js/main.js"></script>

    </body>

</html>
