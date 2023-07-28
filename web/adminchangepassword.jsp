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

        <title>Change Password</title>

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
                        <h1 class="h3 mb-2 text-gray-800">Admin Change Password</h1>
                        <div class="col-md-9 main">
                            <ul style="font-size: 12px">
                                    <li>The length of the password must be between 6-20 characters</li>
                                    <li>Must contain at least 1 numeric character from 0 to 9</li>
                                    <li>Must contain at least 1 uppercase character</li>
                                    <li>Must contain at least 1 lowercase character</li>
                                    <li>Must contain at least 1 character in the character set "@#$%!"</li>
                                </ul>
                                <form action="adminchangepassword" method="POST" class="form_user" onsubmit="return checkValidate()">
                                    <div class="form-group" style="position: relative;">
                                        <label for="username">Password:</label>
                                        <p style="color: red" id="pword_err">${requestScope.pword_err}</p>
                                        <input type="password" class="form-control" id="pword" placeholder="Enter password"
                                               name="password">
                                        <i class="ti-eye" style="position: absolute; bottom: 12px; right: 30px" onclick="viewpassword(1)"></i>
                                    </div>
                                    <div class="form-group" style="position: relative;">
                                        <label for="pwd">Enter new password:</label>
                                        <p style="color: red" id="newpword_err">${requestScope.newpword_err}</p>
                                        <input type="password" class="form-control" id="newpword" placeholder="Enter new password"
                                               name="newpword">
                                        <i class="ti-eye" style="position: absolute; bottom: 12px; right: 30px" onclick="viewpassword(2)"></i>
                                    </div>
                                    <div class="form-group" style="position: relative;">
                                        <label for="pwd">Confirm your password:</label>
                                        <p style="color: red" id="repword_err">${requestScope.repword_err}</p>
                                        <input type="password" class="form-control" id="repword" placeholder="Confirm your password"
                                               name="repword">
                                        <i class="ti-eye" style="position: absolute; bottom: 12px; right: 30px" onclick="viewpassword(3)"></i>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Save</button>
                                </form>
                        </div>

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
        <script src="js/register.js"></script>
        <script src="js/changepasswordinprofile.js"></script>
    </body>

</html>
