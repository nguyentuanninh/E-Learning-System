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
<style>
    .move{
        display: none;
    }
    #lesson{
        color: red;
    }
    .rate {
        float: left;
        height: 46px;
        padding: 0 10px;
    }

    .rate:not(:checked)>input {
        position: absolute;
        top: -9999px;
    }

    .rate:not(:checked)>label {
        float: right;
        width: 1em;
        overflow: hidden;
        white-space: nowrap;
        cursor: pointer;
        font-size: 30px;
        color: #ccc;
    }

    .rate:not(:checked)>label:before {
        content: '★ ';
    }

    .rate>input:checked~label {
        color: #51be78;
    }

    .rate:not(:checked)>label:hover,
    .rate:not(:checked)>label:hover~label {
        color: #51be78;
    }

    .rate>input:checked+label:hover,
    .rate>input:checked+label:hover~label,
    .rate>input:checked~label:hover,
    .rate>input:checked~label:hover~label,
    .rate>label:hover~input:checked~label {
        color: #51be78;
    }
</style>
<script>
    function reviewpart() {
        const content = document.querySelector("#contentpart");
        const co = document.querySelector("#lesson");
        const lsct = document.querySelector("#lesson_content");
        const review = document.querySelector("#reviewpart");
        const re = document.querySelector("#review");
        content.style.display = "none";
        lsct.style.display = "none";
        review.style.display = "block";
        re.style.color = "red";
        co.style.color = "black";
    }
    function contentpart() {
        const content = document.querySelector("#contentpart");
        const co = document.querySelector("#lesson");
        const lsct = document.querySelector("#lesson_content");
        const review = document.querySelector("#reviewpart");
        const re = document.querySelector("#review");
        content.style.display = "block";
        review.style.display = "none";
        lsct.style.display = "block";
        co.style.color = "red";
        re.style.color = "black";
    }
