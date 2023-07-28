/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

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
import java.util.List;
import model.CourseDAO;
import model.InstructorDAO;
import model.Instructor_courseDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "addInstructor", urlPatterns = {"/addInstructor"})
public class addInstructor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        int courseId = Integer.parseInt(request.getParameter("id"));
        CourseDAO courseDAO = new CourseDAO();
        Course course = courseDAO.AdminGetCourseById(courseId);
        request.setAttribute("course", course);

        InstructorDAO instructorDAO = new InstructorDAO();
        List<Instructor> listInstructor = instructorDAO.listInstructor();
        request.setAttribute("listInstructor", listInstructor);
        request.getRequestDispatcher("addInstructor.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Instructor_courseDAO icDAO = new Instructor_courseDAO();
        String[] instructors = request.getParameterValues("instructor");
        String id = request.getParameter("id");
        int courseId = Integer.parseInt(id);
        for (String instructor : instructors) {
            icDAO.createInstructorCourse(Integer.parseInt(instructor), courseId);
        }
        response.sendRedirect("addLesson?id=" + courseId);
    }

}
