/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.newstype;

import entity.AdminAccount;
import entity.News;
import entity.NewsGroup;
import entity.NewsItem;
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
import model.NewsTypeDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "newsType", urlPatterns = {"/newsType"})
public class NewsType extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        NewsTypeDAO newsTypeD = new NewsTypeDAO();
        List<NewsGroup> newsType;
        if (req.getParameter("search") != null && !req.getParameter("search").equals("")) {
            String search = req.getParameter("search");
            newsType= newsTypeD.SearchTypeOfNews(search);
        } else {
            newsType = newsTypeD.getTypeOfNews();
        }
        
        //Phân trang news      
        int total = newsType.size();
        int elementPerPage= 5;
        int numberOfPage= (total%elementPerPage== 0)? (total/elementPerPage): (total/elementPerPage+ 1); //Số trang
        int page;
        String xpage= req.getParameter("page");
        if(xpage== null){
            page= 1;
        } else{
            page= Integer.parseInt(xpage);
        }
        int start= (page-1)* elementPerPage;
        int end= Math.min((page)*elementPerPage, total);
        List<NewsGroup> news = newsTypeD.getListNewsTypeByPage(newsType, start, end);
        req.setAttribute("news", news);
        req.setAttribute("page", page);
        req.setAttribute("numberOfPage", numberOfPage);
        //Xog phân trang
        req.getRequestDispatcher("newsType.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
    
    
}
