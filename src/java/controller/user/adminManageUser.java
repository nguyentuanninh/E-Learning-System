/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import entity.AdminAccount;
import entity.UserAccount;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

import model.UserDAO;

/**
 *
 * @author asus
 */
@WebServlet(name = "adminManageUser", urlPatterns = {"/adminManageUser"})
public class adminManageUser extends HttpServlet {

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

        UserDAO ud = new UserDAO();
        //search: nếu có parameter search thì get list theo giá trị search
        List<UserAccount> list;
        if (request.getParameter("search") != null && !request.getParameter("search").equals("")) {
            String search = request.getParameter("search");
            list = ud.searchListUser(search);
        } else {
            list = ud.getListUser();
        }
        //Phân trang   
        int total = list.size();
        int elementPerPage = 5;
        int numberOfPage = (total % elementPerPage == 0) ? (total / elementPerPage) : (total / elementPerPage + 1); //Số trang
        int page;
        String xpage = request.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start = (page - 1) * elementPerPage;
        int end = Math.min((page) * elementPerPage, total);
        List<UserAccount> listAcc = ud.getListUserByPage(list, start, end);
        request.setAttribute("listUser", listAcc);
        request.setAttribute("page", page);
        request.setAttribute("numberOfPage", numberOfPage);
        //Xog phân trang
        request.getRequestDispatcher("adminManageUser.jsp").forward(request, response);
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
        UserDAO ud = new UserDAO();
        if (request.getParameter("Enabled") != null) {
            String id = request.getParameter("idUser");
            int idUser = Integer.parseInt(id);
            ud.updateUserDisabled(idUser, 0);
        }

        if (request.getParameter("Disabled") != null) {
            String id = request.getParameter("idUser");
            int idUser = Integer.parseInt(id);
            ud.updateUserDisabled(idUser, 1);
        }
        response.sendRedirect("adminManageUser");
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
