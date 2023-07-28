<%-- 
    Document   : adminlogin
    Created on : May 19, 2023, 3:01:48 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Admin Login</title>
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
<!--        <script>
            function viewpassword() {
                var view = document.getElementById('pword');
                if (view.type === 'text')
                    view.type = 'password';
                else
                    view.type = 'text';
            }
        </script>-->

    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

        <div class="site-wrap">

            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4" style="background-image: url('images/bg_1.jpg')">
                <div class="container">
                    <div class="row align-items-end justify-content-center text-center">
                        <div class="col-lg-7">
                            <h2 class="mb-0">Sign In</h2>
                            <p>ADMIN</p>
                        </div>
                    </div>
                </div>
            </div> 

            <div class="site-section">
                <div class="container">


                    <div class="row justify-content-center">
                        <div class="col-md-5">
                            <form action="adminlogin" method="post" onsubmit="return checkvalidate()">
                                <div class="row">
                                    <h5 style="color: red">${requestScope.err}</h5>

                                    <div class="col-md-12 form-group">
                                        <label for="username">Username</label>
                                        <p id="username_err" style="color: red"></p>
                                        <input type="text" id="username" class="form-control form-control-lg" value="${cookie.adminname.value}" name="username">
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="pword">Password</label>
                                        <p id="password_err" style="color: red"></p>
                                        <i class="ti-eye" style="position: absolute; bottom: 18px; right: 30px" onclick="viewpassword()"></i>
                                        <input type="password" id="pword" class="form-control form-control-lg" value="${cookie.adminpassword.value}" name="password">
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <div style="display: inline-block;">
                                            <input type="checkbox" id="rememberme" name="rememberme" <c:if test="${cookie.adminname.value != null}"> checked</c:if>> Remember Me
                                        </div>             
<!--                                        <a href=""><u>Forget password</u></a>-->
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <input type="submit" value="Login" class="btn btn-primary btn-lg px-5">
                                    </div>
                                </div>
                                         <p style='text-align: center; margin-top: 20px'><a href="/SWP391_Group3/login.jsp">Login by User</a></p>
                            </form>
                        </div>
                    </div>



                </div>
            </div>





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
        <script src="js/adminlogin.js"></script>




        <script src="js/main.js"></script>

    </body>

</html>