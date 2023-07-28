<%-- 
    Document   : courses.jsp
    Created on : May 14, 2023, 9:31:27 AM
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
                            <h2 class="mb-0"><fmt:message key="payment.recharge" /></h2>
                        </div>
                    </div>
                </div>
            </div>


            <div class="custom-breadcrumns border-bottom">
                <div class="container">
                    <a href="home"><fmt:message key="header.Home" /></a>
                    <span class="mx-3 icon-keyboard_arrow_right"></span>
                    <span class="current"><fmt:message key="payment.recharge" /></span>
                </div>
                <div class="ml-auto" style="margin-bottom: 20px; text-align: right;">
                    <div class="social-wrap" style="position: relative; right: 10px;">
                        <a href="#" class="d-inline-block d-lg-none site-menu-toggle js-menu-toggle text-black"><span
                                class="icon-menu h3"></span></a>
                    </div>
                </div>
            </div>

            <div class="site-section">
                <div class="container d-flex justify-content-center flex-column align-items-center">
                    <h3 class="mb-3 text-black"><fmt:message key="payment.balance" />: <fmt:formatNumber value="${sessionScope.account.amount}"/> VNĐ</h3>
                    <img src="${uri}" width="400px" alt="QR Code" class="img-fluid"/>
                    <div style="width: 500px; text-align: center">
                        <p class="text-danger font-weight-bold"><fmt:message key="payment.text1" /></p>
                    <p><fmt:message key="payment.text2" /></p>
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
