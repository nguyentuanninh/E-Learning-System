/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.newstype;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.NewsDAO;
import model.NewsTypeDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "deleteNewsType", urlPatterns = {"/deleteNewsType"})
public class DeleteNewsType extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        String newsId = req.getParameter("id");
        int id = 0;
        try {
            id = Integer.parseInt(newsId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        NewsTypeDAO newsTypeD = new NewsTypeDAO();
        newsTypeD.DelNewsType(id);
        resp.sendRedirect("newsType");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
    
}
