/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.AccountDAO;
import dao.ProductDAO;
import entity.Account;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)
public class AccountDeleteController extends HttpServlet {

    private static final String ACCOUNT_PAGE = "account.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = ACCOUNT_PAGE;
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("accountdelete")) {
                String userID = request.getParameter("userID");
                AccountDAO accountDAO = new AccountDAO();

                boolean checkDelete = accountDAO.deleteAccountByID(userID);
                if (checkDelete) {
                    url = ACCOUNT_PAGE;
                    request.setAttribute("success", "Delete successfully");
                } else {
                    url = ACCOUNT_PAGE;
                    request.setAttribute("error", "Delete failed!");
                }
            }
        } catch (Exception e) {
            log("Error at ProductDeleteController " + e);
        } finally {
//            ProductDAO productDAO = new ProductDAO();
            AccountDAO accountDAO = new AccountDAO();
            List<Account> listAccount = accountDAO.findAll();
            request.setAttribute("listAccount", listAccount);
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
