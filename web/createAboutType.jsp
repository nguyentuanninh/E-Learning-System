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

        <title>About-Type Creation</title>

        <!-- Custom fonts for this template -->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/sb-admin-2.min.css" rel="stylesheet">

        <!-- Custom styles for this page -->
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link href="css/mobiscroll.javascript.min.css" rel="stylesheet" />
        <script src="js/mobiscroll.javascript.min.js"></script>
        <script
            src="https://cdn.tiny.cloud/1/fb0gncsdhd40naw93pa7w44slm5a5dctuxn1ekv2kuyto7vy/tinymce/6/tinymce.min.js"
        referrerpolicy="origin"></script>

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
                        <h1 class="h3 mb-2 text-gray-800 pb-4">Create About Type</h1>
                        <form action="createAboutType" method="post">
                            <div class="row">
                                <div class="col-md-7">
                                    <div class="form-group row">
                                        <label for="Type"
                                               class="col-sm-2 col-form-label">Type</label>
                                        <div class="col-sm-10">
                                            <textarea class="form-control" id="Type" name="type"
                                                      rows="3" placeholder="News Type"
                                                      required></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="Type_VN"
                                               class="col-sm-2 col-form-label">Type VN</label>
                                        <div class="col-sm-10">
                                            <textarea class="form-control" id="Type_VN" name="type_vn"
                                                      rows="3" placeholder="News Type VN"
                                                      required></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-10">
                                            <button type="submit"
                                                    class="btn btn-primary">Create</button>
                                        </div>
                                    </div>

                                </div>
                                <!--                                                    <div class="col-md-5">
                                                                                        <label class="form-label" for="customFile">Upload image
                                                                                            cover</label>
                                                                                        <div
                                                                                            class="input-group mb-3 px-2 py-2 rounded-pill bg-white shadow-sm">
                                                                                            <input id="upload" type="file" onchange="readURL(this);"
                                                                                                accept="image/*" class="form-control border-0"
                                                                                                name="images" required>
                                                                                        </div>
                                                                                        <div class="image-area mt-4">
                                                                                            <img id="imageResult"
                                                                                                src="https://bootstrapious.com/i/snippets/sn-img-upload/image.svg"
                                                                                                alt=""
                                                                                                class="img-fluid rounded shadow-sm mx-auto d-block"
                                                                                                style="max-height: 350px">
                                                                                        </div>
                                
                                                                                    </div>-->
                            </div>
                        </form>
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
        <script src="js/demo/custom.js"></script>
        <script>/*  ==========================================
         SHOW UPLOADED IMAGE
         * ========================================== */
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#imageResult')
                                .attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }

            $(function () {
                $('#upload').on('change', function () {
                    readURL(input);
                });
            });

            /*  ==========================================
             SHOW UPLOADED IMAGE NAME
             * ========================================== */
            var input = document.getElementById('upload');
            var infoArea = document.getElementById('upload-label');

            input.addEventListener('change', showFileName);
            function showFileName(event) {
                var input = event.srcElement;
                var fileName = input.files[0].name;
                infoArea.textContent = 'File name: ' + fileName;
            }

            mobiscroll.select('#multiple-select', {
                inputElement: document.getElementById('my-input'),
                touchUi: false,
                filter: true
            });
        </script>

    </body>

</html>
