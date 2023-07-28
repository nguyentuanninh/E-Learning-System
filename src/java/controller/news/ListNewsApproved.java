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
@WebServlet(name="listNewsApproved", urlPatterns={"/listNewsApproved"})
public class ListNewsApproved extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
        
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
        //search: nếu có parameter search thì get list theo giá trị search
        List<News> listNewsApprove = new ArrayList<>();
        if (req.getParameter("search") != null && !req.getParameter("search").equals("")) {
            String search = req.getParameter("search");
            listNewsApprove= newsD.searchNews(search, 0);
        } else {
            listNewsApprove = newsD.getNewsApproved();
        }
        List<AdminAccount> listCreateBy = new ArrayList<>();
        for (News listNews : listNewsApprove) {
            listCreateBy.add(admin_dao.getAdminByID(listNews.getCreatedBy()));
        }
         
        //Phân trang news      
        int total = listNewsApprove.size();
        int elementPerPage = 5;
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
        List<News> news = newsD.getListNewsByPage(listNewsApprove, start, end);
        req.setAttribute("news", news);
        req.setAttribute("page", page);
        req.setAttribute("numberOfPage", numberOfPage);
        //Xog phân trang
        req.setAttribute("listCreateBy", listCreateBy);
        req.getRequestDispatcher("listNewsApproved.jsp").forward(req, resp);
    }
}
