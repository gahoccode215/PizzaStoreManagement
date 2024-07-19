<%-- 
    Document   : home
    Created on : Mar 8, 2024, 11:37:27 PM
    Author     : ASUS
--%>

<%@page import="entity.Product"%>
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
            @import url("https://fonts.googleapis.com/css?family=Bree+Serif|Poppins|Source+Sans+Pro|Montserrat:400,900&display=swap");

            * {
                /* margin: 0;
                padding: 0; */
                box-sizing: border-box;
                /*font-family: "Source Sans Pro", "Poppins", sans-serif;*/
            }
            body {
                /* background: #333; */
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 1.5em;
            }

            .menu {
                font-family: sans-serif;
                font-size: 14px;
            }

            .menu-group-heading {
                margin: 0;
                padding-bottom: 1em;
                border-bottom: 2px solid #ccc;
            }

            .menu-group {
                display: grid;
                grid-template-columns: 1fr;
                gap: 1.5em;
                padding: 1.5em 0;
            }

            .menu-item {
                display: flex;
            }

            .menu-item-img {
                width: 80px;
                height: 80px;
                flex-shrink: 0;
                object-fit: cover;
                margin-right: 1.5em;
            }

            .menu-item-text {
                flex-grow: 1;
            }

            .menu-item-heading {
                display: flex;
                justify-content: space-between;
                margin: 0;
            }

            .menu-item-name {
                margin-right: 1.5em;
            }

            .menu-item-desc {
                line-height: 1.6;
            }

            .btn-add{
                border: none;
                outline: 0;
                padding: 12px;
                color: white;
                background-color: #000;
                text-align: center;
                cursor: pointer;
                width: 100%;
                font-size: 18px;
            }
            .btn-add:hover{
                opacity: 0.7;
            }
            @media screen and (min-width: 992px) {
                .menu {
                    font-size: 16px;
                }

                .menu-group {
                    grid-template-columns: repeat(2, 1fr);
                }

                .menu-item-img {
                    width: 250px;
                    height: 250px;
                }
            }
            .button {
                --background: #E5A247;
                --text: #fff;
                --cart: #fff;
                --tick: var(--background);
                position: relative;
                border: none;
                background: none;
                padding: 8px 28px;
                border-radius: 8px;
                -webkit-appearance: none;
                -webkit-tap-highlight-color: transparent;
                -webkit-mask-image: -webkit-radial-gradient(white, black);
                overflow: hidden;
                cursor: pointer;
                text-align: center;
                min-width: 144px;
                color: var(--text);
                background: var(--background);
                transform: scale(var(--scale, 1));
                transition: transform 0.4s cubic-bezier(0.36, 1.01, 0.32, 1.27);
            }

            .button:active {
                --scale: 0.95;
            }

            .button span {
                /*font-size: 14px;*/
                font-weight: 500;
                /*display: block;*/
                position: relative;
                /*padding-left: 24px;*/
                /*margin-left: -8px;*/
                /*line-height: 26px;*/
                transform: translateY(var(--span-y, 0));
                transition: transform 0.7s ease;
            }

            span{
                color: white;
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
                        <li class="nav-item active"><a href="menu" class="nav-link">Menu</a></li>
                            <%
                                Account account = (Account) session.getAttribute("account");
                                if (account != null) {
                            %>
                        <!--<li class="nav-item"><a href="logout" class="nav-link">Logout</a></li>-->
                        <li class="nav-item"><a href="info" class="nav-link">Hi, <%= account.getFullName()%></a></li>
                        <li class="nav-item"><a href="checkout" class="nav-link"><i class="fa-solid fa-cart-shopping"></i></a></li>
                        <li class="nav-item"><a href="logout" class="nav-link">Logout</a></li>
                            <%
                            } else {
                            %>
                        <li class="nav-item"><a href="login" class="nav-link">Login</a></li>
                        <li class="nav-item"><a href="signup" class="nav-link">Sign Up</a></li>
                            <%
                                }
                            %>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- END nav -->

        <main class="container">
            <div class="menu">
                <h2 class="menu-group-heading">Our Pizza</h2>
                <div class="row">
                    <div class="col-8" style="display: flex;align-items: center; margin:20px">
                        <form action="menu" class="" method="POST">
                            <div class="input-group">
                                <input style="color: white" type="text" name="search" class="form-control" placeholder="Search..." />
                                <div class="input-group-append">
                                    <!--<input type="submit" value="Search" name="action" class="btn btn-success" />-->
                                    <button type="submit" class="btn btn-success" name="action" value="productsearch">Search</button>
                                </div>
                            </div> 
                        </form>
                    </div>
                </div>
                <div class="row">
                    <div class="col-8" style="display: flex;align-items: center; margin:20px">
                        <form action="menu" class="" method="POST">
                            <div class="input-group">
                                <input  style="margin-right: 5px; width: 100px" type="number" name="searchmin" class="form-control" placeholder="MIN" />
                                <input style="margin-right: 5px; width: 100px" type="number" name="searchmax" class="form-control" placeholder="MAX" />
                                <div class="input-group-append">
                                    <!--<input type="submit" value="Search" name="action" class="btn btn-success" />-->
                                    <button type="submit" class="btn btn-success" name="action" value="filterbyprice">Filter By Price</button>
                                </div>
                            </div> 
                        </form>
                    </div>
                </div>
                <div class="menu-group">
                    <%
                        List<Product> listProduct = (List) request.getAttribute("listProduct");
                        if (listProduct != null) {
                            for (Product i : listProduct) {
                    %>
                    <form  action="menuadd"  method="POST" enctype="multipart/form-data">

                        <div class="menu-item">
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
                            <input type="hidden" value= <%= i.getImage()%> name="image">
                            <img
                                src="data:image/jpg;base64, <%=b64%>"
                                alt="Black Placeholder Image"
                                class="menu-item-img"
                                />
                            <%
                                } catch (IOException e) {
                                    System.out.println("Error: " + e);
                                }
                            %>
                            <div class="menu-item-text" style="position: relative">
                                <h3 class="menu-item-heading">
                                    <span class="menu-item-name"><%= i.getProductName()%></span>
                                    <span class="menu-item-price"><%= i.getPrice()%>$</span>
                                </h3>
                                <input type="hidden" value="<%= i.getProductID()%>" name="id">
                                <input type="hidden" value="<%= i.getDescription()%>" name="description">
                                <input type="hidden" value="<%= i.getPrice()%>" name="price">
                                <input type="hidden" value="<%= i.getProductName()%>" name="name">
                                <p class="menu-item-desc">
                                    <%= i.getDescription()%>
                                </p>
                                <!--                                <div style="position: absolute; bottom: 0">
                                                                    <div style="display: flex">
                                                                        <button type="submit" name="action" value="add" class="btn btn-add" style=" background-color: black; border-radius: 5px; ">Add to cart</button>
                                                                    
                                                                    </div>
                                                                </div>-->
                                <div>
                                    <input style="width: 120px" name="quantity"  type="number"/>
                                    <button name="action" value="add" class="button">
                                        <span> <i class="fas fa-cart-plus"></i>  Add to cart</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                    <%
                            }
                        }
                    %>
                </div>
                <p style="color: red">${error}</p>
                <p style="color: green">${success}</p>
            </div>
        </main>

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
