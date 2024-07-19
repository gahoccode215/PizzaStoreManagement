/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.AccountDAO;
import entity.Account;
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
public class AccountController extends HttpServlet {

    private static final String ACCOUNT_PAGE = "account.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        AccountDAO accountDAO = new AccountDAO();
        List<Account> listAccount = accountDAO.findAll();
        request.setAttribute("listAccount", listAccount);
        request.getRequestDispatcher("account.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ACCOUNT_PAGE;
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("accountsearch")) {
                AccountDAO accountDAO = new AccountDAO();
                String search = request.getParameter("search");
                if (search.trim().equalsIgnoreCase("") || search == null) {
                    List<Account> listAccount = accountDAO.findAll();
                    request.setAttribute("listAccount", listAccount);
                } else {
                    List<Account> listAccount = accountDAO.findbyUserIDorName(search, search);
                    request.setAttribute("listAccount", listAccount);
                }
            }
        } catch (Exception e) {
            log("Error at AccountController " + e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

}
