/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.*;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Home", urlPatterns = {"/home"})
public class Home extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            //------------SlideShow------------------
            SlideShowDAO slideshowDAO = new SlideShowDAO();
            NewsGroup newsgroupslide = slideshowDAO.getNewsGroupSlide();
            List<SlideShow> slideshowList = slideshowDAO.getSlide(newsgroupslide.getId());
            request.setAttribute("slide", slideshowList);

            //--------------Category-----------------
            CategoryDAO categoryDAO = new CategoryDAO();
            CourseDAO courseDAO = new CourseDAO();
            List<CourseWithCategory> cwcList = new ArrayList<>();
            List<Course> courseList = courseDAO.listPopularCourse();
            for (Course course : courseList) {
                cwcList.add(new CourseWithCategory(course, categoryDAO.getCategoryById(course.getCategory())));
            }
            List<Category> categoryList = categoryDAO.listPopularCategory(1);
            if (categoryList.isEmpty() || categoryList.size() < 3) {
                categoryList = categoryDAO.listPopularCategory(2);
            }
            request.setAttribute("listcourse", cwcList);
            request.setAttribute("listcategory", categoryList);

            //------------------Instructor----------------
            InstructorDAO instrucorDAO = new InstructorDAO();
            List<Instructor> instructorList = instrucorDAO.listInstructor();
            request.setAttribute("listinstructor", instructorList);

            //--------------contact
            ContactDAO contactDAO = new ContactDAO();
            NewsGroup contact = contactDAO.getContact();
            contact.setChildren(contactDAO.getCompanyInfo(contact.getId()));
            request.setAttribute("pageinfo", contact);
            //---------------About, Slogan------------------
            AboutDAO abtD = new AboutDAO();
            List<AboutUs> abtUs = abtD.AboutUs();
            List<AboutUs> slg = abtD.SloganNews();
            request.setAttribute("abtUs", abtUs);
            request.setAttribute("slg", slg);
            //---------------News-------------------
            NewsDAO newsD = new NewsDAO();
            List<News> lnews = newsD.getTopNews();
            request.setAttribute("lnews", lnews);
            //---------------Admin-----------------
            AdminDAO adminD = new AdminDAO();
            List<AdminAccount> listCreateBy = new ArrayList<>();
            for (News listNews : lnews) {
                listCreateBy.add(adminD.getAdminByID(listNews.getCreatedBy()));
            }
            request.setAttribute("listCreateBy", listCreateBy);
            //---------------Header-----------------
            NavHeaderDAO headerDAO = new NavHeaderDAO();
            NewsGroup header = headerDAO.Header();
            List<Nav_Header> headerItem;
            if (header.getName() != null) {
                headerItem = headerDAO.getHeaderItem(header.getId());
                if (headerItem != null && !headerItem.isEmpty()) {
                    for (Nav_Header nav_Header : headerItem) {
                        List<Nav_Header> navchild = headerDAO.getChildItem(nav_Header.getId());
                        nav_Header.setChildren(navchild);
                    }
                }
                Nav_Header logo = headerDAO.getLogo(header.getId());
                request.setAttribute("nav_header", headerItem);
                request.setAttribute("logo", logo);
            }

            //---------------Footer---------------
            NavFooterDAO footerDAO = new NavFooterDAO();
            NewsGroup footer = footerDAO.getFooter();
            List<NavFooter> footerItem;
            if (footer.getName() != null) {
                footerItem = footerDAO.getNewsFooter(footer.getId());
                if (footerItem != null && !footerItem.isEmpty()) {
                    for (NavFooter navFooter : footerItem) {
                        List<NavFooter> navchild = footerDAO.getChildItem(navFooter.getId());
                        navFooter.setChildren(navchild);
                    }
                }
                NavFooter logo = footerDAO.getLogo(footer.getId());
                request.setAttribute("nav_footer", footerItem);
                request.setAttribute("logo_footer", logo);
            }
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
