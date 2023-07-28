/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Logger;
import model.*;

/**
 *
 * @author Admin
 */
@WebServlet(name="Login", urlPatterns={"/login"})
public class Login extends HttpServlet {

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
            UserDAO user_dao = new UserDAO();         
            String hex_password = PasswordEncryption.bytesToHex(password);
        
            UserAccount user_account = user_dao.login(username, hex_password);

            if (user_account == null || !username.equals(user_account.getUsername())) {
                String err = "Username or password incorrect!";
                request.setAttribute("err", err);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else if (user_account.isDisabled()) {
                String err = "Your account has been banned!";
                request.setAttribute("err", err);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } 
            else {
              
                if (remember == null) {
                    if (cookie != null) {
                        for (Cookie o : cookie) {
                            if (o.getName().equals("name")) {
                                o.setMaxAge(0);
                                response.addCookie(o);
                            }
                            if (o.getName().equals("password")) {
                                o.setMaxAge(0);
                                response.addCookie(o);
                            }
                        }
                    }
                } else {
                    Cookie name_cookie = new Cookie("name", username);
                    Cookie pass_cookie = new Cookie("password", password);
                    name_cookie.setMaxAge(2 * 24 * 60 * 60);
                    pass_cookie.setMaxAge(2 * 24 * 60 * 60);
                    response.addCookie(name_cookie);
                    response.addCookie(pass_cookie);
                }
                session.setAttribute("account", user_account);
                response.sendRedirect("home");
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
            Logger.getLogger(Login.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
    }

}
