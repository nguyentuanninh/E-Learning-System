<%-- 
    Document   : index.jsp
    Created on : May 14, 2023, 9:27:06 AM
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
        <title>Academics</title>
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

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

        <div class="site-wrap">
            <%@include file="header.jsp" %>     
            <c:if test="${requestScope.slide != null}">
                <div class="hero-slide owl-carousel site-blocks-cover" >

                    <c:forEach items="${slide}" var="ls">
                        <div class="intro-section" style="background-image: url('${ls.image}');">
                            <div class="container">
                                <div class="row align-items-center">
                                    <div class="col-lg-12 mx-auto text-center" data-aos="fade-up">
                                        <c:if test="${language=='vi_VN'}">
                                            <h2 style="font-size: 7rem ; font-weight: 900 ; color: #fff ">${ls.nameVn}</h2>
                                        </c:if>
                                        <c:if test="${language!='vi_VN'}">
                                            <h2 style="font-size: 7rem ; font-weight: 900 ; color: #fff ">${ls.name}</h2>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <div class="site-section">
                <div class="container">
                    <div class="row mb-5 justify-content-center text-center">
                        <div class="col-lg-4 mb-5">
                            <h2 class="section-title-underline mb-5">
                                <span>
                                    <fmt:message key="course.Category" />
                                </span>
                            </h2>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach items="${listcategory}" var="lca">
                            <div class="col-lg-4 col-md-6 mb-4 mb-lg-0">

                                <div class="feature-1 border">
                                    <div class="icon-wrapper bg-primary"
                                         style="font-size: 50px; text-align: center; color: white; padding: 5px;">
                                        <i class="ti-stack-overflow"></i>
                                    </div>
                                    <div class="feature-1-content">
                                        <c:if test="${language=='vi_VN'}">
                                            <h2>${lca.name_vn}</h2>
                                        </c:if>
                                        <c:if test="${language!='vi_VN'}">
                                            <h2>${lca.name}</h2>
                                        </c:if>

                                        <div style="display: block; height: 100px">
                                            <p style="overflow: hidden">${lca.description}</p>
                                        </div>
                                        <p><a href="listcoursebycategory/${lca.slug}" class="btn btn-primary px-4 rounded-0">
                                                <fmt:message key="button.LearnMore" />
                                            </a></p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                </div>
            </div>
            <!--About-->
            <div class="section-bg style-1" style="background-image: url('images/about_1.jpg');">
                <div class="container">
                    <div class="row">
                        <c:forEach begin="${0}" end="${requestScope.abtUs.size()-1}" var="i" step="${1}">

                            <div class="col-lg-4">
                                <h2 class="section-title-underline style-2"> 
                                    <c:if test="${language=='vi_VN'}">
                                        <span>${requestScope.abtUs[i].title_vn}</span>
                                    </c:if>
                                    <c:if test="${language!='vi_VN'}">
                                        <span>${requestScope.abtUs[i].title}</span>
                                    </c:if>
                                </h2>
                            </div>
                            <div class="col-lg-8">
                                <c:if test="${language=='vi_VN'}">
                                    <p class="lead" > ${requestScope.abtUs[i].content_vn} </p>
                                </c:if>
                                <c:if test="${language!='vi_VN'}">
                                    <p class="lead" > ${requestScope.abtUs[i].content} </p>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="site-section">
                <div class="container">
                    <div class="row mb-5 justify-content-center text-center">
                        <div class="col-lg-6 mb-5">
                            <h2 class="section-title-underline mb-3">
                                <span>
                                    <fmt:message key="course.popularCourses" />
                                </span>
                            </h2>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="owl-slide-3 owl-carousel">
                                <c:forEach items="${listcourse}" var="lc">
                                    <div class="course-1-item">
                                        <figure class="thumnail">
                                            <a href="course-single.jsp"><img src="${lc.course.image}" alt="Image"
                                                                             class="img-fluid"></a>
                                            <div class="price">
                                                <fmt:formatNumber value="${lc.course.price}" />
                                            </div>
                                            <div class="category">
                                                <h3>${lc.category.name}</h3>
                                            </div>
                                        </figure>
                                        <div class="course-1-content pb-4">
                                            <h2 style="height: 60px; overflow: hidden">${lc.course.name}</h2>
                                            <p class="desc mb-4" style="height: 180px; overflow: hidden">${lc.course.description}</p>
                                            <p><a href="course/${lc.course.slug}" class="btn btn-primary rounded-0 px-4">
                                                    <fmt:message key="button.Details" />
                                                </a></p>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--Slogan-->
        <div class="section-bg style-1" style="background-image: url('images/hero_1.jpg');">
            <div class="container">
                <div class="row">
                    <c:forEach begin="${0}" end="${requestScope.slg.size()-1}" var="i" step="${1}">                            
                        <div class="col-lg-4 col-md-6 mb-5 mb-lg-0">
                            <span class="icon flaticon-mortarboard"></span>
                            <c:if test="${language=='vi_VN'}">
                                <h3>${requestScope.slg[i].title_vn}</h3>
                                <p>${requestScope.slg[i].content_vn}</p>
                            </c:if>
                            <c:if test="${language!='vi_VN'}">
                                <h3>${requestScope.slg[i].title}</h3>
                                <p>${requestScope.slg[i].content}</p>
                            </c:if>
                        </div>                   
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="site-section">
            <div class="container">
                <div class="row mb-5">
                    <div class="col-lg-4">
                        <h2 class="section-title-underline">
                            <span>
                                <fmt:message key="header.Instructor" />
                            </span>
                        </h2>
                    </div>
                </div>

                <!--instructor-->
                <div class="owl-slide owl-carousel">
                    <c:forEach items="${listinstructor}" var="li">
                        <div class="ftco-testimonial-1">
                            <div class="ftco-testimonial-vcard d-flex align-items-center mb-4">
                                <img src="${li.img}" alt="Image" class="img-fluid mr-3" style="object-fit: cover">
                                <div>
                                    <h3>${li.name}</h3>
                                    <span>${li.job}</span>
                                </div>
                            </div>
                            <div>
                                <p>${li.bio}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!--News-->
        <div class="news-updates">
            <div class="container">

                <div class="row">

                    <div class="col-lg-12">
                        <div class="section-heading">
                            <h2 class="text-black"><fmt:message key="home.TopNews" /></h2>

                            <a href="listNews"><fmt:message key="home.All" /></a>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="post-entry-big">
                                    <div style="width: 100%">
                                        <a href="newsDetails/${requestScope.lnews[0].slug}" class="img-link" style="width: 100%">
                                            <img src="${requestScope.lnews[0].image}" alt="Image" class="img-fluid" style="width: 100%"/></a>

                                    </div>
                                    <div class="post-content">
                                        <div class="post-meta">
                                            <a href="newsDetails/${requestScope.lnews[0].slug}"><fmt:formatDate pattern="dd-MM-yyyy" value="${requestScope.lnews[0].createdDate}" /></a>
                                            <span class="mx-1">/</span>                                          
                                            <a href="newsDetails/${requestScope.lnews[0].slug}">${requestScope.listCreateBy[0].name}</a>
                                        </div>
                                        <h3 class="post-heading"><a href="newsDetails/${requestScope.lnews[0].slug}">${requestScope.lnews[0].title}</a></h3>
                                        <div style="height: 120px;  overflow: hidden" >
                                            <i>${requestScope.lnews[0].description}</i>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <c:forEach begin="${1}" end="${requestScope.lnews.size()-1}" var="i" step="${1}">
                                    <div class="post-entry-big horizontal d-flex mb-4 row">
                                        <div class="col-12 col-md-4">
                                            <a href="newsDetails/${requestScope.lnews[i].slug}" class="img-link">
                                                <img src="${requestScope.lnews[i].image}" alt="Image" class="img-fluid"/>
                                            </a>
                                        </div>
                                        <div class="col-12 col-md-8">
                                            <div class="post-content">
                                                <div class="post-meta">
                                                    <a href="newsDetails/${requestScope.lnews[i].slug}"><fmt:formatDate pattern="dd-MM-yyyy" value="${requestScope.lnews[i].createdDate}" /></a>
                                                    <span class="mx-1">/</span>
                                                    <a href="newsDetails/${requestScope.lnews[i].slug}">${requestScope.listCreateBy[i].name}</a>
                                                </div>
                                                <h3 class="post-heading"><a href="newsDetails/${requestScope.lnews[i].slug}">${requestScope.lnews[i].title}</a></h3>
                                                <div style="height: 120px;overflow: hidden" >
                                                    <i>${requestScope.lnews[i].description}</i>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                                        <c:if test="${isFollow == true}">
            <script>
                window.alert("${message}");
            </script>
        </c:if>
        <div class="site-section ftco-subscribe-1" style="background-image: url('images/home/bg_1.jpg')">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-7">
                        <h2><fmt:message key="home.SubcribeUs" /></h2>
                        <h1 style="color: #fff"><fmt:message key="home.FollowUs" /></h1>
                    </div>
                    <div class="col-lg-5">
                        <form action="followus" class="d-flex">
                            <input type="text" class="rounded form-control mr-2 py-3" placeholder="Email" name="email">
                            <button class="btn btn-primary rounded py-3 px-4" type="submit"><fmt:message key="home.Send" /></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>


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




        <script src="js/main.js"></script>

    </body>

</html>
