/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.AccountDAO;
import dao.ProductDAO;
import entity.Product;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author ASUS
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)
public class ProductController extends HttpServlet {

    private static final String PRODUCT_PAGE = "product.jsp";
    private static final String PRODUCTADD_PAGE = "productadd.jsp";
    private static final String PRODUCTUPDATE_PAGE = "productupdate.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        ProductDAO productDAO = new ProductDAO();
        List<Product> listProduct = productDAO.findAllV2();
        request.setAttribute("listProduct", listProduct);
        request.getRequestDispatcher("product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        String url = PRODUCT_PAGE;
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("productsearch")) {
                String search = request.getParameter("search");
                ProductDAO productDAO = new ProductDAO();
                if (search.trim().equalsIgnoreCase("") || search == null) {
                    List<Product> listProduct = productDAO.findAllV2();
                    request.setAttribute("listProduct", listProduct);
                } else {
                    List<Product> listProduct = productDAO.findByName(search);
                    request.setAttribute("listProduct", listProduct);
                }
            } else if (action.equalsIgnoreCase("productadd")) {
                String productName = request.getParameter("name");
                String priceRaw = request.getParameter("price");
                float price = 0;
                try {
                    price = Float.parseFloat(priceRaw);
                } catch (Exception e) {
                }
                String description = request.getParameter("description");
                Part file = request.getPart("image");
                String imageFileName = file.getSubmittedFileName();
                String uploadPath = "D:\\PizzaStoreManagement\\PizzaStoreManagement\\images\\" + imageFileName;  // upload path where we have to upload our actual image
                try {

                    FileOutputStream fos = new FileOutputStream(uploadPath);
                    InputStream is = file.getInputStream();

                    byte[] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                    fos.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
                Product product = Product.builder().productID(generateIdString().toString()).
                        productName(productName).price(price).description(description).image(imageFileName).status(true).build();
                ProductDAO productDAO = new ProductDAO();
                boolean checkInsert = productDAO.insertV2(product);
                if (checkInsert) {
                    url = PRODUCTADD_PAGE;
                    request.setAttribute("success", "Add product successfully");
                } else {
                    url = PRODUCTADD_PAGE;
                    request.setAttribute("error", "Add failed!");
                }
            } else if (action.equalsIgnoreCase("productupdate")) {
                String productID = request.getParameter("productID");
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.findByID(productID);
                if (product != null) {
                    request.setAttribute("product", product);
                }
                url = PRODUCTUPDATE_PAGE;
            } else if (action.equalsIgnoreCase("filterbyprice")) {
                String minPrice = request.getParameter("searchmin");
                String maxPrice = request.getParameter("searchmax");
                ProductDAO productDAO = new ProductDAO();
                List<Product> listProduct;
                if (minPrice.equalsIgnoreCase("") && !maxPrice.equalsIgnoreCase("")) {
//                    mobiles.addAll(new DAO().getAllMobilesWithCondition(-1, Float.parseFloat(maxPrice)));
                    listProduct = productDAO.getAllMobilesWithCondition(-1, Float.parseFloat(maxPrice));
                } else if (!minPrice.equalsIgnoreCase("") && maxPrice.equalsIgnoreCase("")) {
//                    mobiles.addAll(new DAO().getAllMobilesWithCondition(Float.parseFloat(minPrice), -1));
                    listProduct = productDAO.getAllMobilesWithCondition(Float.parseFloat(minPrice), -1);
                } else if (!minPrice.equalsIgnoreCase("") && !maxPrice.equalsIgnoreCase("")) {
//                    mobiles.addAll(new DAO().getAllMobilesWithCondition(-1, -1));
                    listProduct = productDAO.getAllMobilesWithCondition(Float.parseFloat(minPrice), Float.parseFloat(maxPrice));
                } else {
                    listProduct = productDAO.getAllMobilesWithCondition(-1, -1);
                }
//                List<Product> listProduct = productDAO.filterByPrie();
                request.setAttribute("listProduct", listProduct);
            } else if (action.equalsIgnoreCase("sort")) {
                ProductDAO productDAO = new ProductDAO();
                List<Product> listProduct = null;
                String value = request.getParameter("sort");
                if (value.equalsIgnoreCase("namedesc")) {
                    listProduct = productDAO.getAllProductWithSort("namedesc");
                } else if (value.equalsIgnoreCase("nameasc")) {
                    listProduct = productDAO.getAllProductWithSort("nameasc");
                } else if (value.equalsIgnoreCase("pricedesc")) {
                    listProduct = productDAO.getAllProductWithSort("pricedesc");
                } else if (value.equalsIgnoreCase("priceasc")) {
                    listProduct = productDAO.getAllProductWithSort("priceasc");
                }
                request.setAttribute("listProduct", listProduct);
            }
        } catch (Exception e) {
            log("Error at ProductController " + e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private UUID generateIdString() {
        UUID id = UUID.randomUUID();
        System.out.println(id); // prints a random UUID 
        return id;
    }
}
