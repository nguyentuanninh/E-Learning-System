/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CourseReviewDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DeleteReview", urlPatterns = {"/deletereview"})
public class DeleteReview extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        CourseReviewDAO review = new CourseReviewDAO();
        review.deleteReview(Integer.parseInt(id));
        String courseSlug = request.getParameter("slug");
        response.sendRedirect("learn/" + courseSlug + "?review=true");
    }
}
