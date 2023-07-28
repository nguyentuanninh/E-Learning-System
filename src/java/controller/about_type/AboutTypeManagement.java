package controller.about_type;

import entity.AboutType;
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
import model.AboutTypeDAO;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "aboutType", urlPatterns = {"/aboutType"})
public class AboutTypeManagement extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        AboutTypeDAO aboutD = new AboutTypeDAO();
        List<AboutType> aboutType;
        if (req.getParameter("search") != null && !req.getParameter("search").equals("")) {
            String search = req.getParameter("search");
            aboutType= aboutD.SearchTypeOfAbout(search);
        } else {
            aboutType = aboutD.getTypeOfAbout();
        }
        
        //Phân trang news      
        int total = aboutType.size();
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
        List<AboutType> news = aboutD.getListAboutTypeByPage(aboutType, start, end);
        req.setAttribute("news", news);
        req.setAttribute("page", page);
        req.setAttribute("numberOfPage", numberOfPage);
        //Xog phân trang
        req.getRequestDispatcher("newsAboutType.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
