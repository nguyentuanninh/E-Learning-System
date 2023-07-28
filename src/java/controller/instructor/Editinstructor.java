/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import entity.Instructor;
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

@MultipartConfig(
        location = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/instructors", // Thư mục để lưu trữ tệp tạm thời
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 50, // Kích thước tệp lớn nhất được phép tải lên (5MB)
        maxRequestSize = 1024 * 1024 * 100 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (10MB)
)
@WebServlet(name = "Editinstructor", urlPatterns = {"/edit-instructor"})
public class Editinstructor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        String id = request.getParameter("iid");
        int iid = Integer.parseInt(id);
        InstructorDAO insDAO = new InstructorDAO();
        Instructor i = insDAO.getInstructorById(iid);
        request.setAttribute("i", i);
        request.getRequestDispatcher("updateInstructor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        InstructorDAO idao = new InstructorDAO();
        String id = request.getParameter("id");
        int iid = Integer.parseInt(id);
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String bio = request.getParameter("bio");
        String job = request.getParameter("job");
        Instructor oldInstructor = idao.getInstructorById(iid);

        Part filePart = request.getPart("img");
        if (filePart.getSize() != 0) {
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

            idao.UpdateInstructor(new Instructor(iid, email, SlugifyUtil.slugify(name, iid), dirr + "/" + fileName, name, bio, job));
        } else {
            idao.UpdateInstructor(new Instructor(iid, email, SlugifyUtil.slugify(name, iid), oldInstructor.getImg(), name, bio, job));
        }
        response.sendRedirect("instructor-manage");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
