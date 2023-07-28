<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/SWP391_Group3/css/user-profile.css">
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="site-mobile-menu site-navbar-target">
    <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close mt-3">
            <span class="icon-close2 js-menu-toggle"></span>
        </div>
    </div>
    <div class="site-mobile-menu-body"></div>
</div>

<!--Contact-->
<div class="py-2 bg-light">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-7 d-none d-lg-block">
                <a href="#" class="small mr-3"><span class="icon-question-circle-o mr-2"></span><fmt:message key="header.Question"/></a>
                <a href="tel://" class="small mr-3"><span class="icon-phone2 mr-2"></span>
                    ${requestScope.pageinfo.children[0].content}</a>
                <a href="mailto://${requestScope.pageinfo.children[1].content}" class="small mr-3"><span class="icon-envelope-o mr-2"></span>
                    ${requestScope.pageinfo.children[1].content}</a>
            </div>

            <div class="col-lg-5 text-right">
                <div class="mr-3" style="display: inline">
                    <a href="/SWP391_Group3/language?value=vi_VN" type="Change langue">
                        <img src="/SWP391_Group3/images/home/vn.jpg" alt="Langue" width=45px"/>
                    </a>
                    <a href="/SWP391_Group3/language?value=en" type="Change langue">
                        <img src="/SWP391_Group3/images/home/en.jpg" alt="Langue" width=45px"/>
                    </a>
                </div>
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <a href="/SWP391_Group3/login.jsp" class="small mr-3"><span
                                class="icon-unlock-alt"></span><fmt:message key="header.Login" /></a>
                        <a href="/SWP391_Group3/register.jsp"
                           class="small btn btn-primary px-4 py-2 rounded-0"><span class="icon-users"></span>
                            <fmt:message key="header.Register" /></a>
                        </c:when>
                        <c:when test="${sessionScope.account != null}">
                        <div style="height: 30px; display: inline-block; position: relative;" class="profile">
                            <span>${sessionScope.account.name}</span>
                            <img class="avatar" style="height: 100%; border: 1px solid black;"
                                 src="/SWP391_Group3/images/account/icon.png" class="rounded-circle"
                                 alt="avt images"></a>
                            <ul class="userprofile">
                                <a href="/SWP391_Group3/userinformation">
                                    <li><fmt:message key="header.Profile" /></li>
                                </a>
                                <a href="/SWP391_Group3/transaction">
                                    <li><fmt:message key="header.Payment"/></li>
                                </a>
                                <a href="/SWP391_Group3/userlogout">
                                    <li><fmt:message key="header.LogOut"/></li>
                                </a>
                            </ul>
                        </div>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<!--End Contact-->

<!--Header-->
<header class="site-navbar py-4 js-sticky-header site-navbar-target" role="banner" style="position: relative">

    <div class="container">
        <div class="d-flex align-items-center">
            <div class="site-logo">
                <a href="${logo.href}" class="d-block">
                    <img src="${logo.image}" alt="Image" class="img-fluid">
                </a>
            </div>
            <div class="mr-auto">
                <nav class="site-navigation position-relative text-right" role="navigation">
                    <ul class="site-menu main-menu js-clone-nav mr-auto d-none d-xl-block">
                        <c:if test="${nav_header != null}">
                            <c:forEach items="${nav_header}" var="nh">
                                <li class="<c:if test="${nh.children!=null}">has-children</c:if>">
                                    <a href="<c:if test="${nh.href != null}">${nh.href}</c:if><c:if test="${nh.href == null}">#</c:if>" class="nav-link text-left">
                                        <c:if test="${language!='vi_VN'}">
                                            ${nh.name}
                                        </c:if>
                                         <c:if test="${language=='vi_VN'}">
                                            ${nh.name_vn}
                                        </c:if>
                                    </a>
                                    <c:if test="${nh.children != null}">
                                        <ul class="dropdown">
                                            <c:forEach items="${nh.children}" var="lca">
                                                <c:if test="${language=='vi_VN'}">
                                                    <li><a href="${lca.slug}">${lca.name_vn}</a></li>
                                                    </c:if>
                                                    <c:if test="${language!='vi_VN'}">
                                                    <li><a href="${lca.slug}">${lca.name}</a></li>
                                                    </c:if>
                                                </c:forEach>
                                        </ul>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>

                </nav>

            </div>
            <div class="ml-auto">
                <div class="social-wrap">
                    <div id="search">
                        <form action="/SWP391_Group3/searchcourse" method="GET">
                            <fmt:message key="header.Placeholder" var="placeholder"/>
                            <input type="text" placeholder="${placeholder}" class="pl-md-2" name="search">
                            <button type="button" style="border: 0; background-color: rgba(240, 248, 255, 0);"
                                    title="search">
                                <i class="ti-search"></i>
                            </button>
                        </form>
                    </div>
                    <a href="#"
                       class="d-inline-block d-xl-none site-menu-toggle js-menu-toggle text-black">
                        <span class="icon-menu h3" title="toggle"></span></a>
                </div>
            </div>

        </div>
    </div>
    <div class="progress-container mt-3" style="display: none" id="progess-news">
        <div class="progress-bar" id="myBar" >

        </div>
    </div>
</header>

