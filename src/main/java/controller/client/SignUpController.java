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
public class SignUpController extends HttpServlet {
   
    private static final String SIGNUP_PAGE = "signup.jsp";
    private static final String ERROR = "signup.jsp";
    private static final String SUCCESS = "index.jsp";
    private static final String HOME_CONTROLLER = "home";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = SIGNUP_PAGE;
        try {
            
        } catch (Exception e) {
            log("Error at SignUpController " + e);
        }finally{
            request.getRequestDispatcher(url).forward(request, response);
        }
    } 
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String url = ERROR;
        String userID = request.getParameter("userid");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullname");
        String roleID = request.getParameter("roleID");
        try {
            Account account = new Account().builder().fullName(fullName).userID(userID).password(password).roleID(roleID).build();
            AccountDAO accountDAO = new AccountDAO();
            boolean insertCheck = accountDAO.insertV2(account);
            if(insertCheck){
                HttpSession session = request.getSession();
                session.setAttribute("account", account);
                url = HOME_CONTROLLER;
                response.sendRedirect(url);
            }else{
                url = ERROR;
                request.setAttribute("error", "User ID exist! Please use another user ID");
                request.getRequestDispatcher(url).forward(request, response);
            }
        } catch (Exception e) {
            log("Error at SignUpController" + e);
        }finally{
        }
    }

}
