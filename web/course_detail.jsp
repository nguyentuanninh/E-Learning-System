<%-- 
    Document   : course_single.jsp
    Created on : May 14, 2023, 9:30:48 AM
    Author     : Admin
--%>

<%@page import="entity.Course"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty sessionScope.language ? sessionScope.language : ''}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="text" />

<!DOCTYPE html>
<html lang="en">

    <head>
        <title>${course.name}</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


        <%@include file="linkHead.jsp" %>
    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

        <div class="site-wrap">

            <%@include file="header.jsp" %>

            <div class="site-section ftco-subscribe-1 site-blocks-cover pb-4">
            </div> 


            <div class="custom-breadcrumns border-bottom">
                <div class="container">
                    <a href="/SWP391_Group3/home"><fmt:message key="header.Home" /></a>
                    <span class="mx-3 icon-keyboard_arrow_right"></span>
                    <a href="/SWP391_Group3/listcourse"><fmt:message key="header.course" /></a>
                    <span class="mx-3 icon-keyboard_arrow_right"></span>
                    <span class="current">${category.name}</span>
                </div>
            </div>

            <div class="site-section">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <h3 class="text-black mb-2">
                                <span>${course.name}</span>
                            </h3>
                            <br/>
                            <p>
                                <img src="${course.image}" alt="${course.name}" class="img-fluid" style="width: 500px">
                            </p>
                            <div>
                                <div class="row">
                                    <div class="col-6">
                                        <h3 id="course_lesson" class="section-title-underline mb-4" style="cursor: pointer">
                                            <span><fmt:message key="button.CourseLesson" /></a></span>
                                        </h3>
                                    </div>
                                    <div class="col-6">
                                        <h3 id="course_review" class="mb-4 " style="cursor: pointer">
                                            <span><fmt:message key="button.CourseReview" /></a></span>
                                        </h3>
                                    </div>
                                </div>

                                <div style="overflow-y: scroll; max-height: 400px">
                                    <div id="course_lesson_div">
                                        <div class="accordion" id="accordionExample">
                                            <c:forEach items="${lession}" var="i">
                                                <div class="card">
                                                    <div class="card-header" id="heading${i.id}">
                                                        <h2 class="mb-0">
                                                            <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse${i.id}" aria-expanded="true" aria-controls="collapse${i.id}">
                                                                ${i.title}
                                                            </button>
                                                        </h2>
                                                    </div>

                                                    <div id="collapse${i.id}" class="collapse" aria-labelledby="heading${i.id}" data-parent="#accordionExample">
                                                        <div class="card-body">
                                                            ${i.description}
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <!--commemt-->
                                    <div class=" col-md-12 disable_section" id="course_review_div">
                                        <div id="aaa">
                                            <c:forEach items="${courseReviews}" var="cr">
                                                <div class="acc media g-mb-30 media-comment">
                                                    <img class="d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15" src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Image Description">
                                                    <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
                                                        <div class="row">
                                                            <div class="col-6"><div class="g-mb-15">
                                                                    <h6 class="h6 g-color-gray-dark-v1 mb-0 text-black">${mapUser.get(cr.userId).name}</h6>
                                                                    <c:forEach begin="1" end="${cr.rating}">
                                                                        <i class="fa-sharp fa-solid fa-star fa-2xs" style="color: #51be78;"></i>
                                                                    </c:forEach>
                                                                </div></div>
                                                            <div class="col-6"><div class="g-mb-15" style="text-align: right">
                                                                    <span class="g-color-gray-dark-v4 g-font-size-12" >${cr.createdAt}</span>
                                                                </div></div>
                                                        </div>


                                                        <p>${cr.reviewText}</p>

                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>

                                        <div class="mt-3 text-center" >
                                            <button class="btn btn-sm btn-primary" onclick="loadMore()">Load More...</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5 ml-auto">
                            <h2 class="section-title-underline mb-4">
                                <span><fmt:message key="course.courseDetails" /></span>
                            </h2>
                            <h3><i class="fa-solid fa-money-check-dollar" style="color: #51be78;"></i>
                                <strong class="text-black"><fmt:message key="course.price" /> </strong>
                                <span class="text-black"><fmt:formatNumber value="${course.price}"/> VNĐ </span>
                            </h3>


                            <p class="mt-5">
                                <strong class="text-black" style="display: inline"> 
                                    <i class="fa-regular fa-user" style="color: #51be78; display: inline"></i>  <fmt:message key="header.Instructor" />
                                </strong>${instructor.name}</p>

                            <p><strong class="text-black">
                                    <i class="fa-sharp fa-solid fa-layer-group" style="color: #51be78;"></i> <fmt:message key="course.Level" /> 
                                </strong> ${level.name}</p>

                            <p><strong class="text-black">
                                    <i class="fa-sharp fa-solid fa-user-plus" style="color: #51be78;"></i> <fmt:message key="course.Enroll" /> 
                                </strong> ${enroll}</p>

                            <p><strong class="text-black d-block"><fmt:message key="course.Description" /></strong> ${course.description}</p>
                            <p><strong class="text-black d-block"><fmt:message key="course.Objective" /></strong>${course.objectives}</p>
                            <p>

                            <form action="/SWP391_Group3/courseenroll" method="post">
                                <input type="hidden" value="${requestScope.course.id}" name="courseid">
                                <input type="hidden" value="${requestScope.course.price}" name="price">

                                <c:choose>
                                    <c:when test="${sessionScope.account == null}">
                                        <a href="#" class="btn btn-primary rounded-0 btn-lg px-5" onclick="login()">Enroll</a>
                                    </c:when>
                                    <c:when test="${requestScope.isEnroll == false}">
                                        <c:if test="${sessionScope.account.amount < requestScope.course.price}">
                                            <a href="#" class="btn btn-primary rounded-0 btn-lg px-5" onclick="message()">Enroll</a>
                                        </c:if>
                                        <c:if test="${sessionScope.account.amount >= requestScope.course.price}">
                                            <input type="submit" class="btn btn-primary rounded-0 btn-lg px-5" value="Enroll">
                                        </c:if>
                                    </c:when>
                                    <c:when test="${requestScope.isEnroll == true}">
                                        <a href="/SWP391_Group3/learn/${course.slug}" class="btn btn-primary rounded-0 btn-lg px-5"><fmt:message key="course.Learn" /></a>
                                    </c:when>
                                </c:choose>
                            </form>
                            </p>

                        </div>
                    </div>
                </div>
            </div>

            <!--related courses-->
            <div class="site-section">
                <div class="container">
                    <div class="row mb-5 justify-content-center text-center">
                        <div class="col-lg-6 mb-5">
                            <h2 class="section-title-underline mb-3">
                                <span><fmt:message key="course.RelatedCourses" /></span>
                            </h2>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="owl-slide-3 owl-carousel">
                                <c:forEach items="${listcourse}" var="lc">
                                    <div class="course-1-item">
                                        <figure class="thumnail">
                                            <a href="course-single.jsp"><img src="${lc.image}" alt="Image" class="img-fluid" style="max-height: 180px"></a>
                                            <div class="price"><fmt:formatNumber value = "${lc.price}"/></div>
                                            <div class="category">
                                                <h3>${mapcategory.get(lc.category).name}</h3>
                                            </div>
                                        </figure>
                                        <div class="course-1-content pb-2">
                                            <h2 style="height: 60px">${lc.name}</h2>
                                            <p class="desc mb-4" style="height: 180px; overflow: hidden">${lc.description}</p>
                                            <p><a href="/SWP391_Group3/course/${lc.slug}" class="btn btn-primary rounded-0 px-4"><fmt:message key="button.Details" /></a></p>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>

                        </div>

                    </div>
                </div>
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
        <script>const course_lesson = document.getElementById('course_lesson');
                                                const course_review = document.getElementById('course_review');
                                                const course_lesson_div = document.getElementById('course_lesson_div');
                                                const course_review_div = document.getElementById('course_review_div');
                                                course_lesson.addEventListener('click', () => {
                                                    course_lesson.classList.add('section-title-underline');
                                                    course_review.classList.remove('section-title-underline');
                                                    course_lesson_div.classList.remove('disable_section');
                                                    course_review_div.classList.add('disable_section');
                                                });
                                                course_review.addEventListener('click', () => {
                                                    course_lesson.classList.remove('section-title-underline');
                                                    course_review.classList.add('section-title-underline');
                                                    course_lesson_div.classList.add('disable_section');
                                                    course_review_div.classList.remove('disable_section');
                                                });
                                                const message = () => {
                                                    if (confirm("Your account has insufficient funds!\n Please deposit money into your account") === true) {
                                                        window.location = "/SWP391_Group3/transaction";
                                                    }
                                                };
                                                const login = () => {
                                                    if (confirm("Please log on to the system") === true) {
                                                        window.location = "/SWP391_Group3/login.jsp";
                                                    }
                                                };
        </script>
        <script>function loadMore() {
                var a = ${course.id};
                console.log(a);
                var amount = document.getElementsByClassName("acc").length;
                $.ajax({
                    url: "/SWP391_Group3/loadMoreComment",
                    type: "get", //send it through get method
                    data: {
                        exits: amount,
                        courseid: a
                    },
                    success: function (response) {
                        var row = document.getElementById("aaa");
                        row.innerHTML += response;
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });
            }</script>
    </body>

</html>
