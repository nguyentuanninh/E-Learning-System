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
import java.util.List;
import model.NewsDAO;
import model.NewsTypeDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "createNewsType", urlPatterns = {"/createNewsType"})
public class CreateNewsType extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        req.getRequestDispatcher("createNewsType.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        NewsGroup newsGroup = new NewsGroup(-1, type);
        NewsTypeDAO newsTypeD = new NewsTypeDAO();
        newsTypeD.AddNewsType(newsGroup);
        System.out.println(newsGroup);
        req.getRequestDispatcher("newsType").forward(req, resp);
    }

}
