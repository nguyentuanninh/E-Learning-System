/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import entity.PasswordEncryption;
import entity.UserAccount;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.UserDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UserChangePassword", urlPatterns = {"/userchangepassword"})
public class UserChangePassword extends HttpServlet {

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
            throws ServletException, IOException, NoSuchAlgorithmException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            UserAccount loggeduser = (UserAccount) session.getAttribute("account");
            if (loggeduser == null) {
                response.sendRedirect("login.jsp");
            } else {
                controller.share.NewServlet.headerFooter(request);
                request.getRequestDispatcher("changepasswordinprofile.jsp").forward(request, response);
            }
        } catch (Exception e) {
            response.sendRedirect("errorpage.jsp");
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
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(UserChangePassword.class.getName()).log(Level.SEVERE, null, ex);
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
        try {

            PrintWriter out = response.getWriter();
            HttpSession session = request.getSession();
            String password = request.getParameter("password");
            String newpassword = request.getParameter("newpword");
            boolean checkvalidate = true;
            UserDAO user_dao = new UserDAO();
            String hex_password = PasswordEncryption.bytesToHex(password);
            UserAccount user_logged = (UserAccount) session.getAttribute("account");
            if (!user_logged.getPassword().equals(hex_password)) {
                checkvalidate = false;
                request.setAttribute("pword_err", "Password incorrect!");
            }
            if (!checkvalidate) {
                request.getRequestDispatcher("changepasswordinprofile.jsp").forward(request, response);
            } else {
                String hex_newpassword = PasswordEncryption.bytesToHex(newpassword);
                user_dao.updateUserPassword(user_logged.getUsername(), hex_newpassword);
                request.setAttribute("message", "Change Password Successfully!"); //
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(UserChangePassword.class.getName()).log(Level.SEVERE, null, ex);
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
