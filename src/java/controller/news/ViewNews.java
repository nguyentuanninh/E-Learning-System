/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.news;

import entity.AdminAccount;
import entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.AdminDAO;
import model.NewsDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "viewNews", urlPatterns = {"/viewNews"})
public class ViewNews extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
            String newsID = req.getParameter("id");
        int ID = 0;
        try {
            ID = Integer.parseInt(newsID);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        NewsDAO newsD = new NewsDAO();
        News news = newsD.getNewsById(ID);
        AdminDAO admin_dao = new AdminDAO();
        List<AdminAccount> listadmintopnews = new ArrayList<>();
        listadmintopnews.add(admin_dao.getAdminByID(news.getCreatedBy()));
        req.setAttribute("news", news);
        req.setAttribute("adminName", listadmintopnews.get(0).getName());
        req.getRequestDispatcher("viewNews.jsp").forward(req, resp);
        }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       this.doGet(req, resp);
    }

}
