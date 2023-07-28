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

        <title>Course Management</title>

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

    </head>

    <body id="page-top">

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <c:if test="${sessionScope.adminaccount.type_id== 2}">
                <%@include file="employeeSidebar.jsp" %>
            </c:if>
            <c:if test="${sessionScope.adminaccount.type_id== 1}">
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
                        <h1 class="h3 mb-2 text-gray-800">Course Management</h1>

                        <table class="table bg-white table-bordered">
                            <div
                                class="card-header py-3 d-flex flex-column flex-md-row justify-content-between align-items-center">
                                <h6 class="m-0 font-weight-bold text-primary">List Course</h6>
                                <div
                                    style="display: flex; flex-direction: row; align-items: center;">
                                    <form action="admin-course-manage" method="get">
                                        <div class="input-group" >                         
                                            <input type="search" name="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon" required=""/>
                                            <button type="submit" class="btn btn-outline-primary">search</button>
                                        </div>
                                    </form>
                                    <a href="createCourse" type="button"
                                       class="btn btn-primary ml-4"
                                       style=" white-space: nowrap;">Create</a>
                                </div>

                            </div>
                            <thead>
                                <tr>
                                    <th>Course Name</th>
                                    <th>Author</th>
                                    <th>Date Create</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Status</th>
                                    <th style="width: 13%">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${courses}" var="c">
                                    <tr>
                                        <td>
                                            <a href="addLesson?id=${c.id}"
                                               title="View Lesson">
                                                ${c.name}
                                            </a>
                                        </td>
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
                                        <c:if test="${!c.disabled}">
                                            <td class="text-success">Enable</td>
                                        </c:if>
                                        <c:if test="${c.disabled}">
                                            <td class="text-danger">Disable</td>
                                        </c:if>
                                        <c:if test="${!c.disabled}">
                                            <td>
                                                <form
                                                    action="admin-course-manage?courseID=${c.id}&Disabled='true'"
                                                    method="POST" class="d-inline">
                                                    <button type="submit"
                                                            class="btn btn-danger btn-sm btn-circle border-0"
                                                            title="Disable">
                                                        <i class="fa-solid fa-circle-xmark"></i>
                                                    </button>
                                                </form>
                                                <a href="updateCourse?courseID=${c.id}"
                                                   class="btn btn-primary btn-sm btn-circle"
                                                   title="Edit">
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                </a>
                                                <a href="adminComment?courseId=${c.id}"
                                                   class="btn btn-primary btn-sm btn-circle"
                                                   title="View Comment">
                                                    <i class="fa-solid fa-comment"></i>
                                                </a>

                                            </td>
                                        </c:if>
                                        <c:if test="${c.disabled}">
                                            <td>
                                                <form
                                                    action="admin-course-manage?courseID=${c.id}&Enabled='true'"
                                                    method="POST" class="d-inline">
                                                    <button type="submit"
                                                            class="btn btn-success btn-sm btn-circle border-0"
                                                            title="Enable">
                                                        <i
                                                            class="fa-sharp fa-solid fa-circle-check"></i>
                                                    </button>
                                                </form>
                                                <a href="updateCourse?courseID=${c.id}"
                                                   class="btn btn-primary btn-sm btn-circle"
                                                   title="Edit">
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                </a>
                                                <a href="viewComment?id=${c.id}"
                                                   class="btn btn-primary btn-sm btn-circle"
                                                   title="View Comment">
                                                    <i class="fa-solid fa-comment"></i>
                                                </a>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${numberOfPage >1}">
                            <nav class="me-3">
                                <ul class="pagination pagination-sm justify-content-end">
                                    <c:forEach begin="1" end="${numberOfPage}" var="i">
                                        <c:if test="${i== page}">
                                            <li class="page-item active" aria-current="page">
                                                <c:if test="${param.search== null}">
                                                    <a class="page-link"
                                                       href="admin-course-manage?page=${i}">${i}</a>
                                                </c:if>
                                                <c:if test="${param.search!= null}">
                                                    <a class="page-link"
                                                       href="admin-course-manage?search=${param.search}&page=${i}">${i}</a>
                                                </c:if>

                                            </li>
                                        </c:if>
                                        <c:if test="${i!= page}">
                                            <li class="page-item">
                                                <c:if test="${param.search== null}">
                                                    <a class="page-link"
                                                       href="admin-course-manage?page=${i}">${i}</a>
                                                </c:if>
                                                <c:if test="${param.search!= null}">
                                                    <a class="page-link"
                                                       href="admin-course-manage?search=${param.search}&page=${i}">${i}</a>
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

    </body>

</html>
