/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package slideshow;

import java.io.IOException;
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
import java.io.InputStream;
import model.SlideShowDAO;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "CreateNewSilde", urlPatterns = {"/create-new-silde"})
@MultipartConfig(
        //       D:\ki5\swp391_se1715_group3\web\images\home
        //        D:/learn/term_5/SWP/swp391_se1715_group3/web/images/home
        location = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/home", // Thư mục để lưu trữ tệp tạm thời
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 15, // Kích thước tệp lớn nhất được phép tải lên (15MB)
        maxRequestSize = 1024 * 1024 * 30 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (30MB)
)
public class CreateNewSilde extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        request.getRequestDispatcher("createSlideShow.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int createdBy = Integer.parseInt(request.getParameter("create_by"));
        String name = request.getParameter("name");
        String nameVn = request.getParameter("nameVn");

        Part filePart = request.getPart("img");
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        // Create a physical directory to store uploaded files
        String uploadDir = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/home";
        String dirr = "/SWP391_Group3/images/home";
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

        SlideShowDAO slideDAO = new SlideShowDAO();
        slideDAO.AddSlideShow(dirr + "/" + fileName,
                new java.sql.Date(new java.util.Date().getTime()),
                createdBy,name, nameVn);
        response.sendRedirect("slide-show");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
