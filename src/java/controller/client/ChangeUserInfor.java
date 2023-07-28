/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import entity.PasswordEncryption;
import entity.UserAccount;
import entity.ValidateRegister;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.UserDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ChangeUserInfor", urlPatterns = {"/changeuserinfor"})
public class ChangeUserInfor extends HttpServlet {

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
            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String pnum = request.getParameter("pnum");
            HttpSession session = request.getSession();

            UserDAO user_dao = new UserDAO();
            boolean checkvalidate = true;
            ValidateRegister validate = new ValidateRegister();

            String username_err = "";
            String email_err = "";
            String phone_err = "";
            UserAccount user = (UserAccount) session.getAttribute("account");
            if (!user.getUsername().equals(username.trim())) {
                if (user_dao.getUser(username, "username") != null) {
                    checkvalidate = false;
                    username_err = "This name already exists!";
                    request.setAttribute("username_error", username_err);
                }
            }
            if (!user.getEmail().equals(email)) {
                if (user_dao.getUser(email, "email") != null) {
                    checkvalidate = false;
                    email_err = "This email is already registered!";
                    request.setAttribute("email_error", email_err);
                }
            }
            if (!user.getTelephone().equals(pnum)) {
                if (user_dao.getUser(pnum, "telephone") != null) {
                    checkvalidate = false;
                    phone_err = "This phone number is already registered!";
                    request.setAttribute("pnum_err", phone_err);
                }
            }

            if (!checkvalidate) {
                response.sendRedirect("userinformation?username_err=" + username_err + "&email_err=" + email_err + "&pnum_err=" + phone_err);
            } else {
                UserDAO userdao = new UserDAO();
                userdao.updateUserInfor(username, pnum, email, name, user.getId());
                user = userdao.getUserById(user.getId());
                session.setAttribute("account", user);
                request.getRequestDispatcher("userinformation").forward(request, response);
            }
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
