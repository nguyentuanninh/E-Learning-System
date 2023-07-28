/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import entity.AdminAccount;
import entity.Category;
import entity.Course;
import entity.Instructor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.CategoryDAO;
import model.CourseDAO;
import model.Instructor_courseDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "employeeCourseManage", urlPatterns = {"/employee-course-manage"})
public class employeeCourseManage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        CourseDAO courseDAO = new CourseDAO();

        //Phân trang course        
        List<Course> allCourse = courseDAO.listCourse();
        int total = allCourse.size();
        int elementPerPage = 5;
        int numberOfPage = (total % elementPerPage == 0) ? (total / elementPerPage) : (total / elementPerPage + 1); //Số trang
        int page;
        String xpage = request.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start = (page - 1) * elementPerPage;
        int end = Math.min((page) * elementPerPage, total);
        List<Course> courses = courseDAO.getListCourseByPage(allCourse, start, end);
        request.setAttribute("courses", courses);
        request.setAttribute("page", page);
        request.setAttribute("numberOfPage", numberOfPage);
        //Xog phân trang

        CategoryDAO categoryDAO = new CategoryDAO();
        Map<Integer, Category> mapcategory = categoryDAO.getMapCategory();
        request.setAttribute("mapcategory", mapcategory);

        Instructor_courseDAO icDAO = new Instructor_courseDAO();
        Map<Integer, List<Instructor>> mapInstructor = new HashMap<>();
        for (Course c : allCourse) {
            mapInstructor.put(c.getId(), icDAO.getInstructorOfCourse(c.getId()));
        }
        request.setAttribute("mapInstructor", mapInstructor);

        request.getRequestDispatcher("employeeCourseManage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO cdao = new CourseDAO();
        if (request.getParameter("Enabled") != null) {
            String id = request.getParameter("courseID");
            int courseID = Integer.parseInt(id);
            cdao.updateCourseStatus(courseID, 0);
        }

        if (request.getParameter("Disabled") != null) {
            String id = request.getParameter("courseID");
            int courseID = Integer.parseInt(id);
            cdao.updateCourseStatus(courseID, 1);
        }
        response.sendRedirect("employee-course-manage");
    }

}
