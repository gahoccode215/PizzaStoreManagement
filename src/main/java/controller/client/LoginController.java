/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dao.AccountDAO;
import entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */

public class LoginController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String ERROR = "login.jsp";
    private static final String US = "US";
    private static final String AD = "AD";
    private static final String HOME_PAGE = "index.jsp";
    private static final String DASHBOARD_PAGE = "admin/dashboard";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try {

        } catch (Exception e) {
            log("Error at LoginController " + e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        String id = request.getParameter("userID");
        String password = request.getParameter("password");
        String url = ERROR;
        AccountDAO accountDAO = new AccountDAO();
        try {
            Account account = accountDAO.getUser(id, password);
            if (account == null) {
                request.setAttribute("error", "incorrect UserID or Password");
                url = ERROR;
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("account", account);
                if (account.getRoleID().equalsIgnoreCase(US)) {
                    url = HOME_PAGE;
                    request.getRequestDispatcher(url).forward(request, response);
                } else if (account.getRoleID().equalsIgnoreCase(AD)) {
                    url = DASHBOARD_PAGE;
                    response.sendRedirect(getServletContext().getContextPath() + "/admin/dashboard");
//                    response.sendRedirect(url);
                }
            }
        } catch (Exception e) {
        } finally {
        }
    }

}
