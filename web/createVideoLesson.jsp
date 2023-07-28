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

                    <title>Video Lesson Creation</title>

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
                    <script src="https://kit.fontawesome.com/81e4fcabce.js" crossorigin="anonymous"></script>
                    <script
                        src="https://cdn.tiny.cloud/1/fb0gncsdhd40naw93pa7w44slm5a5dctuxn1ekv2kuyto7vy/tinymce/6/tinymce.min.js"
                        referrerpolicy="origin"></script>
                    <script>
                        tinymce.init({
                            selector: '#exampleFormControlTextarea2'
                        });
                    </script>
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
                                            <h1 class="h3 mb-2 text-gray-800 pb-4">Create Video Lesson</h1>
                                            <form action="createLesson" method="POST">
                                                <input type="hidden" name="courseId" value="${courseId}" />
                                                <input type="hidden" name="lessonId" value="${lesson.id}" />
                                                <input type="hidden" name="video" value="true" />
                                                <!-- Page Heading -->
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="exampleFormControlInput1">Lesson Title</label>
                                                            <input type="text" name="title" class="form-control"
                                                                id="exampleFormControlInput1" value="${lesson.title}">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleFormControlTextarea2">Lesson
                                                                Description</label>
                                                            <input type="text" name="description" class="form-control"
                                                                id="exampleFormControlInput2"
                                                                value="${lesson.description}">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleFormControlTextarea3">Video Name</label>
                                                            <input type="text" name="name" class="form-control"
                                                                id="exampleFormControlInput3"
                                                                value="${video.videoName}">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="VideoLink">Video Link</label>
                                                            <input type="text" class="form-control" id="video-url"
                                                                oninput="video_preview()" value="${view.videoLink}">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div
                                                            style="border: 1px dashed black;height: 100%;display: flex;align-items: center;justify-content: center;">
                                                            <iframe width="100%" height="100%" src=""
                                                                title="YouTube video player" frameborder="0"
                                                                id="url-preview" style="display: none">
                                                            </iframe>
                                                            <i class="fa-brands fa-youtube icon-youtube"
                                                                style="color: red; transform: scale(3,3)"></i>
                                                            <input name="video_url" type="hidden"
                                                                value="${view.videoLink}" id="video-URL">
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="submit" class="btn btn-primary">Save Change</button>

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
                    <script>function video_preview() {
                            let video_url = $('#video-url').val();
                            let video_id = youtube_parser(video_url);
                            $('#url-preview').attr('src', 'https://www.youtube.com/embed/' + video_id);
                            $('#url-preview').css('display', 'block');
                            $('.icon-youtube').css('display', 'none');
                            $('#video-URL').val($('#url-preview').attr('src'));
                        }

                        function youtube_parser(url) {
                            var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
                            var match = url.match(regExp);
                            return (match && match[7].length === 11) ? match[7] : false;
                        }</script>

                </body>

                </html>
