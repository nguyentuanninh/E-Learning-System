/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.newstype;

import entity.NewsGroup;
import entity.NewsItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.NewsTypeDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "updateNewsType", urlPatterns = {"/updateNewsType"})
public class UpdateNewsType extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        String newsTypeId = req.getParameter("id");
        int id = 0;
        try {
            id = Integer.parseInt(newsTypeId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        System.out.println(id);
        NewsTypeDAO newsTypeD = new NewsTypeDAO();
        NewsGroup newsG = newsTypeD.getNewsTypeById(id);
        req.setAttribute("newsG", newsG);
        req.getRequestDispatcher("updateNewsType.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        String newsTypeId = req.getParameter("id");
        int id = 0;
        try {
            id = Integer.parseInt(newsTypeId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        NewsGroup newsGroup = new NewsGroup(id, type);
        NewsTypeDAO newsTypeD = new NewsTypeDAO();
        newsTypeD.UpdateNewsType(newsGroup);
        req.getRequestDispatcher("newsType").forward(req, resp);
    }

}
