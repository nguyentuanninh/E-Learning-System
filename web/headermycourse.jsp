<%-- 
    Document   : headermycourse
    Created on : Jun 5, 2023, 9:54:03 AM
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

        <link rel="stylesheet" href="/SWP391_Group3/css/course.css">

        <link rel="stylesheet" href="/SWP391_Group3/themify-icons/themify-icons.css">
    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

        <div class="site-wrap">

            <%@include file="header.jsp"%>



            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4"
                 style="background-image: url('images/bg_1.jpg')">
                <div class="container">
                    <div class="row align-items-end">
                        <div class="col-lg-7">
                            <h2 class="mb-0"><fmt:message key="header.MyCourse" /></h2>
                        </div>
                    </div>
                </div>
            </div>

            <div class="site-section">

                <div class="container">
                    <div class="row">
                        <c:forEach items="${listcourse}" var="lc">
                            <div class="col-md-5 card" style="padding: 0; margin: 10px;">
                                <img class="card-img-top" src="${lc.course.image}" alt="Card image">
                                <div class="card-body">
                                    <h4 class="card-title">${lc.course.name}</h4>
                                    <p class="card-text">${lc.category.name}</p>
                                    <a href="learn/${lc.course.slug}" class="btn btn-primary"><fmt:message key="button.learn" /></a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <%@include file="footer.jsp"%>

            </div>

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
