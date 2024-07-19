/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

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
import javax.servlet.http.Part;

/**
 *
 * @author ASUS
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)
public class AccountUpdateController extends HttpServlet {
   private static final String ACCOUNTUPDATE_PAGE = "accountupdate.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String url = ACCOUNTUPDATE_PAGE;
        try {
            String action = request.getParameter("action");
            if(action.equalsIgnoreCase("accountupdate")){
                String userID = request.getParameter("userID");
                AccountDAO accountDAO = new AccountDAO();
                Account account = accountDAO.findbyID(userID);
                if(account != null){
                    request.setAttribute("account", account);
                }
            }
        } catch (Exception e) {
            log("Error at AccountUpdateController " + e);
        }finally{
            request.getRequestDispatcher(url).forward(request, response);
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if(action.equalsIgnoreCase("accountupdate")){
                String userID = request.getParameter("userid");
                String fullName = request.getParameter("name");
                String password = request.getParameter("password");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String roleID = request.getParameter("roleID");
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
                Account acccount = accountDAO.findbyID(userID);
                acccount.setFullName(fullName);
//                acccount.setUserID(userID);
                acccount.setPassword(password);
                acccount.setPhone(phone);
                acccount.setAddress(address);
                acccount.setRoleID(roleID);
                if (imageFileName == null || imageFileName.equalsIgnoreCase("")) {

                } else {
                    acccount.setImage(imageFileName);
                }
                boolean checkUpdate = accountDAO.updateAccount(acccount);
                if (checkUpdate) {
                    request.setAttribute("success", "update successfully");
                    request.setAttribute("account", acccount);
                    request.getRequestDispatcher("accountupdate.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "update failed!");
                    request.setAttribute("account", acccount);
                    request.getRequestDispatcher("accountupdate.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
        }
    }

}
