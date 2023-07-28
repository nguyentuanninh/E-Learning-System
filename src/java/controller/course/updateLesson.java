/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import entity.Category;
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
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import model.DocDAO;
import model.FileDAO;
import model.LessionDAO;
import model.VideoDAO;
import utilities.SlugifyUtil;

/**
 *
 * @author MSII
 */
@WebServlet(name = "updateLesson", urlPatterns = {"/updateLesson"})
@MultipartConfig(
        location = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/lesson", // Thư mục để lưu trữ tệp tạm thời
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 50, // Kích thước tệp lớn nhất được phép tải lên (5MB)
        maxRequestSize = 1024 * 1024 * 100 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (10MB)
)
public class updateLesson extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LessionDAO lDAO = new LessionDAO();
        DocDAO docDAO = new DocDAO();
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));

        if (request.getParameter("doc") != null) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String content = request.getParameter("content");
            lDAO.updateLesson(new Lession(lessonId, courseId, title, SlugifyUtil.slugify(title, lessonId), description, "Docs", null, false));
            docDAO.updateDocLesson(new Docs(0, lessonId, content));
        }
        if (request.getParameter("file") != null) {
            FileDAO fDAO = new FileDAO();
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            lDAO.updateLesson(new Lession(lessonId, courseId, title, SlugifyUtil.slugify(title, lessonId), description, "File", null, false));
            FileLesson oldLesson = fDAO.getFileByLesson(lessonId);

            Part filePart = request.getPart("pdfFile");
            if (filePart.getSize() != 0) {
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                // Ghi nội dung của tệp vào một tệp mới trên máy chủ
                OutputStream out = new FileOutputStream(new File("C:/Users/asus/Desktop/Kì 5/SWP391/swp391_se1715_group3/web/images/lesson/" + fileName));
                InputStream in = filePart.getInputStream();
                byte[] buffer = new byte[1024];
                int length;
                while ((length = in.read(buffer)) > 0) {
                    out.write(buffer, 0, length);
                }
                in.close();
                out.close();
                //xóa file cũ
                String pathFile = "C:/Users/asus/Desktop/Kì 5/SWP391/swp391_se1715_group3/web/images/lesson" + oldLesson.getFile_name();
                File file = new File(pathFile);
                file.delete();
                // Lưu đường dẫn của tệp vào cơ sở dữ liệu
                String fileUrl = "C:/Users/asus/Desktop/Kì 5/SWP391/swp391_se1715_group3/web/images/lesson" + fileName;
                fDAO.updateFileLesson(new FileLesson(-1, lessonId, fileUrl));
            } else {
                fDAO.updateFileLesson(new FileLesson(-1, lessonId, oldLesson.getFile_name()));
            }
        }
        if (request.getParameter("video") != null) {
            VideoDAO videoDAO= new VideoDAO();
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            lDAO.updateLesson(new Lession(lessonId, courseId, title, SlugifyUtil.slugify(title, lessonId), description, "Video", null, false));

            String videoName= request.getParameter("name");
            String videoLink= request.getParameter("video_url");
            videoDAO.updateVideoLesson(new Video(-1, lessonId, videoName, videoLink));
        }

        response.sendRedirect("addLesson?id=" + courseId);
    }

}
