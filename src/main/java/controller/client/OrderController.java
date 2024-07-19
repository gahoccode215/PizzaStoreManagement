/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dao.CartDAO;
import dao.OrderDAO;
import entity.Account;
import entity.Cart;
import entity.Order;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
public class OrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("checkout")) {
            HttpSession sesssion = request.getSession();
            Account account = (Account) sesssion.getAttribute("account");
            if (account != null) {
                long millis = System.currentTimeMillis();
                // creating a new object of the class Date  
                java.sql.Date date = new java.sql.Date(millis);
                String userID = account.getUserID();
                CartDAO cartDAO = new CartDAO();
                OrderDAO orderDAO = new OrderDAO();
                List<Cart> listCart = cartDAO.findCartByID(userID);
                cartDAO.updateStatus(userID);
                Order order = Order.builder().orderID(generateIdString().toString()).userID(userID).date(date).build();
                for(Cart i : listCart){
                    cartDAO.updateOrderID(order.getOrderID() , i.getCartID());
                }
                boolean checkInser = orderDAO.insertV2(order);
                if(checkInser){
                    request.getRequestDispatcher("ordered.jsp").forward(request, response);
                }else{
                    request.getRequestDispatcher("menu.jsp").forward(request, response);
                }
            }
        }
    }

    private UUID generateIdString() {
        UUID id = UUID.randomUUID();
        System.out.println(id); // prints a random UUID 
        return id;
    }

}
