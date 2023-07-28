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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Logger;
import model.UserDAO;
import utilities.GoogleUtil;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginWithGG", urlPatterns = {"/loginwithgg"})
public class LoginWithGG extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginWithGG</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginWithGG at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
//        out.print(code);
        if (code == null || code.isEmpty()) {
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            String accessToken = GoogleUtil.getToken(code);
            UserGoogle ggUser = GoogleUtil.getUserInfo(accessToken);
            UserDAO ud = new UserDAO();
            UserAccount user = ud.getUser(ggUser.getEmail(), "email");
            if (user == null) {
                try {
                    String hex_password = PasswordEncryption.bytesToHex(ggUser.getId());
                    ud.insertGoogleUser(ggUser.getId(), ggUser.getEmail(), ggUser.getGiven_name() + " " + ggUser.getFamily_name(), hex_password);
                    user = ud.getUser(ggUser.getEmail(), "email");
                    session.setAttribute("account", user);
                    response.sendRedirect("home");
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(LoginWithGG.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
                }

            } else {
                session.setAttribute("account", user);
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
        doGet(request, response);
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
