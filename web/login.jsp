<%-- 
    Document   : login.jsp
    Created on : May 14, 2023, 9:31:42 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Login</title>
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

            <%--<%@include file="header.jsp" %>--%>

            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4" style="background-image: url('images/bg_1.jpg')">
                <div class="container">
                    <div class="row align-items-end justify-content-center text-center">
                        <div class="col-lg-7">
                            <h2 class="mb-0">Login</h2>
                        </div>
                    </div>
                </div>
            </div> 


            <div class="custom-breadcrumns border-bottom">
                <div class="container">
                    <a href="home">Home</a>
                    <span class="mx-3 icon-keyboard_arrow_right"></span>
                    <span class="current">Login</span>
                </div>
            </div>

            <div class="site-section">
                <div class="container">


                    <div class="row justify-content-center">
                        <div class="col-md-5">
                            <h5 style="color: blue; text-align: center">${requestScope.message}</h5>
                            <h5 style="color: red">${requestScope.err}</h5>
                            <form action="/SWP391_Group3/login" method="post" onsubmit='return checkvalidate()' id="form_login">
                                <div class="row">
                                    <div class="col-md-12 form-group">
                                        <label for="username">Username</label>
                                        <p id="username_err" style="color: red"></p>
                                        <input type="text" id="username" class="form-control form-control-lg" name="username" value="${cookie.name.value}">
                                    </div>

                                    <div class="col-md-12 form-group" style="position: relative;">
                                        <label for="pword">Password</label>
                                        <p id="password_err" style="color: red"></p>
                                        <input type="password" id="pword" class="form-control form-control-lg" name="password" value="${cookie.password.value}">
                                        <i class="ti-eye" style="position: absolute; bottom: 18px; right: 30px" onclick="viewpassword()"></i>
                                    </div>
                                </div>
                                <div style="margin-bottom: 30px; display: flex; justify-content: space-between">
                                    <div>
                                        <input type="checkbox" name="rememberme" <c:if test="${cookie.name.value != null}"> checked</c:if>
                                               ><span>Remember me</span> 
                                        </div>
                                        <a href="changepassword.jsp">Forget Password</a>
                                    </div>

                                    <div class="row">
                                        <div class="col-12">
                                            <input type="submit" value="Login" class="btn btn-primary btn-lg px-5">
                                            <!--                                            <button class="btn btn-primary btn-lg px-5" onclick="checkvalidate()">Login</button>-->
                                        </div>
                                    </div>
                                    <br>
                                    
                                    <form action="login-google" method="POST">
                                        <a href="https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/userinfo.profile+email&client_id=1037340877364-3grh6jb6cinv86g71hnjdl8ki3ruqijg.apps.googleusercontent.com&response_type=code&redirect_uri=http://localhost:8080/SWP391_Group3/loginwithgg&approval_prompt=force" type="submit" class="btn" style=" border: 1px solid black; margin-top: 10px"><img
                                                src="/SWP391_Group3/images/home/Google-Icon.png" style="height: 18px;">
                                            Sign in with Google</a>                                    
                                    </form>
                                    
                                    
                                    <p style='text-align: center; margin-top: 20px'>If you don't have an account <a href="register.jsp">Sign Up</a> </p>
                                    <p style='text-align: center; margin-top: 20px'><a href="/SWP391_Group3/adminlogin.jsp">Login by Admin</a></p>
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
        <script src="/SWP391_Group3/js/login.js"></script>



        <script src="/SWP391_Group3/js/main.js"></script>

    </body>

</html>
