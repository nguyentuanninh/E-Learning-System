/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

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
import java.io.PrintWriter;
import model.DocDAO;
import model.FileDAO;
import model.LessionDAO;
import model.VideoDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "ViewLesson", urlPatterns = {"/view-lesson/*"})
public class ViewLesson extends HttpServlet {

    private static final String COURSE_ID = "courseId";
    private static final String LESSON = "lesson";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        try {
            int courseId = Integer.parseInt(request.getParameter(COURSE_ID));
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            LessionDAO ldao = new LessionDAO();
            Lession lesson = ldao.getLessionById(lessonId);

            if (request.getParameter("docs") != null) {
                DocDAO docDAO = new DocDAO();
                Docs docs = docDAO.getDocsByLesson(lessonId);
                request.setAttribute("docs", docs);
                request.setAttribute(LESSON, lesson);
                request.setAttribute(COURSE_ID, courseId);
                request.getRequestDispatcher("viewDocLesson.jsp").forward(request, response);
            } else if (request.getParameter("file") != null) {
                FileDAO fileDAO = new FileDAO();
                FileLesson file = fileDAO.getFileByLesson(lessonId);
                request.setAttribute("file", file);
                request.setAttribute(LESSON, lesson);
                request.setAttribute(COURSE_ID, courseId);
                request.getRequestDispatcher("viewFileLesson.jsp").forward(request, response);
            } else if (request.getParameter("video") != null) {
                VideoDAO vDAO = new VideoDAO();
                Video video = vDAO.getVideoByLessonId(lessonId);
                request.setAttribute("video", video);
                request.setAttribute(LESSON, lesson);
                request.setAttribute(COURSE_ID, courseId);
                request.getRequestDispatcher("viewVideoLesson.jsp").forward(request, response);
            }

        } catch (Exception e) {
            response.sendRedirect("admin-course-manage");
        }
    }

}
