/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import entity.Instructor;
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
import model.InstructorDAO;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "InstructorManage", urlPatterns = {"/instructor-manage"})
public class InstructorManage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        InstructorDAO IntDAO = new InstructorDAO();
        //Phân trang       
        List<Instructor> allInstructor = IntDAO.listInstructor();
        int total = allInstructor.size();
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
        List<Instructor> ol = IntDAO.getInstructorByCourseId(allInstructor, start, end);
        request.setAttribute("page", page);
        request.setAttribute("numberOfPage", numberOfPage);
        request.setAttribute("ol", ol);
        String deleteFalse = request.getParameter("delete-false");
        if (deleteFalse != null) {
            request.setAttribute("deleteFalse", deleteFalse);
        }

        request.getRequestDispatcher("instructorManage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        try {
//            response.setContentType("text/html;charset=UTF-8");
//            String email = request.getParameter("email");
//            String img = request.getParameter("img");
//            String name = request.getParameter("name");
//            String bio = request.getParameter("bio");
//            String job = request.getParameter("job");
//            InstructorDAO intt = new InstructorDAO();
//            intt.AddInstructor(email, "", img, name, bio, job);
//            response.sendRedirect("employee_instructor_manage");
//        } catch (Exception e) {
//            response.sendRedirect("./404.html");
//
//        }
    }
}
