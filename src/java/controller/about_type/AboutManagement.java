/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.about_type;

import entity.AboutUs;
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
import model.AboutDAO;
import model.AdminDAO;
import model.NewsDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "aboutManagement", urlPatterns = {"/aboutManagement"})
public class AboutManagement extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AboutDAO abtD = new AboutDAO();
        
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
    
        //search: nếu có parameter search thì get list theo giá trị search
        List<AboutUs> listabouts;
        if (req.getParameter("search") != null && !req.getParameter("search").equals("")) {
            String search = req.getParameter("search");
            listabouts= abtD.SearchAboutNews(search);
        } else {
            listabouts = abtD.AboutNews();
        }
        //Phân trang news      
        int total = listabouts.size();
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
        List<AboutUs> ab = abtD.getListAboutByPage(listabouts, start, end);
        req.setAttribute("ab", ab);
        req.setAttribute("page", page);
        req.setAttribute("numberOfPage", numberOfPage);
        //Xog phân trang
        req.getRequestDispatcher("aboutManagement.jsp").forward(req, resp);
    }
    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doPost(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
        this.doGet(req, resp);
    }
    
    
}
