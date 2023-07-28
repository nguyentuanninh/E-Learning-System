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
import model.FollowUsDAO;
import model.NewsDAO;
import utilities.NoticeNews;

/**
 *
 * @author asus
 */
@WebServlet(name = "listNewsUnapprove", urlPatterns = {"/listNewsUnapprove"})
public class ListNewsUnapprove extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NewsDAO newsD = new NewsDAO();
        String isSendEmail = req.getParameter("changevalue");
        if(isSendEmail == null) isSendEmail = "1";
        if (req.getParameter("Accept") != null) {
            String newsid = req.getParameter("id");

            int id = 0;
            try {
                id = Integer.parseInt(newsid);
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }

            newsD.updateNewsStatus(id, 1);
            if (Integer.parseInt(isSendEmail) == 1) {
                FollowUsDAO fud = new FollowUsDAO();
                List<String> fu = fud.listMail();
                NoticeNews nn = new NoticeNews();
                News news = newsD.getNewsById(id);
                nn.sendEmail(fu, "New News", nn.NewsContent(news));
            }
        }

        if (req.getParameter("Reject") != null) {
            String newsid = req.getParameter("id");
            int id = 0;
            try {
                id = Integer.parseInt(newsid);
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            newsD.updateNewsStatus(id, 0);
        }
        
        if (Integer.parseInt(isSendEmail) == 1) {
            resp.sendRedirect("listNewsUnapprove?isSendEmail=1");
        }
        else{
            resp.sendRedirect("listNewsUnapprove?isSendEmail=0");
        }
        
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        NewsDAO newsD = new NewsDAO();
        AdminDAO admin_dao = new AdminDAO();
        List<News> listNewsUnapproved = newsD.getNewsUnapproved();
        if (req.getParameter("search") != null && !req.getParameter("search").equals("")) {
            String search = req.getParameter("search");
            listNewsUnapproved = newsD.searchNews(search, 1);
        } else {
            listNewsUnapproved = newsD.getNewsUnapproved();
        }
        List<AdminAccount> listCreateBy = new ArrayList<>();
        for (News listNews : listNewsUnapproved) {
            listCreateBy.add(admin_dao.getAdminByID(listNews.getCreatedBy()));
        }
        //Phân trang news      
        int total = listNewsUnapproved.size();
        int elementPerPage = 5;
        int numberOfPage = (total % elementPerPage == 0) ? (total / elementPerPage) : (total / elementPerPage + 1); //Số trang
        int page;
        String xpage = req.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start = (page - 1) * elementPerPage;
        int end = Math.min((page) * elementPerPage, total);
        List<News> news = newsD.getListNewsByPage(listNewsUnapproved, start, end);
        req.setAttribute("news", news);
        req.setAttribute("page", page);
        req.setAttribute("numberOfPage", numberOfPage);
        req.setAttribute("listCreateBy", listCreateBy);
        String isSendEmail = req.getParameter("isSendEmail");
        if(isSendEmail == null || isSendEmail.equals("1")){
            req.setAttribute("isSendEmail", true);
        }
        else{
            req.setAttribute("isSendEmail", false);
        }
        req.getRequestDispatcher("listNewsUnapprove.jsp").forward(req, resp);
    }
}
