/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.navigation;

import entity.AdminAccount;
import entity.NewsGroup;
import entity.NewsItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import model.NewsGroupDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminEditNav", urlPatterns = {"/edit-navigation"})
public class AdminEditNav extends HttpServlet {

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
                String parent_id = (String) request.getParameter("parent_id");
                String id = request.getParameter("id");
                if (parent_id == null) {
                    response.sendRedirect("errorpage.jsp");
                } else {
                    NewsGroupDAO newsGroup = new NewsGroupDAO();
                    switch (parent_id) {
                        case "header":
                            request.setAttribute("parent", "Header");
                            break;
                        case "footer":
                            request.setAttribute("parent", "Footer");
                            break;
                        default:
                            NewsItem parent = newsGroup.getNewsParent(Integer.parseInt(parent_id));
                            request.setAttribute("parent", parent.getName());
                            break;
                    }
                    NewsItem item = newsGroup.getItemInfo(Integer.parseInt(id));
                    request.setAttribute("item", item);
                }
                request.getRequestDispatcher("EditNavigation.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String name_vn = request.getParameter("name_vn");
        String href = request.getParameter("link");
        String slug = request.getParameter("slug");
        String content = request.getParameter("content");
        String content_vn = request.getParameter("content_vn");
        
        Date modifiedDate = new Date(System.currentTimeMillis());
        HttpSession session = request.getSession();
        AdminAccount admin = (AdminAccount) session.getAttribute("adminaccount");
        NewsGroupDAO newsGroupDAO = new NewsGroupDAO();
        newsGroupDAO.updateNewsItem(Integer.parseInt(id), name, name_vn, href, slug, content, content_vn, modifiedDate, admin.getId());
        response.sendRedirect("navigation");
    }

}
