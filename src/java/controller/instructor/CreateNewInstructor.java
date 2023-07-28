/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

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
import model.InstructorDAO;
import utilities.SlugifyUtil;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "CreateNewInstructor", urlPatterns = {"/add-instructor"})
@MultipartConfig(
        //        D:/ki5/swp391_se1715_group3/web/images/instructors
        location = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/instructors", // Thư mục để lưu trữ tệp tạm thời
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 15, // Kích thước tệp lớn nhất được phép tải lên (15MB)
        maxRequestSize = 1024 * 1024 * 30 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (30MB)
)
public class CreateNewInstructor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        request.getRequestDispatcher("createInstructor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String bio = request.getParameter("bio");
        String job = request.getParameter("job");

        Part filePart = request.getPart("img");
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        // Create a physical directory to store uploaded files
        String uploadDir = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/instructors";
        String dirr = "/SWP391_Group3/images/instructors";
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

        InstructorDAO intt = new InstructorDAO();
        int newId = intt.getNewInstructorId() + 1;
        intt.AddInstructor(email, SlugifyUtil.slugify(name, newId), dirr + "/" + fileName, name, bio, job);
        response.sendRedirect("instructor-manage");
    }

}
