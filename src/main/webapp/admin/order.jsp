<%@page import="entity.Order"%>
<%@page import="entity.Cart"%>
<%@page import="java.io.IOException"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.AccountDAO"%>
<%@page import="dao.ProductDAO"%>
<%@page import="dao.CartDAO"%>
<%@page import="entity.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>FPT Pizza - Order</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <!-- Page level plugin CSS-->
        <link href="${pageContext.request.contextPath}/admin/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/admin/css/sb-admin.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/colReorder-bootstrap4.css">

        <style>
            .error {
                color: red;
            }
        </style>
    </head>

    <body id="page-top">
        <!--Nav bar-->
        <nav class="navbar navbar-expand navbar-dark bg-dark static-top justify-content-between">

            <%
                Account acc = (Account) session.getAttribute("account");
            %>
            <div class="col-10" style="margin-right: 60px">
                <p class="navbar-brand mr-1" style="margin-bottom: 2px;font-weight: bold">ADMIN</p>
            </div>
            <div class="col-2">
                <a class="btn btn-primary btn-sm mr-2" href=""><%= acc.getFullName()%></a>
                <a class="btn btn-danger btn-sm mr-2" href="logout">Logout</a>
            </div>

            <!-- Navbar -->

        </nav>
        <!--End Nav-->
        <div id="wrapper">

            <!-- Sidebar -->
            <ul class="sidebar navbar-nav">
                <li class="nav-item ">
                    <a class="nav-link" href="dashboard">
                        <i class="fas fa-fw fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link " href="product">
                        <i class="fa-solid fa-pizza-slice"></i>
                        <span>Product</span>
                    </a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link " href="account">
                        <i class="fa-solid fa-user"></i>
                        <span>Account</span>
                    </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link " href="order">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span>Order</span>
                    </a>
                </li>
            </ul>

            <!--end sidebar--> 
            <div id="content-wrapper">
                <div class="container-fluid">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="row">
                            </div>
                            <table border="1" class="table table-bordered table-sm mt-2">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>user ID</th> 
                                        <th>Address</th>
                                        <th>Phone</th>
                                        <th>Date</th>
                                        <!--<th>Total Price</th>-->
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int cnt = 0;

                                        List<Order> listOrder = (List) request.getAttribute("listOrder");
                                        if (listOrder != null) {
                                            for (Order i : listOrder) {
                                                ++cnt;
                                    %>
                                <form>
                                    <tr>
                                        <td><%= cnt%></td>
                                        <td><%= i.getUserID()%></td>
                                        <%
                                            try {
                                                AccountDAO accountDAO = new AccountDAO();
                                                Account account = accountDAO.findbyID(i.getUserID());
                                        %>
                                        <td><%= account.getAddress()%></td>
                                        <td><%= account.getPhone()%></td>
                                        <%
                                            } catch (Exception e) {
                                            }
                                        %>
                                        <td><%= i.getDate()%></td>
                                        <td>
                                            <a class="btn btn-primary" href="detailorder?orderID=<%=i.getOrderID()%>">View</a>
                                            <!--<a href="">Accept</a>-->
                                            <!--<a class="btn btn-success" href="acceptorder?orderID=<%=i.getOrderID()%>">Accept</a>-->
                                            <!--<a href="">Accept</a>-->
                                            <!--<a  class="btn btn-danger" href="deleteorder?orderID=<%=i.getOrderID()%>">Delete</a>-->
                                            <!--<a href="">Accept</a>-->
                                        </td>
                                    </tr>
                                </form>
                                <%
                                        }
                                    }
                                %>
                                </tbody>
                            </table>
                            <div>
                                <h5 style="color: red">${error}</h5>
                                <h5 style="color: green">${success}</h5
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- /.container-fluid -->


        </div>
        <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->


    <!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath}/admin/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath}/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="${pageContext.request.contextPath}/admin/vendor/chart.js/Chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/vendor/datatables/jquery.dataTables.js"></script>
    <script src="${pageContext.request.contextPath}/admin/vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath}/admin/js/sb-admin.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/colReorder-bootstrap4-min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/colReorder-dataTables-min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="${pageContext.request.contextPath}/admin/js/demo/datatables-demo.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/demo/chart-area-demo.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/colReorder-dataTables-min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/js/colReorder-bootstrap4-min.js"></script>


</body>

</html>
