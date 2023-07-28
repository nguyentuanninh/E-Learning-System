/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin_comment;

import entity.Course;
import entity.CourseReview;
import entity.UserAccount;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import model.CommentDAO;
import model.CourseDAO;
import model.CourseReviewDAO;
import model.UserDAO;

/**
 *
 * @author asus
 */
@WebServlet(name = "adminComment", urlPatterns = {"/adminComment"})
public class adminComment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CommentDAO cd = new CommentDAO();

        //xoa
        if (request.getParameter("id") != null) {
            int CourseReviewID = Integer.parseInt(request.getParameter("id"));
            cd.deleteCourseReview(CourseReviewID);
        }
        int courseId = 1;
        try {
            if (request.getParameter("courseId") != null) {
                String stringId = request.getParameter("courseId");
                courseId= Integer.parseInt(stringId);
            }
        } catch (Exception e) {
        }

        CourseReviewDAO courseReviewDAO = new CourseReviewDAO();
        List<CourseReview> listComment = courseReviewDAO.getTop3CourseReviewByCourseId(courseId);
        request.setAttribute("listComment", listComment);
        
        CourseDAO courseDAO= new CourseDAO();
        UserDAO userDAO= new UserDAO();
        Map<Integer, UserAccount> mapUser= userDAO.getMapUserAccount();
        request.setAttribute("mapUser", mapUser);
        
        Course course= courseDAO.AdminGetCourseById(courseId);
        request.setAttribute("course", course);

        request.getRequestDispatcher("adminComment.jsp").forward(request, response);
    }

}
