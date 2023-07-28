<%-- 
    Document   : unfollowedpage
    Created on : Jun 10, 2023, 8:25:02 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Unfollows Page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


        <link href="https://fonts.googleapis.com/css?family=Muli:300,400,700,900" rel="stylesheet">
        <link rel="stylesheet" href="fonts/icomoon/style.css">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">

        <link rel="stylesheet" href="css/jquery.fancybox.min.css">

        <link rel="stylesheet" href="css/bootstrap-datepicker.css">

        <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">

        <link rel="stylesheet" href="css/aos.css">
        <link href="css/jquery.mb.YTPlayer.min.css" media="all" rel="stylesheet" type="text/css">

        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/user-profile.css">
        <link rel="stylesheet" href="themify-icons/themify-icons.css">
        <link rel="stylesheet" href="/css/profile.css">
    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

        <div class="site-wrap">



            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4"
                 style="background-image: url('images/home/bg_1.jpg')">
                <div class="container">
                    <div class="row align-items-end justify-content-center text-center">
                        <div class="col-lg-7">
                            <h2 class="mb-0">We are sorry to see you go</h2>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${message == true}">
                <script>
                    window.alert("This email is not followed!");
                </script>
            </c:if>
            <div class="row justify-content-center" style="margin-top: 120px; margin-bottom: 200px;">
                <div class="col-md-5">
                    <form action="unfollowpage" id="form_login" method="POST"> 
                        <div class="row" style="text-align: center;">
                            <div class="col-md-12 form-group">
                                <img src="/images/home/email.png" alt="" style="width: 20%;">
                            </div>
                            <div class="col-md-12 form-group">
                                <h2>Are you sure about unsubscribing?</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8 form-group">
                                <input type="email" id="email" class="form-control form-control-lg"
                                       placeholder="Enter you email address" name="email">
                            </div>
                            <div class="col-md-4">
                                <input type="submit" value="Unsubscribe" class="btn btn-primary btn-lg px-5">
                            </div>
                        </div>
                    </form> 
                </div>
            </div>
            <div class="footer">

            </div>


        </div>
        <!-- .site-wrap -->

        <!-- loader -->
        <div id="loader" class="show fullscreen"><svg class="circular" width="48px" height="48px">
            <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" />
            <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10"
                    stroke="#51be78" />
            </svg></div>

        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/jquery-migrate-3.0.1.min.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.stellar.min.js"></script>
        <script src="js/jquery.countdown.min.js"></script>
        <script src="js/bootstrap-datepicker.min.js"></script>
        <script src="js/jquery.easing.1.3.js"></script>
        <script src="js/aos.js"></script>
        <script src="js/jquery.fancybox.min.js"></script>
        <script src="js/jquery.sticky.js"></script>
        <script src="js/jquery.mb.YTPlayer.min.js"></script>




        <script src="js/main.js"></script>

    </body>

</html>
