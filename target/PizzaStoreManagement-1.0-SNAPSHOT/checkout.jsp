<%-- 
    Document   : checkout
    Created on : Mar 15, 2024, 4:23:28 PM
    Author     : ASUS
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="entity.Product"%>
<%@page import="dao.ProductDAO"%>
<%@page import="entity.Cart"%>
<%@page import="java.util.List"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="entity.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FPT Pizza - Checkout</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Nothing+You+Could+Do" rel="stylesheet">

        <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
        <link rel="stylesheet" href="css/animate.css">

        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">

        <link rel="stylesheet" href="css/aos.css">

        <link rel="stylesheet" href="css/ionicons.min.css">

        <link rel="stylesheet" href="css/bootstrap-datepicker.css">
        <link rel="stylesheet" href="css/jquery.timepicker.css">


        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/icomoon.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="home"><span class="flaticon-pizza-1 mr-1"></span>Pizza<br><small>Delicous</small></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>
                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item "><a href="home" class="nav-link">Home</a></li>
                        <li class="nav-item"><a href="menu" class="nav-link">Menu</a></li>
                            <%
                                Account account = (Account) session.getAttribute("account");
                                if (account != null) {
                            %>
                        <!--<li class="nav-item"><a href="logout" class="nav-link">Logout</a></li>-->
                        <li class="nav-item "><a href="info" class="nav-link">Hi, <%= account.getFullName()%></a></li>
                        <li class="nav-item active"><a href="checkout" class="nav-link"><i class="fa-solid fa-cart-shopping"></i></a></li>
                        <li class="nav-item"><a href="logout" class="nav-link">Logout</a></li>
                            <%
                            } else {
                            %>
                        <li class="nav-item "><a href="login" class="nav-link">Login</a></li>
                        <li class="nav-item "><a href="signup" class="nav-link">Sign Up</a></li>
                            <%
                                }
                            %>
                    </ul>
                </div>
            </div>
        </nav>

        <%
            Account acc = (Account) session.getAttribute("account");
        %>

        <div style="display: flex;justify-content: center">
            <table border="1px" class="table table-bordered table-sm mt-2">

                <thead>
                    <tr>
                        <th>No</th>
                        <th>Image</th>
                        <th>Pizza name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Cart> listCart = (List) request.getAttribute("listCart");
                        int cnt = 0;
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
                        <td>
                            <a class="btn btn-danger" href="checkoutdelete?cartID=<%=i.getCartID()%>">Remove</a>
                        </td>
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
        </div>
        <div>
            <%
                Account acc2 = (Account) session.getAttribute("account");
            %>
            <div class="container">
                <h2 style="text-align: center">Your Order</h2>
                <div class="form-group">
                    <label for="desc">Full name:</label>
                    <input type="text"  class="form-control" name="name" id="desc" value="<%= acc.getFullName()%>" >
                    <div id="nameError" class="error"></div>
                </div>
                <%
                    if (!(acc2.getPhone() == null)) {
                %>
                <div class="form-group">
                    <label for="desc">Phone:</label>
                    <input type="text"  class="form-control" name="phone" id="desc" value="<%= acc2.getPhone()%>" >
                    <div id="nameError" class="error"></div>
                </div>
                <%
                } else {
                %> 
                <div class="form-group">
                    <label for="desc">Phone:</label>
                    <input type="text"  class="form-control" name="phone" id="desc"  >
                    <div id="nameError" class="error"></div>
                </div>
                <% }%>
                <%
                    if (!(acc2.getAddress() == null)) {
                %>
                <div class="form-group">
                    <label for="desc">Address:</label>
                    <input type="text"  class="form-control" name="address" id="desc" value="<%= acc2.getAddress()%>" >
                    <div id="nameError" class="error"></div>
                </div>
                <%
                } else {
                %> 
                <div class="form-group">
                    <label for="desc">Address:</label>
                    <input type="text"  class="form-control" name="address" id="desc"  >
                    <div id="nameError" class="error"></div>
                </div>
                <% }%>
            </div>
            <%
            %>
        </div>
        <div >
            <%
                int totalPrice = 0;
                List<Cart> listCart2 = (List) request.getAttribute("listCart");
                for (Cart i : listCart2) {
                    if (acc2.getUserID().equals(i.getUserID())) {
                        totalPrice += i.getTotalPrice() * i.getQuantity();
                    }
                }
            %>
            <form action="order" method="POST">
                <h3 style="margin-left: 687px">Total: <%= totalPrice%>$</h3>
                <button type="submit" style="margin-left: 700px; "class="btn btn-success" name="action" value="checkout">Check Out</button>
            </form>
            <%
            %>
        </div>

        <footer style="margin-top: 20px" class="ftco-footer ftco-section img">
            <div class="overlay"></div>
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">

                        <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | Code <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">GaHocCode215</a>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                    </div>
                </div>
            </div>
        </footer>

        <!-- loader -->
        <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


        <script src="js/jquery.min.js"></script>
        <script src="js/jquery-migrate-3.0.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.easing.1.3.js"></script>
        <script src="js/jquery.waypoints.min.js"></script>
        <script src="js/jquery.stellar.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/aos.js"></script>
        <script src="js/jquery.animateNumber.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery.timepicker.min.js"></script>
        <script src="js/scrollax.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
        <script src="js/google-map.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