</script>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>${course.name}</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="/SWP391_Group3/css/custom.css" rel="stylesheet">
        <%@include file="linkHead.jsp" %>
        <script src="https://kit.fontawesome.com/81e4fcabce.js" crossorigin="anonymous"></script>

    </head>

    <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300" style="height: 100%; margin: 0">
        <div style="overflow-x: hidden">

            <header class="p-1 pr-2 pl-2 pr-md-5 pl-md-5 d-flex align-items-center justify-content-center" role="banner"
                    style="background-color: #183661; position: relative; height: 50px">
                <div class="mr-auto d-flex flex-row justify-content-center align-items-center">
                    <a class="text-white d-inline pr-4 btn btn-lg" title="Exit" href="/SWP391_Group3/course/${course.slug}" >
                        <i class="fa-solid fa-chevron-left fa-beat-fade"></i>
                    </a>                      
                    <h5 class="text-white font-weight-bold" style="margin-bottom: 0">${course.name} </h5>
                </div>
                <div class="site-logo d-none d-md-block">
                    <a href="/SWP391_Group3/home" class="d-block">
                        <img src="/SWP391_Group3/images/home/logo.png" alt="Image" style="transform: scale(0.9,0.9)" class="img-fluid">
                    </a>
                </div>
            </header>
            <!--Body-->
            <div class="row full" id="main" style="overflow-y: scroll;">
                <!-- Content -->
                <div class="col-md-9 div1 pt-3" 
                     style="overflow-y: scroll; position: fixed; bottom: 50px; margin-top: 50px; left: 0; top: 0">
                    <div class="container" id="contentpart" <c:if test="${requestScope.review == null}">style="display: block;"</c:if><c:if test="${requestScope.review != null}">style="display: none;"</c:if>>
                        <c:if test="${lesson.type== 'Docs'}">
                            <h1><strong class="text-black">${lesson.title}</strong></h1>
                            <p class="text-black">${lesson.description}<p>
                            <hr/><br/>
                            <span style="color: black;">${content.content}</span>
                        </c:if>
                        <c:if test="${lesson.type== 'Video'}">
                            <iframe style=" width: 100%;height: calc(9 / 16 * 100vw*9/12);" src="${content.videoLink}" 
                                    title="YouTube video player" frameborder="0" 
                                    id="url-preview" allowfullscreen >
                            </iframe>  
                            <hr/><br/>
                            <h3><strong class="text-black">${lesson.title}</strong></h3>
                            <p class="text-black">${lesson.description}<p>
                            </c:if>
                            <c:if test="${lesson.type== 'File'}">
                                <embed src="${content.file_name}" type="application/pdf" width="100%" height="600px" />
                                <a href="${content.file_name}" download><fmt:message key="button.DownloadFile" /></a> 
                            <hr/><br/>
                            <h3><strong class="text-black">${lesson.title}</strong></h3>
                            <p class="text-black">${lesson.description}<p>
                            </c:if>
                    </div>
                    <div class="col-md-12 disable_section" id="reviewpart"  <c:if test="${requestScope.review == null}">style="display: none;"</c:if><c:if test="${requestScope.review != null}">style="display: block;"</c:if>>
                            <form action="/SWP391_Group3/reviewcourse">
                                <div class="form-group rate">
                                    <input type="radio" id="star5" name="rate" value="5" />
                                    <label for="star5" title="text">5 stars</label>
                                    <input type="radio" id="star4" name="rate" value="4" />
                                    <label for="star4" title="text">4 stars</label>
                                    <input type="radio" id="star3" name="rate" value="3" />
                                    <label for="star3" title="text">3 stars</label>
                                    <input type="radio" id="star2" name="rate" value="2" />
                                    <label for="star2" title="text">2 stars</label>
                                    <input type="radio" id="star1" name="rate" value="1" checked/>
                                    <label for="star1" title="text" >1 star</label>
                                </div>
                                <div class="form-group">
                                        <input type="hidden" value="${course.id}" name="course_id"/>
                                <input type="hidden" value="${course.slug}" name="course_slug"/>
                                <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="cmt"></textarea>
                            </div>
                            <button class="btn btn-success">COMMENT</button>
                        </form>
                        <c:forEach items="${courseReviews}" var="cr">
                            <div class="media g-mb-30 media-comment">
                                <img class="d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15" src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Image Description">
                                <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
                                    <div class="row">
                                        <div class="col-6"><div class="g-mb-15">
                                                <h6 class="h6 g-color-gray-dark-v1 mb-0 text-black">${mapUser.get(cr.userId).name}</h6>
                                                <div>
                                                    <p style="padding-top: 7px">
                                                        <c:forEach begin="1" end="${cr.rating}">
                                                            <i class="fa-sharp fa-solid fa-star fa-2xs" style="color: #51be78;"></i>
                                                        </c:forEach>
                                                    </p>
                                                </div>
                                            </div></div>
                                        <div class="col-6"><div class="g-mb-15" style="text-align: right">
                                                <span class="g-color-gray-dark-v4 g-font-size-12" >${cr.createdAt}</span>
                                            </div></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-11">
                                            <p>${cr.reviewText}</p>
                                        </div>
                                        <c:if test="${sessionScope.account.id == cr.userId}">
                                            <div class="col-1">
                                                <a href="/SWP391_Group3/deletereview?id=${cr.id}&slug=${course.slug}"><i class="ti-trash"></i></a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-md-3 div2" 
                     style="padding: 0; z-index: 1;border-left:1px solid #dedfe0;
                     position: fixed; bottom: 50px; margin-top: 50px; right: 0; top: 0; overflow-y: scroll; overflow-x: hidden">
                    <header class="pt-2 pb-2 pl-3" style="font-weight: 600; font-size: 1rem; color: black; border: 1px solid #dedfe0; background-color: white; position: sticky; top: 0">
                        <div class="row">
                            <div class="col-md-6" style="cursor: pointer" onclick="contentpart()"><p class="mb-0" id="lesson"><fmt:message key="button.CourseLesson" /></p></div>
                            <div class="col-md-6" style="cursor: pointer" onclick="reviewpart()"><p class="mb-0" id="review"><fmt:message key="button.CourseReview" /></p></div>
                        </div>
                    </header>
                    <div id="lesson_content">
                        <ul class="list-group list-group-light">
                            <%int i= 1;%>
                            <c:forEach items="${listLesson}" var="l" >
                                <a href="${request.getRealPath("/")}?id=<%=i%>" 
                                   style="border: 1px solid #dedfe0;">
                                    <li class="text-black" 
                                        style="background-color: #f7f8fa; padding: 8px 0 8px 10px;font-weight: 500; font-size: 1rem; color: black;">
                                        <strong><%=i%>.</strong> ${l.title}
                                        <%i++;%>
                                    </li>
                                </a>
                            </c:forEach>
                        </ul>
                    </div>
                    <div id="review_contetn">
                        <ul class="list-group list-group-light">

                        </ul>
                    </div>  

                </div>
            </div>
            <!--Footer-->
            <div class="m-0 d-flex align-items-center nowrap row p-2" 
                 style="background-color: #f0f0f0; box-shadow: 0 -2px 3px rgba(0,0,0,.1); z-index: 3;
                 height: 50px; position: fixed; bottom: 0; left: 0; right:0
                 ">
                <!-- Footer with buttons -->
                <div class="text-right col-10 col-sm-7">
                    <c:if test="${param.id== 1}">
                        <button type="button" class="btn btn-outline-primary mr-2" disabled >
                            <i class="fa-solid fa-chevron-left fa-beat-fade"></i>
                            <fmt:message key="button.Previous" />
                        </button>
                    </c:if>
                    <c:if test="${param.id> 1}">
                        <a type="button" class="btn btn-outline-primary mr-2" href="${request.getRealPath("/")}?id=${param.id - 1}">
                            <i class="fa-solid fa-chevron-left fa-beat-fade"></i>
                            <fmt:message key="button.Previous" /> 
                        </a>
                    </c:if>

                    <c:if test="${param.id >= listLesson.size()}">
                        <button type="button" class="btn btn-outline-primary ml-2" disabled="">             
                            <fmt:message key="button.Next" />
                            <i class="fa-solid fa-chevron-right"></i>
                        </button>
                    </c:if>
                    <c:if test="${param.id < listLesson.size()}">
                        <a type="button" class="btn btn-outline-primary ml-2" href="${request.getRealPath("/")}?id=${param.id + 1}">             
                            <fmt:message key="button.Next" />
                            <i class="fa-solid fa-chevron-right"></i>
                        </a>
                    </c:if>

                    <c:if test="${param.id == null}">
                        <button type="button" class="btn btn-outline-primary mr-2" disabled >
                            <i class="fa-solid fa-chevron-left fa-beat-fade"></i>
                            <fmt:message key="button.Previous" />
                        </button>
                    </c:if>
                    <c:if test="${param.id == null}">
                        <a type="button" class="btn btn-outline-primary ml-2" href="${request.getRealPath("/")}?id=2">             
                            <fmt:message key="button.Next" />
                            <i class="fa-solid fa-chevron-right"></i>
                        </a>
                    </c:if>

                </div>
                <div class="col-2 col-sm-5 text-right pr-2">
                    <button class="btn btn-primary " onclick="btntog()">
                        <i class="fa-solid fa-bars"></i>
                    </button>
                </div>

            </div>
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
        <script>
                        const main = document.getElementById("main");
                        const div1 = document.getElementById("main").getElementsByClassName("div1")[0];
                        const div2 = document.getElementById("main").getElementsByClassName("div2")[0];
                        function btntog() {
                            div1.classList.toggle("col-md-12");
                            div2.classList.toggle("move");
                        }
        </script>

    </body>

</html>
