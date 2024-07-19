<%@page import="entity.Account"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.io.IOException"%>
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

        <title>FPT Pizza - Update Product</title>

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
                <li class="nav-item active">
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

                <div class="container-fluid">
                    <%
                        Product product = (Product) request.getAttribute("product");
                        if (product != null) {
                    %>
                    <form  action="productupdate" method="POST" enctype="multipart/form-data">
                        <div>
                            <div class="form-group"><h2>Update Pizza</h2></div>
                            <div class="form-group">
                                <label for="name">Name:</label>
                                <input type="text"  class="form-control" name="name" id="name" value="<%= product.getProductName()%>">
                                <div id="nameError" class="error"></div>
                            </div>
                            <div class="form-group">
                                <label for="price">Price</label>
                                <input type="text"  class="form-control" name="price" id="price" value="<%= product.getPrice()%>">
                                <div id="nameError" class="error"></div>
                            </div>
                            <%
                                try {
                                    String imgName = "D:\\PizzaStoreManagement\\PizzaStoreManagement\\images\\" + product.getImage();
                                    BufferedImage bImage = ImageIO.read(new File(imgName));//give the path of an image
                                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                                    ImageIO.write(bImage, "jpg", baos);
                                    baos.flush();
                                    byte[] imageInByteArray = baos.toByteArray();
                                    baos.close();
                                    String b64 = DatatypeConverter.printBase64Binary(imageInByteArray);
                            %>
                            <div class="form-group">
                                <div class="input-group mb-3" style="width: 260px">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Upload</span>
                                    </div>
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="image" name="image" onchange="displayImage(this)">
                                        <label class="custom-file-label">Choose file</label>
                                    </div>
                                </div>
                                <img class="img-responsive" src="data:image/jpg;base64, <%=b64%>" width="300px" height="300px" alt="Preview" style="display: block" id="previewImage"/>
                            </div>
                            <%
                                } catch (IOException e) {
                                    System.out.println("Error: " + e);
                                }
                            %>
                            <div class="form-group">
                                <label for="desc">Description:</label>
                                <input type="text"  class="form-control" name="description" id="desc" value="<%= product.getDescription()%>">
                                <div id="nameError" class="error"></div>
                            </div>
                            <input type="hidden" name="id" value="<%= product.getProductID()%>">
                            <div class="form-group">
                                <button  name="action" value="productupdate" type="submit" class="btn btn-primary" style="padding: 10px 20px; text-align: center">Update</button>
                            </div>
                            <div>
                                <h5 style="color: red">${error}</h5>
                                <h5 style="color: green">${success}</h5
                            </div>
                        </div>

                    </form>
                    <%
                        }

                    %>
                </div>

                <!-- /.container-fluid -->



            </div>
            <!-- /.content-wrapper -->

        </div>
        <!-- /#wrapper -->


        <script>
            function displayImage(input) {
                var previewImage = document.getElementById("previewImage");
                var file = input.files[0];
                var reader = new FileReader();

                reader.onload = function (e) {
                    previewImage.src = e.target.result;
                    previewImage.style.display = "block";
                };

                reader.readAsDataURL(file);
            }
        </script>
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
