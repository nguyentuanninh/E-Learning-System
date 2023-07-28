<%-- 
    Document   : news-single.jsp
    Created on : May 14, 2023, 9:32:07 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : ''}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="text" />
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>${newsbyid.title}</title>
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
        <script src="https://kit.fontawesome.com/81e4fcabce.js" crossorigin="anonymous"></script>

    </head>
    <style>
        .image img{
            width: 100%;
        }
        .progress-container {
            width: 100vw;
            height: 8px;
            background: #ccc;
        }
        .progress-bar {
            height: 8px;
            background: #04AA6D;
            width: 0%;
        }
        .sticky-wrapper .shrink{
            padding-bottom: 0px !important;
        }

        #carouselExampleControls {
            position: relative;
        }
        #carouselExampleControls:after {
            content : "";
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            background-color: black;
            width: 100%;
            height: 100%;
            opacity : 0.8;
            z-index: -1;
        }

    </style>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300" style="overflow-x: hidden">

        <div class="site-wrap">

            <%@include file="header.jsp" %>

            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4">
            </div> 

            <div class="site-section" style="z-index: 1">
                <div class="container">
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <h1 style="color: black"><strong>${newsbyid.title}</strong></h1>
                            <p><fmt:formatDate pattern="dd-MM-yyyy" value="${newsbyid.createdDate}"></fmt:formatDate></p>
                            <hr/>
                            <br>
                            <div id="content">
                                <p style="color: black">${newsbyid.content}</p>
                            </div>
                            <hr style="color: red; "/>
                            <h2 style="color:red" class="mb-4">Hot News</h2>
<!--                            <h1 class="pt-5 pb-5" style="color: black"><strong>Other news</strong></h1>-->
                            <c:forEach begin="${0}" end="${requestScope.listtopnews.size()-1}" var="i" step="${1}">
                                                                <div class="post-entry-big horizontal d-flex mb-4 row">
                                                                    <div class="col-12 col-md-4">
                                                                        <a href="${requestScope.listtopnews[i].slug}" class="img-link">
                                                                            <img src="${requestScope.listtopnews[i].image}" alt="Image" class="img-fluid" style="object-fit: cover; width: 100%"/>
                                                                        </a>
                                                                    </div>
                                                                    <div class="col-12 col-md-8">
                                                                        <div class="post-content">
                                                                            <div class="post-meta">
                                                                                <a href="${requestScope.listtopnews[i].slug}"><fmt:formatDate pattern="dd-MM-yyyy" value="${requestScope.listtopnews[i].createdDate}" /></a>
                                                                                <span class="mx-1">/${requestScope.listCreateBy[i].name}</span>
                                                                                <a href="${requestScope.listtopnews[i].slug}"></a>
                                                                            </div>
                                                                            <h3 class="post-heading"><a href="${requestScope.listtopnews[i].slug}">${requestScope.listtopnews[i].title}</a></h3>
                                                                            <div style="height: 130px;overflow: hidden" >
                                                                                <i>${requestScope.listtopnews[i].description}</i>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                
                                                                </div>
                            </c:forEach>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                </div>
            </div>
            <div id="carouselExampleControls" class="carousel slide justify-content-center align-items-center" data-ride="carousel" 
                 style="position: fixed;top: 0;left: 0; width: 100vw; height: 100vh; z-index: 100;
                 padding: 50px; display: none" >

                <i class="fa-solid fa-xmark fa-2xl" id="closeSlide" style="color: #ffffff; position: fixed; top: 40px; right: 40px; z-index: 200; cursor: pointer; width: 50px; height: 50px"></i>
                <div class="carousel-inner" id="imgNews"> </div>

                <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
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
        <script src="/SWP391_Group3/js/main.js"></script>
        <script src="/SWP391_Group3/js/new.js"></script>

    </body>
</html>