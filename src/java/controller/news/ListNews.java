/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.news;

import entity.AboutType;
import entity.Category;
import entity.CompanyContact;
import entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.AboutDAO;
import model.CategoryDAO;
import model.ContactDAO;
import model.NewsDAO;

/**
 *
 * @author asus
 */
@WebServlet(name = "ListNews", urlPatterns = {"/listNews"})

public class ListNews extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NewsDAO newsD = new NewsDAO();
        List<News> listAllNews = newsD.getTop5NewsApproved();

        req.setAttribute("listNews", listAllNews);
        controller.share.NewServlet.headerFooter(req);
        req.getRequestDispatcher("listNews.jsp").forward(req, resp);

    }
}
