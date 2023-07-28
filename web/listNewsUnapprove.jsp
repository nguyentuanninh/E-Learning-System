<%-- Document : adminCourseManage Created on : May 16, 2023, 5:26:30 PM Author : MSII --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
              rel="stylesheet" />
        <link href=".//SWP391_Group3/style/styles.css" rel="stylesheet" />
        <link href=".//SWP391_Group3/style/userStyle.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"
        crossorigin="anonymous"></script>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
              rel="stylesheet">
        <title>News Unapproved Management</title>

        <!-- Custom fonts for this template -->
        <link href="/SWP391_Group3/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
              type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="/SWP391_Group3/css/sb-admin-2.min.css" rel="stylesheet">

        <!-- Custom styles for this page -->
        <link href="/SWP391_Group3/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <style>
            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 34px;
            }

            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                -webkit-transition: .4s;
                transition: .4s;
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                -webkit-transition: .4s;
                transition: .4s;
            }

            #switch:checked+.slider {
                background-color: #4e73df;
            }

            #switch:focus+.slider {
                box-shadow: 0 0 1px #4e73df;
            }

            #switch:checked+.slider:before {
                -webkit-transform: translateX(26px);
                -ms-transform: translateX(26px);
                transform: translateX(26px);
            }

            /* Rounded sliders */
            .slider.round {
                border-radius: 34px;
            }

            .slider.round:before {
                border-radius: 50%;
            }
        </style>
    </head>

    <body id="page-top">

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <c:if test="${sessionScope.adminaccount.type_id != 1}">
                <%@include file="employeeSidebar.jsp" %>
            </c:if>
            <c:if test="${sessionScope.adminaccount.type_id == 1}">
                <%@include file="adminSidebar.jsp" %>
            </c:if>

            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <%@include file="topBar.jsp" %>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <!-- Page Heading -->
                        <h1 class="h3 mb-2 text-gray-800">News Management</h1>

                        <!-- DataTales Example -->
                        <div class="card shadow mb-4">
                            
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table bg-white table-bordered">
                                        <div
                                            class="card-header py-3 d-flex flex-column flex-md-row justify-content-between align-items-center">
                                            <h6 class="m-0 font-weight-bold text-primary">News Unapproved
                                                Management </h6>
                                            <div
                                                style="display: flex; flex-direction: row; align-items: center;">

                                                <form action="listNewsUnapprove" method="get">
                                                    <div class="input-group" >                         
                                                        <input type="search" name="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon" required/>
                                                        <button type="submit" class="btn btn-outline-primary">search</button>
                                                    </div>
                                                </form>
                                                <a href="createNews" type="button"
                                                   class="btn btn-primary ml-4"
                                                   style=" white-space: nowrap;">Create News</a>
                                            </div>
                                            <div>
                                                <div style="height: 100%">
                                                    <p style="margin-right: 20px">Send Email:</p>
                                                </div>
                                                <label class="switch">
                                                    <input type="checkbox" <c:if test="${isSendEmail != false}">checked=""</c:if> onclick="isSendEmail()" id="switch" value="1">
                                                    <span class="slider round"></span>
                                                </label>
                                            </div>
                                        </div>
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th>Create Date</th>
                                                <th>Modified Date</th>
                                                <th>Create By</th>
                                                <th>Modified By</th>
                                                <th>Approve Date</th>
                                                <th>Controls</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if
                                                test="${requestScope.news.size()!= 0}">
                                                <c:forEach begin="${0}"
                                                           end="${requestScope.news.size() - 1}"
                                                           var="i" step="${1}">
                                                    <tr>
                                                        <td>${requestScope.news[i].title}
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate pattern="dd-MM-yyyy"
                                                                            value="${requestScope.news[i].createdDate}" />
                                                        </td>
                                                        <c:if
                                                            test="${requestScope.news[i].modifiedDate != null}">
                                                            <td>
                                                                <fmt:formatDate pattern="dd-MM-yyyy"
                                                                                value="${requestScope.news[i].modifiedDate}" />
                                                            </td>
                                                        </c:if>
                                                        <c:if
                                                            test="${requestScope.news[i].modifiedDate == null}">
                                                            <td>No have update yet!</td>
                                                        </c:if>
                                                        <td>${requestScope.listCreateBy[i].name}
                                                        </td>
                                                        <td>${requestScope.news[i].modifiedBy}
                                                        </td>
                                                        <c:if
                                                            test="${requestScope.news[i].approveDate == null}">
                                                            <td>Processing</td>
                                                        </c:if>
                                                        <c:if
                                                            test="${requestScope.news[i].approveDate != null}">
                                                            <td>
                                                                <fmt:formatDate pattern="dd-MM-yyyy"
                                                                                value="${requestScope.news[i].approveDate}" />
                                                            </td>
                                                        </c:if>

                                                        </td>
                                                        <td style="width: 13%;">
                                                            <a href="viewNews?id=${requestScope.news[i].id}"
                                                               class="table-link"
                                                               style="text-decoration: none;"
                                                               title="View News">
                                                                <span class="btn btn-primary btn-sm btn-circle">
                                                                    <i class="fa-solid fa-eye"></i>
                                                                </span>
                                                            </a>
                                                            <form
                                                                action="listNewsUnapprove?id=${requestScope.news[i].id}&Accept='true'"
                                                                method="post" class="d-inline">
                                                                <input type="hidden" name="changevalue" class="changevalue" <c:if test="${isSendEmail == false}">value="0"</c:if> <c:if test="${isSendEmail != false}">value="1"</c:if>/>
                                                                <button type="submit"
                                                                        class="btn btn-success btn-sm btn-circle border-0"
                                                                        title="Accept">
                                                                    <i
                                                                        class="fa-sharp fa-solid fa-circle-check"></i>
                                                                </button>
                                                            </form>
                                                            <form
                                                                action="listNewsUnapprove?id=${requestScope.news[i].id}&Reject='true'"
                                                                method="post" class="d-inline">
                                                                <button type="submit"
                                                                        class="btn btn-danger btn-sm btn-circle border-0"
                                                                        title="Reject">
                                                                    <i
                                                                        class="fa-solid fa-circle-xmark"></i>
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                        </tbody>
                                    </table>
                                    <c:if test="${numberOfPage >1}">
                                        <nav class="me-3">
                                            <ul
                                                class="pagination pagination-sm justify-content-end">
                                                <c:forEach begin="1" end="${numberOfPage}" var="i">
                                                    <c:if test="${i== page}">
                                                        <li class="page-item active"
                                                            aria-current="page">
                                                            <c:if test="${param.search== null}">
                                                                <a class="page-link"
                                                                   href="listNewsUnapprove?page=${i}">${i}</a>
                                                            </c:if>
                                                            <c:if test="${param.search!= null}">
                                                                <a class="page-link"
                                                                   href="listNewsUnapprove?search=${param.search}&page=${i}">${i}</a>
                                                            </c:if>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${i!= page}">
                                                        <li class="page-item">
                                                            <c:if test="${param.search== null}">
                                                                <a class="page-link"
                                                                   href="listNewsUnapprove?page=${i}">${i}</a>
                                                            </c:if>
                                                            <c:if test="${param.search!= null}">
                                                                <a class="page-link"
                                                                   href="listNewsUnapprove?search=${param.search}&page=${i}">${i}</a>
                                                            </c:if> 
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </nav>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.container-fluid -->

                </div>

                <!-- Footer -->
                <footer class="sticky-footer bg-white">
                    <div class="container my-auto">
                        <div class="copyright text-center my-auto">
                            <span>Copyright &copy; Your Website 2020</span>
                        </div>
                    </div>
                </footer>
                <!-- End of Footer -->

            </div>
            <!-- End of Content Wrapper -->

        </div>
        <!-- End of Page Wrapper -->

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>

        <!-- Logout Modal-->
        <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
             aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">Select "Logout" below if you are ready to end your current
                        session.</div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                        <a class="btn btn-primary" href="adminlogout">Logout</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap core JavaScript-->
        <script src="/SWP391_Group3/vendor/jquery/jquery.min.js"></script>
        <script src="/SWP391_Group3/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="/SWP391_Group3/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="/SWP391_Group3/js/sb-admin-2.min.js"></script>

        <!-- Page level plugins -->
        <script src="/SWP391_Group3/vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="/SWP391_Group3/vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <!-- Page level custom scripts -->
        <script src="/SWP391_Group3/js/demo/datatables-demo.js"></script>
        <script src="/SWP391_Group3/js/sendemail.js"></script>
        
    </body>

</html>
