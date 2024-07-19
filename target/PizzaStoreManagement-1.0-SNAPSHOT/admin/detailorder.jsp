<%@page import="dao.OrderDAO"%>
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
                            <table border="1" class="table table-bordered table-sm mt-2">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Image</th>
                                        <th>Pizza name</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        String orderID = (String) request.getAttribute("orderID");
                                        OrderDAO orderDAO = new OrderDAO();
                                        Order order = orderDAO.findByID(orderID);
                                        AccountDAO accountDAO = new AccountDAO();
                                        Account account = accountDAO.findbyID(order.getUserID());
                                        CartDAO cartDAO = new CartDAO();
                                        int cnt = 0;
                                        List<Cart> listCart = cartDAO.findOrder(orderID);
                                        if (listCart != null) {
                                            for (Cart i : listCart) {
                                                cnt++;
                                    %>
                                <form action="CartController" method="POST" class="formDelete" enctype="multipart/form-data" > 
                                    <%
                                        ProductDAO productDAO = new ProductDAO();
                                        Product product = productDAO.findByID(i.getProductID());
                                    %>
                                    <tr>
                                        <td><%= cnt%></td>
                                        <td>
                                            <%
                                                try {
                                                    String imgName = "D:\\PRJ301_Ass\\PizzaManagement\\images\\" + product.getImage();
                                                    BufferedImage bImage = ImageIO.read(new File(imgName));//give the path of an image
                                                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                                                    ImageIO.write(bImage, "jpg", baos);
                                                    baos.flush();
                                                    byte[] imageInByteArray = baos.toByteArray();
                                                    baos.close();
                                                    String b64 = DatatypeConverter.printBase64Binary(imageInByteArray);
                                            %>
                                            <img  class="img-responsive" src="data:image/jpg;base64, <%=b64%>"
                                                  width="100px"
                                                  height="100px"
                                                  alt="image" class="card-img-top" />                         
                                            <%
                                                } catch (IOException e) {
                                                    System.out.println("Error: " + e);
                                                }
                                            %>
                                        </td>
                                        <td><%= product.getProductName()%> </td>
                                        <td><%= i.getQuantity()%> </td>
                                        <td><%= product.getPrice()%></td>
                                        <td><%= i.getQuantity() * product.getPrice()%>$</td>
                                    </tr>
                                    <%
                                    %>
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
            <div >
                <%
                    int totalPrice = 0;
//                                    List<Cart> listCart2 = (List) request.getAttribute("listCart");
                    for (Cart i : listCart) {
                        if (account.getUserID().equals(i.getUserID())) {
                            totalPrice += i.getTotalPrice() * i.getQuantity();
                        }
                    }
                %>
                <!--<form action="order" method="POST">-->
                <h3 style="margin-left: 687px">Total: <%= totalPrice%>$</h3>
                <!--<button type="submit" style="margin-left: 700px; "class="btn btn-success" name="action" value="checkout">Check Out</button>-->
                <!--</form>-->
                <%
                %>
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
