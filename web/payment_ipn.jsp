<%-- 
    Document   : courses.jsp
    Created on : May 14, 2023, 9:31:27 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Payment</title>
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

        <link rel="stylesheet" href="css/course.css">

        <link rel="stylesheet" href="themify-icons/themify-icons.css">
    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

        <div class="site-wrap">

            <%@include file="header.jsp" %>



            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4" style="background-image: url('images/bg_1.jpg')">
                <div class="container">
                    <div class="row align-items-end">
                        <div class="col-lg-7">
                            <h2 class="mb-0">Recharge</h2>
                        </div>
                    </div>
                </div>
            </div>


            <div class="custom-breadcrumns border-bottom">
                <div class="container">
                    <a href="home">Home</a>
                    <span class="mx-3 icon-keyboard_arrow_right"></span>
                    <span class="current">Recharge</span>
                </div>
                <div class="ml-auto" style="margin-bottom: 20px; text-align: right;">
                    <div class="social-wrap" style="position: relative; right: 10px;">
                        <a href="#" class="d-inline-block d-lg-none site-menu-toggle js-menu-toggle text-black"><span
                                class="icon-menu h3"></span></a>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <div class="row flex-row justify-content-center align-items-center">
                        <div class="col-md-6 text-center" >
                            <h3 class="mb-5 text-black">${message}</h3>
                            <a href="http://localhost:8080/SWP391_Group3/" class="btn btn-primary">Go to Home</a>
                        </div>
                        <div class="col-md-6">
                            <img src="https://www.pngmart.com/files/7/Payment-PNG-Transparent-Picture.png" 
                                  alt="image payment" class="img-fluid"/>
                        </div>
                    </div>

                    
                </div>
            </div>

            <%@include file="footer.jsp" %>

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
        <script>
            const numberInput = document.getElementById('exampleInputPassword1');
            const output = document.getElementById('output');

            numberInput.addEventListener('input', (event) => {
                const inputValue = parseFloat(event.target.value);
                if (!isNaN(inputValue)) {
                    const formattedNumber = inputValue.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                    output.textContent = "Amount: " + formattedNumber;
                    console.log(formattedNumber);
                } else {
                    output.textContent = '';
                }
            });


        </script>
    </body>

</html>
