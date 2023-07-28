/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.navigation;

import entity.AdminAccount;
import entity.NewsGroup;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.NewsGroupDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminCreateNav", urlPatterns = {"/create-navigation"})
public class AdminCreateNav extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AdminAccount admin = (AdminAccount) session.getAttribute("adminaccount");
        if (admin == null) {
            response.sendRedirect("adminlogin.jsp");
        } else {
            if (admin.getType_id() != 1) {
                response.sendRedirect("errorpage.jsp");
            } else {
                String parent = (String) request.getParameter("parent");
                String parent_name = (String) request.getParameter("parent_name");
                String parent_id = (String) request.getParameter("parent_id");
                if (parent == null) {
                    response.sendRedirect("errorpage.jsp");
                } else {
                    if (parent.equals("1")) {
                        request.setAttribute("parent", 1);
                        request.setAttribute("parent_name", parent_name);
                        request.setAttribute("parent_id", parent_id);
                    } else if (parent.equals("2")) {
                        request.setAttribute("parent", 2);
                        request.setAttribute("parent_name", parent_name);
                        request.setAttribute("parent_id", parent_id);
                    }
                }
                request.getRequestDispatcher("createNavigation.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String namevn = request.getParameter("name_vn");
        String link = request.getParameter("link");
        String slug = request.getParameter("slug");
        String navigation = request.getParameter("navigation");
        String parent = request.getParameter("parent");
        NewsGroupDAO newsGroup = new NewsGroupDAO();
        if (navigation != null && navigation.equals("") == false) {
            newsGroup.insertNavigation(name, namevn, link, slug, Integer.parseInt(navigation), 1);
            response.sendRedirect("navigation");
        }
        if (parent != null && parent.equals("") == false) {
            newsGroup.insertNavigation(name, namevn, link, slug, Integer.parseInt(parent), 2);
            response.sendRedirect("navigation");
        }
    }

}
