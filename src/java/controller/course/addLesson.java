/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import entity.Course;
import entity.Docs;
import entity.FileLesson;
import entity.Lession;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.CourseDAO;
import model.DocDAO;
import model.FileDAO;
import model.LessionDAO;
import model.VideoDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "addLesson", urlPatterns = {"/addLesson"})
public class addLesson extends HttpServlet {

    private static final String COURSE_ID = "courseId";

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
        request.setAttribute(COURSE_ID, courseId);

        LessionDAO lDAO = new LessionDAO();
        List<Lession> listAllLesson = lDAO.getLessionByCourseId(courseId);
        int total = listAllLesson.size();
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
        List<Lession> listLesson = lDAO.getListLessionByPage(listAllLesson, start, end);
        request.setAttribute("listLesson", listLesson);
        request.setAttribute("page", page);
        request.setAttribute("numberOfPage", numberOfPage);
        //Xog phân trang

        request.getRequestDispatcher("addLesson.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LessionDAO lDAO = new LessionDAO();

        if (request.getParameter("delete") != null) {
            int courseId = Integer.parseInt(request.getParameter(COURSE_ID));
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            Lession lesson = lDAO.getLessionById(lessonId);
            lesson.setIsDisable(true);
            lDAO.updateLesson(lesson);
            response.sendRedirect("addLesson?id=" + courseId);
        }

        if (request.getParameter("edit") != null) {
            int courseId = Integer.parseInt(request.getParameter(COURSE_ID));
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            Lession lesson = lDAO.getLessionById(lessonId);
            //check lesson is disable
            if (lesson == null) {
                response.sendRedirect("addLesson?id=" + courseId);
                return;
            }
            request.setAttribute("lesson", lesson);
            if (request.getParameter("type").equalsIgnoreCase("docs")) {
                DocDAO docDAO = new DocDAO();
                Docs doc = docDAO.getDocsByLesson(lessonId);
                request.setAttribute("doc", doc);
                request.setAttribute(COURSE_ID, courseId);
                request.getRequestDispatcher("updateDocsLesson.jsp").forward(request, response);
            }
            if (request.getParameter("type").equalsIgnoreCase("video")) {
                VideoDAO videoDAO = new VideoDAO();
                Video video = videoDAO.getVideoByLessonId(lessonId);
                request.setAttribute("video", video);
                request.setAttribute(COURSE_ID, courseId);
                request.getRequestDispatcher("updateVideoLesson.jsp").forward(request, response);
            }
            if (request.getParameter("type").equalsIgnoreCase("file")) {
                FileDAO fileDAO = new FileDAO();
                FileLesson file = fileDAO.getFileByLesson(lessonId);
                request.setAttribute("file", file);
                request.setAttribute(COURSE_ID, courseId);
                request.getRequestDispatcher("updateFileLesson.jsp").forward(request, response);
            }
        }
    }

}
