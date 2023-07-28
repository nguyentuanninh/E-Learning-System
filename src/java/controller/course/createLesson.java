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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import model.CourseDAO;
import model.DocDAO;
import model.FileDAO;
import model.LessionDAO;
import model.VideoDAO;
import utilities.SlugifyUtil;

/**
 *
 * @author MSII
 */
@WebServlet(name = "createLesson", urlPatterns = {"/createLesson"})
@MultipartConfig(
        location = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/lesson", // Thư mục để lưu trữ tệp tạm thời
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 15, // Kích thước tệp lớn nhất được phép tải lên (15MB)
        maxRequestSize = 1024 * 1024 * 30 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (30MB)
)
public class createLesson extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }

        CourseDAO cdao = new CourseDAO();
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        if (cdao.AdminGetCourseById(courseId) == null) {
            response.sendRedirect("adminCourseManage");
            return;
        }
        request.setAttribute("courseId", courseId);
        if (request.getParameter("doc") != null) {
            request.getRequestDispatcher("createDocLesson.jsp").forward(request, response);
        }
        if (request.getParameter("video") != null) {
            request.getRequestDispatcher("createVideoLesson.jsp").forward(request, response);
        }
        if (request.getParameter("file") != null) {
            request.getRequestDispatcher("createFileLesson.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        request.setAttribute("courseId", courseId);
        if (request.getParameter("doc") != null) {
            //create lesson
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String content = request.getParameter("content");
            LessionDAO lDAO = new LessionDAO();
            int lessonId = lDAO.getNewLessonId() + 1;
            lDAO.createLesson(new Lession(0, courseId, title, SlugifyUtil.slugify(title, lessonId), description, "Docs", new java.sql.Date(new Date().getTime()), false));

            //create docs lesson
            int newId = lDAO.getNewLessonId();
            DocDAO docDAO = new DocDAO();
            docDAO.createLesson(new Docs(0, newId, content));
        }
        if (request.getParameter("file") != null) {
            // Lấy phần tải lên từ yêu cầu
            Part filePart = request.getPart("pdfFile");

            // Tạo tên tệp dựa trên thời gian và tên gốc của tệp
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            // Ghi nội dung của tệp vào một tệp mới trên máy chủ
            try ( OutputStream out = new FileOutputStream(new File("C:/Users/asus/Desktop/Kì 5/SWP391/swp391_se1715_group3/web/images/lesson/" + fileName))) {
                InputStream in = filePart.getInputStream();
                byte[] buffer = new byte[1024];
                int length;
                while ((length = in.read(buffer)) > 0) {
                    out.write(buffer, 0, length);
                }
                in.close();
            }

            // Lưu đường dẫn của tệp vào cơ sở dữ liệu
            String fileUrl = "/SWP391_Group3/images/lesson/" + fileName;
            //create lesson
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            LessionDAO lDAO = new LessionDAO();
            int lessonId = lDAO.getNewLessonId() + 1;
            lDAO.createLesson(new Lession(0, courseId, title, SlugifyUtil.slugify(title, lessonId), description, "File", new java.sql.Date(new Date().getTime()), false));

            //create file lesson
            int newId = lDAO.getNewLessonId();
            FileDAO fileDAO = new FileDAO();
            fileDAO.createLesson(new FileLesson(0, newId, fileUrl));
        }
        if (request.getParameter("video") != null) {
            //create lesson
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            LessionDAO lDAO = new LessionDAO();
            int lessonId = lDAO.getNewLessonId() + 1;
            lDAO.createLesson(new Lession(0, courseId, title, SlugifyUtil.slugify(title, lessonId), description, "Video", new java.sql.Date(new Date().getTime()), false));

            //create video
            String videoName = request.getParameter("name");
            String videoLink = request.getParameter("video_url");
            VideoDAO videoDAO = new VideoDAO();
            videoDAO.createVideoLesson(new Video(lessonId, lessonId, videoName, videoLink));
        }
        response.sendRedirect("addLesson?id=" + courseId);

    }

}
