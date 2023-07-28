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
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.CategoryDAO;
import model.CourseDAO;
import model.FollowUsDAO;
import model.Instructor_courseDAO;
import utilities.NoticeNews;

/**
 *
 * @author MSII
 */
@WebServlet(name = "adminPendingCourse", urlPatterns = {"/admin-pending-course"})
public class adminPendingCourse extends HttpServlet {

    private static final String SEARCH = "search";
    private static final String IS_SEND_EMAIL = "isSendEmail";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        AdminAccount adminAccount = (AdminAccount) session.getAttribute("adminaccount");
        if (adminAccount.getType_id() != 1) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }

        CourseDAO courseDAO = new CourseDAO();

        List<Course> allPendingCourse;
        if (request.getParameter(SEARCH) != null && !request.getParameter(SEARCH).equals("")) {
            String search = request.getParameter(SEARCH);
            allPendingCourse = courseDAO.searchPendingCourse(search);
        } else {
            allPendingCourse = courseDAO.listPendingCourse();
        }

        int total = allPendingCourse.size();
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
        List<Course> pendingCourse = courseDAO.getListCourseByPage(allPendingCourse, start, end);
        request.setAttribute("page", page);
        request.setAttribute("numberOfPage", numberOfPage);
        request.setAttribute("pendingCourses", pendingCourse);

        CategoryDAO categoryDAO = new CategoryDAO();
        Map<Integer, Category> mapcategory = categoryDAO.getMapCategory();
        request.setAttribute("mapcategory", mapcategory);

        Instructor_courseDAO icDAO = new Instructor_courseDAO();
        Map<Integer, List<Instructor>> mapInstructor = new HashMap<>();
        for (Course c : allPendingCourse) {
            mapInstructor.put(c.getId(), icDAO.getInstructorOfCourse(c.getId()));
        }
        request.setAttribute("mapInstructor", mapInstructor);
        String isSendEmail = request.getParameter(IS_SEND_EMAIL);

        request.setAttribute(IS_SEND_EMAIL, isSendEmail == null || isSendEmail.equals("1"));
        
        request.getRequestDispatcher("adminPendingCourse.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO cdao = new CourseDAO();
        String isSendEmail = request.getParameter("changevalue");
        if (isSendEmail == null) {
            isSendEmail = "1";
        }
        if (request.getParameter("Accept") != null) {
            String id = request.getParameter("courseID");
            int courseID = Integer.parseInt(id);
            cdao.approveCourse(courseID);
            if (Integer.parseInt(isSendEmail) == 1) {
                NoticeNews nn = new NoticeNews();
                FollowUsDAO fud = new FollowUsDAO();
                List<String> fu = fud.listMail();
                nn.sendEmail(fu, "New Course", nn.CourseContent(cdao.getCourseById(courseID)));
            }
        }

        if (request.getParameter("Reject") != null) {
            String id = request.getParameter("courseID");
            int courseID = Integer.parseInt(id);
            cdao.deleteCourse(courseID);
        }
        if (Integer.parseInt(isSendEmail) == 1) {
            response.sendRedirect("admin-pending-course?isSendEmail=1");
        } else {
            response.sendRedirect("admin-pending-course?isSendEmail=0");
        }
    }

}
