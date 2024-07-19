<%-- 
    Document   : home
    Created on : Mar 8, 2024, 11:37:27 PM
    Author     : ASUS
--%>

<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="entity.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>FPT Pizza - Login</title>
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

        <style media="screen">
            .user {
                display: inline-block;
                width: 150px;
                height: 150px;
                border-radius: 50%;

                object-fit: cover;
            }

        </style>
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
                        <li class="nav-item active"><a href="info" class="nav-link">Hi, <%= account.getFullName()%></a></li>
                        <li class="nav-item"><a href="checkout" class="nav-link"><i class="fa-solid fa-cart-shopping"></i></a></li>
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
        <!-- END nav -->
        
        <%
            Account acc = (Account) session.getAttribute("account");
        %>

        <div style="display: flex;justify-content: center">
            <form id="addBookForm" action="profileupdate?action=update" method="POST" enctype="multipart/form-data">
                <div>
                    <div class="form-group" style="margin-top: 20px; color: black;margin-left: 88px"><h2> Profile </h2></div>
                    <input type="hidden" value="<%= acc.getUserID() %>" name="id">
                    <div class="form-group">
                        <label for="desc">Full name:</label>
                        <input type="text"  class="form-control" name="name" id="desc" value="<%= acc.getFullName()%>" >
                        <div id="nameError" class="error"></div>
                    </div>
                    <%
                        if (acc.getImage() == null) {

                    %>
                    <div class="form-group">
                        <label for="name">Avatar:</label>
                        <div class="input-group mb-3" style="width: 260px">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="image" name="image" onchange="displayImage(this)">
                                <label class="custom-file-label">Choose image</label>
                            </div>
                        </div>
                        <img style="margin-left: 55px" class="user" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Image_of_none.svg/1200px-Image_of_none.svg.png" width="300px" height="300px" alt="" style="display: none" id="previewImage"/>
                    </div>

                    <% } else {
                        try {
                            String imgName = "D:\\PizzaStoreManagement\\PizzaStoreManagement\\images\\" + acc.getImage();
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
                                <input value="data:image/jpg;base64, <%=b64%>" type="file" class="custom-file-input" id="image" name="image" onchange="displayImage2(this)">
                                <label  class="custom-file-label">Choose file</label>
                            </div>
                        </div>
                        <img style="margin-left: 55px" class="user" src="data:image/jpg;base64, <%=b64%>" width="100px" height="100px" alt="Preview" id="previewImage2" />
                    </div>
                    <%
                            } catch (IOException e) {
                                System.out.println("Error: " + e);
                            }
                        }
                    %>
                    <input type="hidden" value="<%= acc.getUserID() %>" name="id">
                    <%
                        if (!(acc.getPhone() == null)) {
                    %>
                    <div class="form-group">
                        <label for="desc">Phone:</label>
                        <input type="text"  class="form-control" name="phone" id="desc" value="<%= acc.getPhone()%>" >
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
                        if (!(acc.getAddress() == null)) {
                    %>
                    <div class="form-group">
                        <label for="desc">Address:</label>
                        <input type="text"  class="form-control" name="address" id="desc" value="<%= acc.getAddress()%>" >
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
                    <div class="form-group" style="display: flex; justify-content: center">
                        <button type="submit" class="btn btn-primary" style="padding: 10px 20px; text-align: center">Update</button>
                    </div>
                    <div class="form-group" style="display: flex; justify-content: center">
                        <h4 style="color: red">${error}</h4>
                        <h4 style="color: green">${success}</h4>
                    </div>
                </div>
            </form>

        </div>
        <%
        %>
        <!-- Footer -->
        <footer style="margin-top:" class="ftco-footer ftco-section img">
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
            function displayImage2(input) {
                var previewImage = document.getElementById("previewImage2");
                var file = input.files[0];
                var reader = new FileReader();

                reader.onload = function (e) {
                    previewImage.src = e.target.result;
                    previewImage.style.display = "block";
                }

                reader.readAsDataURL(file);
            }
        </script>
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
