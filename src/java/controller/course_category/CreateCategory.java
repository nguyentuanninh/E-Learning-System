/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course_category;

import entity.Category;
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
import java.io.PrintWriter;
import model.CategoryDAO;
import model.InstructorDAO;
import utilities.SlugifyUtil;

/**
 *
 * @author MSII
 */
@WebServlet(name = "AddCategory", urlPatterns = {"/add-category"})
@MultipartConfig(
        location = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/category", // Thư mục để lưu trữ tệp tạm thời
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 15, // Kích thước tệp lớn nhất được phép tải lên (15MB)
        maxRequestSize = 1024 * 1024 * 30 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (30MB)
)
public class CreateCategory extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        request.getRequestDispatcher("createCategory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        Part filePart = request.getPart("img");
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        // Create a physical directory to store uploaded files
        String uploadDir = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/category";
        String dirr = "/SWP391_Group3/images/category";
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
        }

        CategoryDAO cDAO = new CategoryDAO();
        int newId = cDAO.getNewCategoryId() + 1;
        cDAO.addCategory(new Category(newId, name, "", SlugifyUtil.slugify(name, newId), dirr + "/" + fileName, description));
        response.sendRedirect("course-category");
    }
}
