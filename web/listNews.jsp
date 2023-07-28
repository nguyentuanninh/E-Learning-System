<%-- Document : news-single.jsp Created on : May 14, 2023, 9:32:07 AM Author : Admin --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : ''}"
       scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="text" />
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>List News</title>
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
        <link href="/SWP391_Group3/css/jquery.mb.YTPlayer.min.css" media="all" rel="stylesheet"
              type="text/css">

        <link rel="stylesheet" href="/SWP391_Group3/css/style.css">

        <link rel="stylesheet" href="/SWP391_Group3/themify-icons/themify-icons.css">


    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300" style="overflow-x: hidden">

        <div class="site-wrap">

            <%@include file="header.jsp" %>


            <form action="news" method="GET">

                <div class="row py-5">

                    <div class="col-md-2"></div>
                    <div class="col-md-8" style="padding-top: 100px; ">
                        <h1 style="align-items: center; color: black">
                            <fmt:message key="news.ListNews" />
                        </h1>
                        <hr/>
                        <div id="tbody" class=" row align-items-center mt-5">
                            <c:forEach items="${listNews}" var="lca">
                                <div class="acc row mb-3" style="border: 2px solid #e8e8e8; border-radius: 16px;padding: 10px; width: 100%">
                                    <div class="col-lg-4 wow fadeInUp " data-wow-delay="0.1s">
                                        <div class="d-flex align-items-center justify-content-center" style="height: 100%">
                                            <img src="${lca.image}" alt="images" class="img-fluid"
                                                 style="width: 100%;border-radius: 15px;">
                                        </div>

                                    </div>
                                    <div class="col-lg-8 wow fadeInUp" data-wow-delay="0.5s">
                                        <div class="h-100">

                                            <h3 style="color: black" ><a class="display-6"
                                                                         href="newsDetails/${lca.slug}" style="color: black; font-weight: bold">${lca.title}</a>
                                            </h3>
                                            <div style="height: 120px; overflow: hidden">
                                                <p class=" fs-5 mb-4">${lca.description}</p>
                                            </div>
                                            <p style="color: black">${lca.createdDate}</p>

                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="mt-3 text-center" >
                            <button class="btn btn-primary" type="button" onclick="loadMore()">Load More...</button>
                        </div>
                        <div class="d-none d-md-block col-md-3"></div>

                    </div>

                </div>
        </div>
    </form>




    <%@include file="footer.jsp" %>


</div>
<!-- .site-wrap -->

<!-- loader -->
<div id="loader" class="show fullscreen"><svg class="circular" width="48px" height="48px">
    <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4"
            stroke="#eeeeee" />
    <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4"
            stroke-miterlimit="10" stroke="#51be78" />
    </svg></div>

<script>function loadMore() {
                var amount = document.getElementsByClassName("acc").length;
                $.ajax({
                    url: "/SWP391_Group3/LoadMoreNews",
                    type: "get", //send it through get method
                    data: {
                        exits: amount
                    },
                    success: function (response) {
                        var row = document.getElementById("tbody");
                        row.innerHTML += response;
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });
            }</script>
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
