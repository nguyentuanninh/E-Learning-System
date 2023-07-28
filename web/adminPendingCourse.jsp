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

        <title>Pending Course</title>

        <!-- Custom fonts for this template -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/sb-admin-2.min.css" rel="stylesheet">

        <!-- Custom styles for this page -->
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/81e4fcabce.js" crossorigin="anonymous"></script>
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
            <%@include file="adminSidebar.jsp" %>
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
                        <h1 class="h3 mb-2 text-gray-800">Course Management</h1>

                        <table class="table bg-white table-bordered">
                            <div
                                class="card-header py-3 d-flex flex-column flex-md-row justify-content-between align-items-center">
                                <h6 class="m-0 font-weight-bold text-primary">List Pending Course</h6>
                                <div
                                    style="display: flex; flex-direction: row; align-items: center;">
                                    <form action="admin-pending-course" method="get">
                                        <div class="input-group" >                         
                                            <input type="search" name="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon" required=""/>
                                            <button type="submit" class="btn btn-outline-primary">search</button>
                                        </div>
                                    </form>
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
                                        <th>instructor Name</th>
                                        <th>Author</th>
                                        <th>Date Create</th>
                                        <th>Category</th>
                                        <th>Price</th>
                                        <th style="width: 15%">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${pendingCourses}" var="c">
                                    <tr>
                                        <td><a href="addLesson?id=${c.id}"
                                               title="View Lesson">
                                                ${c.name}
                                            </a></td>
                                        <td>
                                            <c:forEach items="${mapInstructor.get(c.id)}" var="i"
                                                       varStatus="loop">
                                                <c:if test="${!loop.last}">
                                                    ${i.name},
                                                </c:if>
                                                <c:if test="${loop.last}">
                                                    ${i.name}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <fmt:formatDate pattern="dd-MM-yyyy"
                                                            value="${c.createdAt}" />
                                        </td>
                                        <td>${mapcategory.get(c.category).name}</td>
                                        <td>${c.price}</td>

                                        <td>
                                            <form
                                                action="admin-pending-course?courseID=${c.id}&Accept='true'"
                                                method="POST" class="d-inline">
                                                <input type="hidden" name="changevalue" class="changevalue" <c:if test="${isSendEmail == false}">value="0"</c:if> <c:if test="${isSendEmail != false}">value="1"</c:if>/>
                                                    <button type="submit"
                                                            class="btn btn-success btn-sm btn-circle border-0"
                                                            title="Accept">
                                                        <i
                                                            class="fa-sharp fa-solid fa-circle-check"></i>
                                                    </button>
                                                </form>
                                                <form
                                                        action="admin-pending-course?courseID=${c.id}&Reject='true'"
                                                method="POST" class="d-inline">
                                                <button type="submit"
                                                        class="btn btn-danger btn-sm btn-circle border-0"
                                                        title="Reject">
                                                    <i class="fa-solid fa-circle-xmark"></i>
                                                </button>
                                            </form>
                                            <a href="updateCourse?courseID=${c.id}"
                                               class="btn btn-primary btn-sm btn-circle"
                                               title="Edit">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <!--Phân trang-->
                        <c:if test="${numberOfPage >1}">
                            <nav class="me-3">
                                <ul class="pagination pagination-sm justify-content-end">
                                    <c:forEach begin="1" end="${numberOfPage}" var="i">
                                        <c:if test="${i== page}">
                                            <li class="page-item active" aria-current="page">
                                                <c:if test="${param.search== null}">
                                                    <a class="page-link"
                                                       href="admin-pending-course?page=${i}">${i}</a>
                                                </c:if>
                                                <c:if test="${param.search!= null}">
                                                    <a class="page-link"
                                                       href="admin-pending-course?search=${param.search}&page=${i}">${i}</a>
                                                </c:if>
                                            </li>
                                        </c:if>
                                        <c:if test="${i!= page}">
                                            <li class="page-item">
                                                <c:if test="${param.search== null}">
                                                    <a class="page-link"
                                                       href="admin-pending-course?page=${i}">${i}</a>
                                                </c:if>
                                                <c:if test="${param.search!= null}">
                                                    <a class="page-link"
                                                       href="admin-pending-course?search=${param.search}&page=${i}">${i}</a>
                                                </c:if>
                                            </li>
                                        </c:if>

                                    </c:forEach>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->

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
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="js/sb-admin-2.min.js"></script>

        <!-- Page level plugins -->
        <script src="vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

        <!-- Page level custom scripts -->
        <script src="js/demo/datatables-demo.js"></script>
        <script src="/SWP391_Group3/js/sendemail.js"></script>

    </body>

</html>
