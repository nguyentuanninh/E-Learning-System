/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import com.oracle.wls.shaded.org.apache.bcel.generic.AALOAD;
import controller.client.ChangePassword;
import entity.AdminAccount;
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
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.UserDAO;

/**
 *
 * @author asus
 */
@WebServlet(name = "resetPasswordUser", urlPatterns = {"/resetPasswordUser"})
public class resetPasswordUser extends HttpServlet {

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
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        AdminAccount adminAccount = (AdminAccount) session.getAttribute("adminaccount");
        if (adminAccount.getType_id() != 1) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        String username = request.getParameter("username");
        request.setAttribute("username", username);
        request.getRequestDispatcher("resetPasswordUser.jsp").forward(request, response);
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

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");

        boolean checkvalidate = true;
        UserDAO user_dao = new UserDAO();
        UserAccount user = user_dao.getUser(username, "username");
        ValidateRegister vr = new ValidateRegister();

        if (!vr.checkPassword(password).equals("correct")) {
            checkvalidate = false;
            String password_err = vr.checkPassword(password);
            request.setAttribute("password_error", password_err);
        }

        if (!repassword.equals(password)) {
            checkvalidate = false;
            String password_err = "Passwords do not match!";
            request.setAttribute("repassword_error", password_err);

        }
        if (!checkvalidate) {
            request.setAttribute("username", username);
            request.setAttribute("password", password);
            request.setAttribute("re_password", repassword);
            request.getRequestDispatcher("resetPasswordUser.jsp").forward(request, response);
        } else {
            String hex_password;
            try {
                hex_password = PasswordEncryption.bytesToHex(password);
                user_dao.updateUserPassword(username, hex_password);
                request.setAttribute("message", "Reset Password Successfully!"); //
                request.getRequestDispatcher("adminManageUser").forward(request, response);
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(resetPasswordUser.class.getName()).log(Level.SEVERE, null, ex);
            }

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
