/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import entity.AdminAccount;
import entity.PasswordEncryption;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AdminDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminLogin", urlPatterns = {"/adminlogin"})
public class AdminLogin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.security.NoSuchAlgorithmException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NoSuchAlgorithmException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String remember = (String) request.getParameter("rememberme");
            HttpSession session = request.getSession();
            Cookie[] cookie = request.getCookies();
            AdminDAO adminDAO = new AdminDAO();
            String hexPassword = PasswordEncryption.bytesToHex(password);
            AdminAccount adminAccount = adminDAO.login(username, hexPassword);

            if (adminAccount == null || !username.equals(adminAccount.getUsername())) {
                String err = "Username or password incorrect!";
                request.setAttribute("err", err);
                request.getRequestDispatcher("adminlogin.jsp").forward(request, response);
            } else if (adminAccount.isDisabled()) {
                String err = "Your account has been banned!";
                request.setAttribute("err", err);
                request.getRequestDispatcher("adminlogin.jsp").forward(request, response);
            } else {

                if (remember == null) {
                    if (cookie != null) {
                        for (Cookie o : cookie) {
                            if (o.getName().equals("adminname")) {
                                o.setMaxAge(0);
                                response.addCookie(o);
                            }
                            if (o.getName().equals("adminpassword")) {
                                o.setMaxAge(0);
                                response.addCookie(o);
                            }
                        }
                    }
                } else {
                    Cookie nameCookie = new Cookie("adminname", username);
                    Cookie passCookie = new Cookie("adminpassword", password);
                    nameCookie.setMaxAge(2 * 24 * 60 * 60);
                    passCookie.setMaxAge(2 * 24 * 60 * 60);
                    response.addCookie(nameCookie);
                    response.addCookie(passCookie);
                }
                session.setAttribute("adminaccount", adminAccount);
                
                    response.sendRedirect("dashboard");
                

            }
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
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(AdminLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
