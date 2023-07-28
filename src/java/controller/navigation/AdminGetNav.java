/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.navigation;

import entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.*;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminGetNav", urlPatterns = {"/navigation"})
public class AdminGetNav extends HttpServlet {

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
            out.println("<title>Servlet AdminGetNav</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminGetNav at " + request.getContextPath() + "</h1>");
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
        NavHeaderDAO headerDAO = new NavHeaderDAO();
        NewsGroup header = headerDAO.Header();
        List<Nav_Header> headerItem;
        if (header.getName() != null) {
            headerItem = headerDAO.getHeaderItem(header.getId());
            if (headerItem != null && !headerItem.isEmpty()) {
                for (Nav_Header nav_Header : headerItem) {
                    List<Nav_Header> navchild = headerDAO.getChildItem(nav_Header.getId());
                    nav_Header.setChildren(navchild);
                }
            }
            Nav_Header logo = headerDAO.getLogo(header.getId());
            request.setAttribute("nav_header", headerItem);
            request.setAttribute("logo", logo);
        }

        NavFooterDAO footer_dao = new NavFooterDAO();
        NewsGroup footer = footer_dao.getFooter();
        List<NavFooter> footerItem;
        if (footer.getName() != null) {
            footerItem = footer_dao.getNewsFooter(footer.getId());
            if (footerItem != null && !footerItem.isEmpty()) {
                for (NavFooter navFooter : footerItem) {
                    List<NavFooter> navchild = footer_dao.getChildItem(navFooter.getId());
                    navFooter.setChildren(navchild);
                }
            }
            request.setAttribute("nav_footer", footerItem);
            NavFooter logo = footer_dao.getLogo(footer.getId());
            request.setAttribute("logo_footer", logo);
            response.getWriter().print(logo.getImage());
        }
        request.getRequestDispatcher("adminnavigation.jsp").forward(request, response);
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
