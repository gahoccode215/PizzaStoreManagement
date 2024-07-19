/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dao.CartDAO;
import dao.ProductDAO;
import entity.Account;
import entity.Cart;
import entity.Product;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)
public class MenuController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ProductDAO productDAO = new ProductDAO();
        List<Product> listProduct = productDAO.findAllUser();
        request.setAttribute("listProduct", listProduct);
        request.getRequestDispatcher("menu.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            }
        } catch (Exception e) {
            log("Error at " + e);
        } finally {
            request.getRequestDispatcher("menu.jsp").forward(request, response);
        }
    }

}
