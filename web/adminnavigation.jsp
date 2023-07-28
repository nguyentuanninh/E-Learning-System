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

        <title>Navigation Management</title>

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

            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">

                    <%@include file="topBar.jsp" %>

                    <div class="container-fluid">


                        <h1 class="h3 mb-2 text-gray-800">Navigation Management</h1>
                        <%
                            int headerindex = 0;
                            int footerindex = 0;
                        %>

                        <div id="accordion">

                            <div class="card" >
                                <div class="card-header" style="display: flex; justify-content: space-between">
                                    <a class="card-link" data-toggle="collapse" href="#header">
                                        Header
                                    </a>
                                    <a href="#" title="create" onclick="checkAdd(1, ${nav_header.size()}, 'Header', 1)"><i class="fa-solid fa-plus"></i></a>
                                </div>
                                <div id="header" class="collapse show" data-parent="#accordion">
                                    <div class="card-body">
                                        <div id="headeritem">
                                            <c:forEach items="${nav_header}" var="nh">
                                                <div class="card">
                                                    <div class="card-header" style="display: flex; justify-content: space-between">
                                                        <a class="card-link" data-toggle="collapse" href="#headerItem${nh.id}">
                                                            ${nh.name}
                                                            <%headerindex++;%>
                                                        </a>
                                                        <div>
                                                            <a href="#" title="create" onclick="checkAdd(2, ${nav_footer.size()}, '${nh.name}', ${nh.id})"><i class="fa-solid fa-plus"></i></a>
                                                            <a href="edit-navigation?parent_id=header&id=${nh.id}"><i class="fa-solid fa-pen-to-square" title="edit"></i></a>
                                                            <a href="#" onclick="confirmDelete('${nh.name}', '${nh.id}', 'parent')" title="delete"> <i class="fa-solid fa-trash"></i></a>
                                                        </div>
                                                    </div>
                                                    <c:if test="${nh.children != null}">
                                                        <div id="headerItem${nh.id}" <%
                                                             if(headerindex == 1){
                                                             %>class="collapse show"<%
                                                                 }
                                                                 else{%>
                                                             class="collapse"
                                                             <%
                                                                 }
                                                             %> data-parent="#headeritem">
                                                            <div class="card-body">
                                                                <c:forEach items="${nh.children}" var="nhc">
                                                                    <div style="display: flex; justify-content: space-between">
                                                                        <p>${nhc.name}</p>
                                                                        <div>
                                                                            <a href="edit-navigation?parent_id=${nh.id}&id=${nhc.id}"><i class="fa-solid fa-pen-to-square" title="edit"></i></a>
                                                                            <a href="#" onclick="confirmDelete('${nhc.name}', '${nhc.id}', 'children')" title="delete"><i class="fa-solid fa-trash"></i></a>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="card">
                                <div class="card-header" style="display: flex; justify-content: space-between">
                                    <a class="collapsed card-link" data-toggle="collapse" href="#footer">
                                        Footer
                                    </a>
                                    <a href="#" title="create" onclick="checkAdd(1, ${nav_footer.size()}, 'Footer', 2)"><i class="fa-solid fa-plus"></i></a>
                                </div>
                                <div id="footer" class="collapse" data-parent="#accordion">
                                    <div class="card-body">
                                        <div id="footeritem">
                                            <c:forEach items="${nav_footer}" var="nh">
                                                <div class="card">
                                                    <div class="card-header" style="display: flex; justify-content: space-between">
                                                        <a class="card-link" data-toggle="collapse" href="#footeritem${nh.id}">
                                                            ${nh.name}
                                                            <%footerindex++;%>
                                                        </a>
                                                        <div>
                                                            <a href="#" title="create" onclick="checkAdd(2, ${nav_footer.size()}, '${nh.name}', ${nh.id})"><i class="fa-solid fa-plus"></i></a>
                                                            <a href="edit-navigation?parent_id=footer&id=${nh.id}"><i class="fa-solid fa-pen-to-square" title="edit"></i></a>
                                                            <a href="#" onclick="confirmDelete('${nh.name}', '${nh.id}', 'parent')" title="delete"><i class="fa-solid fa-trash"></i></a>
                                                        </div>
                                                    </div>
                                                    <c:if test="${nh.children != null}">
                                                        <div id="footeritem${nh.id}" <%
                                                             if(footerindex == 1){
                                                             %>class="collapse show"<%
                                                                 }
                                                                 else{%>
                                                             class="collapse"
                                                             <%
                                                                 }
                                                             %>  data-parent="#footeritem">
                                                            <div class="card-body">
                                                                <c:forEach items="${nh.children}" var="nhc">
                                                                    <div style="display: flex; justify-content: space-between">
                                                                        <p>${nhc.name}</p>
                                                                        <div>
                                                                            <a href="edit-navigation?parent_id=${nh.id}&id=${nhc.id}"><i class="fa-solid fa-pen-to-square" title="edit"></i></a>
                                                                            <a href="#" onclick="confirmDelete('${nhc.name}', '${nhc.id}', 'children')" title="delete"><i class="fa-solid fa-trash"></i></a>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>

                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>
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
                                                                                function confirmDelete(name, id, role)
                                                                                {
                                                                                    if (confirm("Do you want delete " + name)) {
                                                                                        window.location = "admindelnav?id=" + id + "&role=" + role;
                                                                                    }
                                                                                }
                                                                                function checkAdd(parent, length, newsgroup, parent_id){
                                                                                    if(newsgroup === 'Header' && length >= 6){
                                                                                        alert('Your header is full');
                                                                                    }
                                                                                    else if(newsgroup === 'Footer' && length >= 4){
                                                                                        alert('Your footer is full');
                                                                                    }
                                                                                    else{
                                                                                        window.location="create-navigation?parent="+parent+"&parent_name="+newsgroup+"&parent_id="+parent_id;
                                                                                    }
                                                                                }

        </script>
    </body>

</html>
