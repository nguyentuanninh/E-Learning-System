/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import entity.Course;
import entity.CourseReview;
import entity.Docs;
import entity.FileLesson;
import entity.Lession;
import entity.UserAccount;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import model.CourseDAO;
import model.CourseReviewDAO;
import model.DocDAO;
import model.FileDAO;
import model.LessionDAO;
import model.UserDAO;
import model.VideoDAO;
import utilities.SlugifyUtil;

/**
 *
 * @author MSII
 */
@WebServlet(name = "WatchCourse", urlPatterns = {"/learn/*"})
public class WatchCourse extends HttpServlet {

    private static final String LESSON = "lesson";
    private static final String REVIEW = "review";
    private static final String CONTENT = "content";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect("/SWP391_Group3/login.jsp");
            return;
        }
        UserAccount user = (UserAccount) session.getAttribute("account");

        CourseDAO courseDAO = new CourseDAO();
        LessionDAO lessonDAO = new LessionDAO();

        String urlPath = request.getPathInfo();
        String[] parts = urlPath.split("/");
        String slug = parts[parts.length - 1];
        int idCourse = SlugifyUtil.getIdFormSlug(slug);
        Course course = courseDAO.getCourseById(idCourse);
        //check quyền truy cập vào khóa học
        List<Course> listCourseOfUser = courseDAO.listCourseEnrolled(user.getId());
        if (!containsCourse(listCourseOfUser, idCourse)) {
            response.sendRedirect("/SWP391_Group3/home");
            return;
        }
        List<Lession> listLesson = lessonDAO.getLessionByCourseId(idCourse);
        if (listLesson.size() < 1) {
            response.sendRedirect("/SWP391_Group3/home");
            return;
        }
        request.setAttribute("course", course);
        request.setAttribute("listLesson", listLesson);

        //lesson content
        String id = request.getParameter("id");
        int lessonId;
        if (id == null) {
            lessonId = 1;
        } else {
            lessonId = Integer.parseInt(id);
        }
        //check id of lesson
        if (lessonId > listLesson.size()) {
            String uri = request.getScheme() + "://"
                    + request.getServerName()
                    + ":"
                    + request.getServerPort()
                    + request.getRequestURI()
                    + "?id=" + listLesson.size();
            response.sendRedirect(uri);
            return;
        } else if (lessonId < 1) {
            String uri = request.getScheme() + "://"
                    + request.getServerName()
                    + ":"
                    + request.getServerPort()
                    + request.getRequestURI()
                    + "?id=1";
            response.sendRedirect(uri);
            return;
        }
        //End check id
        lessonId = listLesson.get(lessonId - 1).getId();
        Lession lesson = lessonDAO.getLessionById(lessonId);
        request.setAttribute(LESSON, lesson);
        if (null != lesson.getType()) {
            switch (lesson.getType()) {
                case "Docs":
                    DocDAO docDAO = new DocDAO();
                    Docs docs = docDAO.getDocsByLesson(lessonId);
                    request.setAttribute(CONTENT, docs);
                    break;
                case "Video":
                    VideoDAO videoDAO = new VideoDAO();
                    Video video = videoDAO.getVideoByLessonId(lessonId);
                    request.setAttribute(CONTENT, video);
                    break;
                case "File":
                    FileDAO fileDAO = new FileDAO();
                    FileLesson file = fileDAO.getFileByLesson(lessonId);
                    request.setAttribute(CONTENT, file);
                    break;
                default:
                    break;
            }
        }
        CourseReviewDAO courseReviewDAO = new CourseReviewDAO();
        List<CourseReview> courseReviews = courseReviewDAO.getCourseReviewByCourseId(course.getId());
        request.setAttribute("courseReviews", courseReviews);
        String review = request.getParameter(REVIEW);
        if (review != null && review.equals("true")) {
            request.setAttribute(REVIEW, true);
        } else {
            request.setAttribute(REVIEW, null);
        }
        UserDAO userDAO = new UserDAO();
        Map<Integer, UserAccount> mapUser;
        mapUser = userDAO.getMapUserAccount();
        request.setAttribute("mapUser", mapUser);
        request.getRequestDispatcher("/courseWatch.jsp").forward(request, response);
    }

    public boolean containsCourse(final List<Course> list, final int id) {
        return list.stream().filter(o -> o.getId() == id).findFirst().isPresent();
    }

}
