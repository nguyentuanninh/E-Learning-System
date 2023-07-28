/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import entity.Category;
import entity.Course;
import entity.CourseReview;
import entity.Enrollment;
import entity.Instructor;
import entity.Lession;
import entity.Level;
import entity.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import model.CategoryDAO;
import model.CourseDAO;
import model.CourseReviewDAO;
import model.EnrollmentDAO;
import model.InstructorDAO;
import model.LessionDAO;
import model.LevelDAO;
import model.UserDAO;
import utilities.SlugifyUtil;

/**
 *
 * @author MSII
 */
@WebServlet("/course/*")
//@WebServlet(name="CourseDetail", urlPatterns={"/course/*"})
public class CourseDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String urlPath = request.getPathInfo();
        String[] parts = urlPath.split("/");
        String slug = parts[parts.length - 1];
        int id = SlugifyUtil.getIdFormSlug(slug);
        try {
            CourseDAO cdao = new CourseDAO();
            Course course = cdao.getCourseById(id);
            if (course != null) {
                request.setAttribute("course", course);

                List<Course> listRelatedCourse = cdao.listCourseByCategory(course.getCategory());
                request.setAttribute("listcourse", listRelatedCourse);

                InstructorDAO idao = new InstructorDAO();
                Instructor instructor = idao.getInstructorByCourseId(course.getId());
                request.setAttribute("instructor", instructor);

                LessionDAO lDAO = new LessionDAO();
                List<Lession> lession = lDAO.getLessionByCourseId(course.getId());
                request.setAttribute("lession", lession);

                LevelDAO levelDAO = new LevelDAO();
                Level level = levelDAO.getLevelById(course.getLevelId());
                request.setAttribute("level", level);

                EnrollmentDAO edao = new EnrollmentDAO();
                int enroll = edao.getNumberEnrollmentByCourseId(course.getId());
                request.setAttribute("enroll", enroll);

                UserAccount myAccount = (UserAccount) session.getAttribute("account");
                int userId;
                if (myAccount == null) {
                    userId = 0;
                } else {
                    userId = myAccount.getId();
                }
                Enrollment en = edao.getEnrollment(userId, id);
                boolean isEnrolled = true;
                if (en == null) {
                    isEnrolled = false;
                }
                request.setAttribute("isEnroll", isEnrolled);
                CourseReviewDAO courseReviewDAO = new CourseReviewDAO();
                List<CourseReview> courseReviews = courseReviewDAO.getTop3CourseReviewByCourseId(course.getId());
                request.setAttribute("courseReviews", courseReviews);

                CategoryDAO categoryDAO = new CategoryDAO();
                Category category = categoryDAO.getCategoryById(course.getCategory());
                request.setAttribute("category", category);

                UserDAO userDAO = new UserDAO();
                Map<Integer, UserAccount> mapUser = userDAO.getMapUserAccount();
                request.setAttribute("mapUser", mapUser);

                categoryDAO = new CategoryDAO();
                Map<Integer, Category> mapcategory = categoryDAO.getMapCategory();
                request.setAttribute("mapcategory", mapcategory);
                
                controller.share.NewServlet.headerFooter(request);

                request.getRequestDispatcher("/course_detail.jsp").forward(request, response);
            }

        } catch (Exception e) {
            response.sendRedirect("errorpage.jsp");
        }

    }
}
