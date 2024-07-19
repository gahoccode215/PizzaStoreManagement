/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dao.AccountDAO;
import entity.Account;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author ASUS
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)
public class ProfileUpdateController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        try {
            if (action.equalsIgnoreCase("update")) {
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String userName = request.getParameter("name");
                String userID = request.getParameter("id");
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
                AccountDAO accountDAO = new AccountDAO();
                Account account = accountDAO.findbyID(userID);
                if (imageFileName == null || imageFileName.equalsIgnoreCase("")) {

                } else {
                    account.setImage(imageFileName);
                }
                account.setPhone(phone);
                account.setAddress(address);
                account.setFullName(userName);
                boolean update = accountDAO.updateAccountVer2(account);
                if (update) {
                    request.setAttribute("success", "Update successfully");
                } else {
                    request.setAttribute("error", "Fail to update");
                }
                Account acc2 = accountDAO.findbyID(userID);
                HttpSession ses = request.getSession();
                ses.setAttribute("account", acc2);
            }
        } catch (Exception e) {
            log("Error at ProfileUpdateController" + e);
        } finally {
            request.getRequestDispatcher("info.jsp").forward(request, response);
        }
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
