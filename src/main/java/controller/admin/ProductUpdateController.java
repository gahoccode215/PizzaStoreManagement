/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.ProductDAO;
import entity.Product;
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
public class ProductUpdateController extends HttpServlet {

    private static final String PRODUCTUPDATE_PAGE = "productupdate.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = PRODUCTUPDATE_PAGE;
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("productupdate")) {
                String productID = request.getParameter("productID");
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.findByID(productID);
                System.out.println(product);
                if (product != null) {
                    request.setAttribute("product", product);
                }
            }
        } catch (Exception e) {
            log("Error at ProductUpdateController " + e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
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
        String action = request.getParameter("action");
        try {
            if (action.equalsIgnoreCase("productupdate")) {
                String productName = request.getParameter("name");
                String productID = request.getParameter("id");
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
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.findByID(productID);
                product.setProductName(productName);
                product.setPrice(price);
                product.setDescription(description);
                if (imageFileName == null || imageFileName.equalsIgnoreCase("")) {

                } else {
                    product.setImage(imageFileName);
                }
                boolean checkUpdate = productDAO.updateProduct(product);
                if (checkUpdate) {
                    request.setAttribute("success", "update successfully");
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("productupdate.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "update failed!");
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("productupdate.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
        }
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
