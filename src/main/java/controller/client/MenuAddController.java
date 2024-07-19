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
import java.io.PrintWriter;
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
public class MenuAddController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("add")) {
                String priceRaw = request.getParameter("price");
                String quantityRaw = request.getParameter("quantity");
                float price = 0;
                int quantity = 0;
                if (quantityRaw.equalsIgnoreCase("") || quantityRaw == null) {
                    quantity = 1;
                } else {
                    try {
                        quantity = Integer.parseInt(quantityRaw);
                    } catch (Exception e) {
                    }
                }
                try {
                    price = Float.parseFloat(priceRaw);
                } catch (Exception e) {
                }
                String pizzaID = request.getParameter("id");
                ProductDAO pizzaDAO = new ProductDAO();
                Product pizza = pizzaDAO.findByID(pizzaID);
                HttpSession session = request.getSession();
                Account account = (Account) session.getAttribute("account");
                if (pizza != null) {
                    CartDAO cartDAO = new CartDAO();
                    Cart cartCheck = cartDAO.findCartByPizzaIDAndAccountID(pizzaID, account.getUserID());
                    if (cartCheck != null) {
                        int newQuantity = cartCheck.getQuantity() + quantity;
                        cartDAO.updateQuantity(pizzaID, newQuantity);
                        request.setAttribute("success", "Add to cart successfully");
                    } else {
                        Cart cart = Cart.builder().cartID(generateIdString().toString()).productID(pizzaID).userID(account.getUserID()).totalPrice(price).quantity(quantity).status(true).build();
                        cartDAO.insert(cart);
                        request.setAttribute("success", "Add to cart successfully");
                    }
                } else {
                    request.setAttribute("error", "fail to add");
                }
            }
        } catch (Exception e) {
            log("Error at MenuController" + e);
        } finally {
            response.setContentType("text/html;charset=UTF-8");
            ProductDAO productDAO = new ProductDAO();
            List<Product> listProduct = productDAO.findAllUser();
            request.setAttribute("listProduct", listProduct);
            request.getRequestDispatcher("menu.jsp").forward(request, response);
        }
    }

    private UUID generateIdString() {
        UUID id = UUID.randomUUID();
        System.out.println(id); // prints a random UUID 
        return id;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
