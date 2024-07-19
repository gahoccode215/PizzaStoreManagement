<%@page import="entity.Account"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="entity.Product"%>
<%@page import="entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>FPT Pizza - Account</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

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
                <li class="nav-item active">
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

                <div class="container-fluid">

                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-8" style="display: flex;align-items: center;">
                                    <form action="account" class="" method="POST">
                                        <div class="input-group">
                                            <input style="width: 410px"  type="text" name="search" class="form-control" placeholder="Search..." />
                                            <div class="input-group-append">
                                                <!--<input type="submit" value="Search" name="action" class="btn btn-success" />-->
                                                <button type="submit" class="btn btn-success" name="action" value="accountsearch">Search</button>
                                            </div>
                                        </div> 
                                    </form>
                                </div>
                                <div class="col-4">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item ml-auto">
                                            <a href="accountadd" style="color: white" class="btn btn-success" >+ Add Account</a>
                                        </li>
                                    </ol>
                                </div>
                            </div>
                            <table border="1" class="table table-bordered table-sm mt-2">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Image</th>
                                        <th>Full Name</th> 
                                        <th>User ID</th>
                                        <th>Role ID</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int cnt = 0;
                                        List<Account> accountList = (List) request.getAttribute("listAccount");
                                        if (accountList != null) {
                                            for (Account i : accountList) {
                                                ++cnt;
                                    %>
                                <form>
                                    <tr>
                                        <td><%= cnt%></td>
                                        <td style="display: flex;justify-content: center">
                                            <%
                                                try {
                                                    String imgName = "D:\\PizzaStoreManagement\\PizzaStoreManagement\\images\\" + i.getImage();
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
                                        <td><%= i.getFullName() %></td>
                                        <td><%= i.getUserID() %></td>
                                        <td><%= i.getRoleID() %></td>
                                        <td>
                                            <!--<form action="product" method="POST">-->
                                                <!--<input type="hidden" name="productID" value="<%= i.getUserID() %>">-->
                                            <!--<button class="button-delete btn btn-warning" name="action" value="productupdate">Update</button>-->
                                            <a class="button-delete btn btn-warning" href="accountupdate?action=accountupdate&userID=<%= i.getUserID() %>">Update</a>
                                            <!--</form>-->
                                            <a class="button-delete btn btn-danger" href="accountdelete?action=accountdelete&userID=<%= i.getUserID() %>">Delete</a>
                                            <a class="btn btn-secondary" href="accountdetail?action=accountdetail&userID=<%= i.getUserID()%>">Detail</a>
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
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>

</html>
