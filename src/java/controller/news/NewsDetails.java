package controller.news;

import entity.AboutType;
import entity.AdminAccount;
import entity.Category;
import entity.CompanyContact;
import entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.AboutDAO;
import model.AboutTypeDAO;
import model.AdminDAO;
import model.CategoryDAO;
import model.ContactDAO;
import model.NewsDAO;
import utilities.SlugifyUtil;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author asus
 */
@WebServlet(name = "NewsDetails", urlPatterns = {"/newsDetails/*"})
public class NewsDetails extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ContactDAO contact_dao = new ContactDAO();
        CategoryDAO category_dao = new CategoryDAO();

        AboutDAO abD = new AboutDAO();
        AboutTypeDAO abtD = new AboutTypeDAO();
        List<AboutType> listaboutgroup = abtD.getTypeOfAbout();
        List<Category> category_lstall = category_dao.getListCategory();

        req.setAttribute("listallcategory", category_lstall);
        
        
        String urlPath = req.getPathInfo();
        String[] parts = urlPath.split("/");
        String slug = parts[parts.length - 1];
        int idNews = SlugifyUtil.getIdFormSlug(slug);
        NewsDAO newsD = new NewsDAO();
        News newsbyid = newsD.getNewsById(idNews);
        req.setAttribute("newsbyid", newsbyid);
        List<News> listtopnews = newsD.getTopNews();
        req.setAttribute("listtopnews", listtopnews);
        controller.share.NewServlet.headerFooter(req);
        AdminDAO adminD = new AdminDAO();
        List<AdminAccount> listCreateBy = new ArrayList<>();
        for (News listNews : listtopnews) {
            listCreateBy.add(adminD.getAdminByID(listNews.getCreatedBy()));
        }
        req.setAttribute("listCreateBy", listCreateBy);
        req.setAttribute("listaboutgroup", listaboutgroup);
        req.getRequestDispatcher("/newsDetails.jsp").forward(req, resp);

    }

}
