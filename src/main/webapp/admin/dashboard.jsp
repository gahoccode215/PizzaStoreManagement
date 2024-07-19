<%@page import="entity.Order"%>
<%@page import="dao.OrderDAO"%>
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

        <title>FPT Pizza - Dashboard</title>

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
            .card{
                margin: 10px;
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
                <li class="nav-item active">
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
                <li class="nav-item ">
                    <a class="nav-link " href="order">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span>Order</span>
                    </a>
                </li>
            </ul>

            <!--end sidebar--> 
            <div id="content-wrapper">
                <%
                    CartDAO cartDAO = new CartDAO();
                    ProductDAO productDAO = new ProductDAO();
                    AccountDAO accountDAO = new AccountDAO();
                    OrderDAO orderDAO = new OrderDAO();
                    List<Account> listAccount = accountDAO.findAll();
                    List<Product> listProduct = productDAO.findAll();
                    List<Order> listOrder = orderDAO.findAllVer2();
                %>
                <div class="container-fluid">
                    <div class="card">
                        <div class="card-body">
                            <div><h7>Product Number: <%= listProduct.size()%> products</h7></div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <div><h7>Account Number: <%= listAccount.size()%> accounts</h7></div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <div><h7>Order Number: <%= listOrder.size()%> orders</h7></div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->
                <%%>


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
