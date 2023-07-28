/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import entity.Category;
import entity.CompanyContact;
import entity.Course;
import entity.CourseWithCategory;
import entity.UserAccount;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.CategoryDAO;
import model.ContactDAO;
import model.CourseDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "MyCourseProfile", urlPatterns = {"/mycourseprofile/*"})
public class MyCourseProfile extends HttpServlet {

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
            HttpSession session = request.getSession();
            UserAccount loggeduser = (UserAccount) session.getAttribute("account");
            if (loggeduser == null) {
                response.sendRedirect("/SWP391_Group3/login.jsp");
            } else {
                String urlPath = request.getPathInfo();
                String[] parts = urlPath.split("/");
                String type = parts[parts.length - 1];
                CourseDAO dao = new CourseDAO();
                CategoryDAO ca_dao = new CategoryDAO();
                List<CourseWithCategory> lst = new ArrayList<>();
                List<Course> course_lst = dao.listCourseEnrolled(loggeduser.getId());
                for (Course course : course_lst) {
                    lst.add(new CourseWithCategory(course, ca_dao.getCategoryById(course.getCategory())));
                }
                request.setAttribute("listcourse", lst);
                System.out.println("1");
                controller.share.NewServlet.headerFooter(request);
                if (type.equalsIgnoreCase("myCourse")) {
                    request.getRequestDispatcher("/headermycourse.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/mycourseprofile.jsp").forward(request, response);
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
