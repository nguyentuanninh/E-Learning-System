/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.news;

import entity.AdminAccount;
import entity.News;
import entity.NewsGroup;
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
import java.util.Date;
import java.util.List;
import model.NewsDAO;
import model.NewsTypeDAO;
import utilities.SlugifyUtil;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "createNews", urlPatterns = {"/createNews"})
@MultipartConfig(
        location = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/news", // Thư mục để lưu trữ tệp tạm thời
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 15, // Kích thước tệp lớn nhất được phép tải lên (15MB)
        maxRequestSize = 1024 * 1024 * 30 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (30MB)
)
public class CreateNews extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        NewsTypeDAO newsTypeD = new NewsTypeDAO();
        List<NewsGroup> listtypenews = newsTypeD.getTypeOfNews();
        request.setAttribute("listtypenews", listtypenews);
        request.getRequestDispatcher("createNews.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AdminAccount account = (AdminAccount) session.getAttribute("adminaccount");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String description = request.getParameter("description");
        String newstype = request.getParameter("newsType");
        int type = 0;

        try {
            type = Integer.parseInt(newstype);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        Part filePart = request.getPart("images");
        String fileName = filePart.getSubmittedFileName();
        // Create a physical directory to store uploaded files

        String uploadDir = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/news";
        String dirr = "/SWP391_Group3/images/news";
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdir();
        }
        // Write the file to the directory
        try ( FileOutputStream outputStream = new FileOutputStream(new File(dir, fileName))) {
            InputStream inputStream = filePart.getInputStream();
            int read;
            final byte[] bytes = new byte[1024];
            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
            outputStream.flush();
        }

        NewsDAO newsD = new NewsDAO();
        int newId = newsD.getNewNavId() + 1;
        News news = new News(-1, title, content, description, SlugifyUtil.slugify(title, newId), dirr + "/" + fileName, type, new java.sql.Date(new Date().getTime()), null, account.getType_id(), -1, null);
        newsD.AddNews(news);
        request.getRequestDispatcher("listNewsUnapprove").forward(request, response);
    }

}
