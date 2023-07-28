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
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.UserDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name="ClientRegister", urlPatterns={"/clientregister"})
public class ClientRegister extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String name = request.getParameter("name");
            String phonenumber = request.getParameter("phonenumber");
            String password = request.getParameter("password");
            String re_password = request.getParameter("re-password");

            UserDAO user_dao = new UserDAO();
            boolean checkvalidate = true;
            ValidateRegister validate = new ValidateRegister();

            if (!validate.checkUserName(username).equals("correct")) {
                checkvalidate = false;
                String username_err = validate.checkUserName(username);
                request.setAttribute("username_error", username_err);
            } else {
                UserAccount user = user_dao.getUser(username, "username");
                if (user != null) {
                    checkvalidate = false;
                    String username_err = "This name already exists!";
                    request.setAttribute("username_error", username_err);
                }
            }
            UserAccount user = user_dao.getUser(email, "email");
            if(user != null){
                checkvalidate = false;
                String email_err = "This email is already registered!";
                request.setAttribute("email_error", email_err);
            }
            if(!validate.checkPhoneNumber(phonenumber).equals("correct")){
                checkvalidate = false;
                String phone_error = validate.checkPhoneNumber(phonenumber);
                request.setAttribute("phone_error", phone_error);
            }
            
            if (!validate.checkPassword(password).equals("correct")) {
                checkvalidate = false;
                String password_err = validate.checkPassword(password);
                request.setAttribute("password_error", password_err);
            }

            if (!re_password.equals(password)) {
                checkvalidate = false;
                String password_err = "Passwords do not match!";
                request.setAttribute("repassword_error", password_err);

            }
            if (!checkvalidate) {
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("phonenumber", phonenumber);
                request.setAttribute("name", name);
                request.setAttribute("password", password);
                request.setAttribute("re_password", re_password);
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                String hex_password = PasswordEncryption.bytesToHex(password);
                user_dao.insertCustomer(username, email, name, phonenumber, hex_password);
                request.setAttribute("message", "Register Successfully!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
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
//        processRequest(request, response);
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
            Logger.getLogger(ClientRegister.class.getName()).log(Level.SEVERE, null, ex);
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
