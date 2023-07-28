<%-- Document : changepasswordinprofile Created on : Jun 5, 2023, 10:16:54 AM Author : Admin --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                <c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : ''}"
                    scope="session" />
                <fmt:setLocale value="${language}" />
                <fmt:setBundle basename="text" />
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <title>Your Profile</title>
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
                        <%@include file="header.jsp" %>
                            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4"
                                style="background-image: url('images/bg_1.jpg')">
                                <div class="container">
                                    <div class="row align-items-end justify-content-center text-center">
                                        <div class="col-lg-7">
                                            <h2 class="mb-0">
                                                <fmt:message key="profile.myProfile" />
                                            </h2>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="custom-breadcrumns border-bottom">
                                <div class="container">
                                    <a href="index.html">
                                        <fmt:message key="header.Home" />
                                    </a>
                                    <span class="mx-3 icon-keyboard_arrow_right"></span>
                                    <span class="current">
                                        <fmt:message key="profile.myProfile" />
                                    </span>
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
                                                            <a href="#">
                                                                <fmt:message key="profile.AccountInformation" />
                                                                &nbsp;<i class="ti-user"></i>
                                                            </a> <br />
                                                        </li>
                                                        <li class="nav-item"
                                                            style="background-color: rgb(239, 239, 239); padding-left: 5px; padding-right: 20px;">
                                                            <a href="userchangepassword">
                                                                <fmt:message key="profile.ChangePassword" /> &nbsp;<i
                                                                    class="ti-exchange-vertical"></i>
                                                            </a> <br />
                                                        </li>
                                                        <li class="nav-item">
                                                            <a href="mycourseprofile/listCourse">
                                                                <fmt:message key="profile.MyCourses" /> &nbsp;<i
                                                                    class="ti-shopping-cart-full"></i>
                                                            </a>
                                                        </li>
                                                        <li class="nav-item">
                                                            <a href="transactionhistory">
                                                                <fmt:message key="profile.TransactionHistory" />
                                                                &nbsp;<i class="ti-book"></i>
                                                            </a>
                                                        </li>
                                                    </ul>

                                                </nav>
                                            </div>
                                            <div class="col-md-9 main">
                                                <h1>Change password</h1>
                                                <!-- <p>Quản lý thông tin hồ sơ để bảo mật tài khoản</p> -->
                                                <div
                                                    style="display:block; width: 98%; height: 1px; background-color: rgb(155, 155, 155);">
                                                </div>
                                                <ul style="font-size: 12px">
                                                    <li>The length of the password must be between 6-20 characters</li>
                                                    <li>Must contain at least 1 numeric character from 0 to 9</li>
                                                    <li>Must contain at least 1 uppercase character</li>
                                                    <li>Must contain at least 1 lowercase character</li>
                                                    <li>Must contain at least 1 character in the character set "@#$%!"
                                                    </li>
                                                </ul>
                                                <form action="userchangepassword" method="POST" class="form_user"
                                                    onsubmit="return checkValidate()">
                                                    <div class="form-group" style="position: relative;">
                                                        <label for="username">Password:</label>
                                                        <p style="color: red" id="pword_err">${requestScope.pword_err}
                                                        </p>
                                                        <input type="password" class="form-control" id="pword"
                                                            placeholder="Enter password" name="password">
                                                        <i class="ti-eye"
                                                            style="position: absolute; bottom: 12px; right: 30px"
                                                            onclick="viewpassword(1)"></i>
                                                    </div>
                                                    <div class="form-group" style="position: relative;">
                                                        <label for="pwd">Enter new password:</label>
                                                        <p style="color: red" id="newpword_err">
                                                            ${requestScope.newpword_err}</p>
                                                        <input type="password" class="form-control" id="newpword"
                                                            placeholder="Enter new password" name="newpword">
                                                        <i class="ti-eye"
                                                            style="position: absolute; bottom: 12px; right: 30px"
                                                            onclick="viewpassword(2)"></i>
                                                    </div>
                                                    <div class="form-group" style="position: relative;">
                                                        <label for="pwd">Confirm your password:</label>
                                                        <p style="color: red" id="repword_err">
                                                            ${requestScope.repword_err}</p>
                                                        <input type="password" class="form-control" id="repword"
                                                            placeholder="Confirm your password" name="repword">
                                                        <i class="ti-eye"
                                                            style="position: absolute; bottom: 12px; right: 30px"
                                                            onclick="viewpassword(3)"></i>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">
                                                        <fmt:message key="button.Save" />
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

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
                    <script src="js/changepasswordinprofile.js"></script>

                    <script src="js/main.js"></script>

                </body>

                </html>
