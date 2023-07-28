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

        <title>Payment Fail</title>

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
                        <h1 class="h3 mb-2 text-gray-800">Payment</h1>

                        <table class="table bg-white table-bordered">
                            <div
                                class="card-header py-3 d-flex flex-column flex-md-row justify-content-between align-items-center">
                                <h6 class="m-0 font-weight-bold text-primary">List Error Recharge</h6>
                            </div>
                            <thead>
                                <tr>
                                    <th>Recharge Date</th>
                                    <th>Amount</th>
                                    <th>Description</th>
                                    <th>Bank</th>
                                    <th colspan="2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listRecharge}" var="c">
                                    <tr style="${c.status== "Error"? "color: red":"color: green"}">
                                        <td>
                                            <fmt:formatDate value="${c.rechargeDate}" pattern="HH:mm:ss dd-MM-yyyy" />
                                        </td>
                                        <td><fmt:formatNumber value="${c.amout}"/> VNĐ</td>
                                        <td>${c.description}</td>
                                        <td>${c.bankAccount}</td>

                                        <td style="position: relative">
                                            <a style="z-index: 1" class="btn btn-success" data-toggle="collapse" href="#collapseExample${c.id}" role="button" aria-expanded="false" aria-controls="collapseExample${c.id}">
                                                Update
                                            </a>
                                            <div class="collapse" id="collapseExample${c.id}" style="position: absolute;left: -10px ;padding: 3px; z-index: 2; background-color: white; border: 1px solid black; border-radius: 5px">
                                                <form
                                                    action="updatePayment?id=${c.id}&edit='true'"
                                                    method="POST" style="${c.status== "Error"? "display:inline":"display: none"}">
                                                    <input type="text" name="username" placeholder="Enter Username" class="mb-2"/>
                                                    <button type="submit"
                                                            class="btn btn-primary btn-sm border-0"
                                                            title="Update Recharge">
                                                        Submit
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                        <td>
                                            <form
                                                action="updatePayment?id=${c.id}&delete='true'"
                                                method="POST" style="${c.status== "Error"? "display:inline":"display: none"}">
                                                <button type="submit"
                                                        class="btn btn-danger btn-sm border-0"
                                                        title="Delete Recharge"
                                                        onclick="return confirm('Are you sure delete this Recharge');"
                                                        >
                                                    Delete
                                                </button>
                                            </form>
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
                                                <a class="page-link"
                                                   href="adminPaymentError?page=${i}">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${i!= page}">
                                            <li class="page-item"><a class="page-link"
                                                                     href="adminPaymentError?page=${i}">${i}</a>
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
        <script>
                                                            if (${ param.error != null }) {
                                                                alert("Can't find this Username, Please check back");
                                                            }
        </script>
    </body>

</html>
