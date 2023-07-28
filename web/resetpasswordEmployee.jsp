<%-- 
    Document   : changepassword.jsp
    Created on : May 23, 2023, 10:58:30 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Reset Password</title>
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

        <link rel="stylesheet" href="themify-icons/themify-icons.css">

        <script>
           
        </script>
    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

        <div class="site-wrap">

            <%--<%@include file="header.jsp" %>--%>


            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4" style="background-image: url('images/bg_1.jpg')">
                <div class="container">
                    <div class="row align-items-end justify-content-center text-center">
                        <div class="col-lg-7">
                            <h2 class="mb-0">Reset Password</h2>
                        </div>
                    </div>
                </div>
            </div> 


            <div class="custom-breadcrumns border-bottom">
                <div class="container">
                    <a href="AdminEmployeeAccount">Admin Employee Account</a>                   
                    <span class="mx-3 icon-keyboard_arrow_right"></span>
                    <span class="current">Reset Password</span>
                </div>
            </div>

            <div class="site-section">
                <div class="container">


                    <div class="row justify-content-center">
                        <div class="col-md-5">
                            <form action="ResetPasswordEmployee" method="post" onsubmit="return checkValidate()">
                                <div class="row">
                                    <div class="col-md-12 form-group">
                                        <input type="hidden" id="username" class="form-control form-control-lg" value="${requestScope.username}" name="username">
                                    </div>
                                    <div class="col-md-12 form-group" style="position: relative;">
                                        <p style="color: red" id="pword_err">${requestScope.password_error}</p>
                                        <label for="pword">Enter New Password</label>
                                         <ul style="font-size: 12px">
                                            <li>The length of the password must be between 6-20 characters</li>
                                            <li>Must contain at least 1 numeric character from 0 to 9</li>
                                            <li>Must contain at least 1 uppercase character</li>
                                            <li>Must contain at least 1 lowercase character</li>
                                            <li>Must contain at least 1 character in the character set "@#$%!"</li>
                                        </ul>
                                        <input type="password" id="password" class="form-control form-control-lg" value="${requestScope.password}" name="password">
                                        <i class="ti-eye" style="position: absolute; bottom: 18px; right: 30px" onclick="viewpassword()"></i>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="pword">Re-enter password</label>
                                        <p style="color: red" id="repword_err">${requestScope.repassword_error}</p>
                                       
                                        <input type="password" id="repassword" class="form-control form-control-lg" value="${requestScope.re_password}" name="repassword">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <input type="submit" value="Reset Password" class="btn btn-primary btn-lg px-5">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>



                </div>
            </div>



            <%--<%@include file="footer.jsp" %>--%>


        </div>
        <!-- .site-wrap -->

        <!-- loader -->
        <div id="loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#51be78"/></svg></div>

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
        <script src="js/changepassword.js"></script>



        <script src="js/main.js"></script>

    </body>

</html>
