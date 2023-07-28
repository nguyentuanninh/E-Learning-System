/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import entity.AdminAccount;
import entity.Category;
import entity.Course;
import entity.Instructor;
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
import model.CategoryDAO;
import model.CourseDAO;
import model.InstructorDAO;
import model.Instructor_courseDAO;
import utilities.SlugifyUtil;

/**
 *
 * @author MSII
 */
@WebServlet(name = "createCourse", urlPatterns = {"/createCourse"})
@MultipartConfig(
        location = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/course", // Thư mục để lưu trữ tệp tạm thời
        //C:\Users\asus\Desktop\Kì 5\SWP391\swp391_se1715_group3\web\images\course
        //D:/learn/term_5/SWP/swp391_se1715_group3/web/images/course
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 15, // Kích thước tệp lớn nhất được phép tải lên (15MB)
        maxRequestSize = 1024 * 1024 * 30 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (30MB)
)
public class createCourse extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        InstructorDAO instructorDAO = new InstructorDAO();
        List<Instructor> listInstructor = instructorDAO.listInstructor();
        request.setAttribute("listInstructor", listInstructor);

        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categoryListAll = categoryDAO.getListCategory();
        request.setAttribute("category", categoryListAll);

        request.getRequestDispatcher("createCourse.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AdminAccount adminAccount = (AdminAccount) session.getAttribute("adminaccount");

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String objective = request.getParameter("objective");
        int level = Integer.parseInt(request.getParameter("level"));
        float price = Float.parseFloat(request.getParameter("price"));
        int catogory = Integer.parseInt(request.getParameter("catogory"));

        Part filePart = request.getPart("images");
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        // Create a physical directory to store uploaded files
        String uploadDir = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/course";
        String dirr = "/SWP391_Group3/images/course";
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
        CourseDAO cdao = new CourseDAO();
        int newId = cdao.getNewCourseID() + 1;
        if (adminAccount.getType_id() == 1) {
            Course course = new Course(
                    -1,
                    name,
                    SlugifyUtil.slugify(name, newId),
                    dirr + "/" + fileName,
                    description,
                    price,
                    catogory,
                    0,
                    level,
                    objective,
                    new java.sql.Date(new Date().getTime()),
                    null,
                    -1,
                    new java.sql.Date(new Date().getTime()),
                    false);
            cdao.createCourse(course);
        } else {
            Course course = new Course(
                    -1,
                    name,
                    SlugifyUtil.slugify(name, newId),
                    dirr + "/" + fileName,
                    description,
                    price,
                    catogory,
                    0,
                    level,
                    objective,
                    new java.sql.Date(new Date().getTime()),
                    null,
                    -1,
                    null,
                    false);
            cdao.createCourse(course);
        }

        int newCourseId = cdao.getNewCourseID();
        Instructor_courseDAO icDAO = new Instructor_courseDAO();
        String[] instructors = request.getParameterValues("instructor");
        for (String instructor : instructors) {
            icDAO.createInstructorCourse(Integer.parseInt(instructor), newCourseId);
        }
        response.sendRedirect("addLesson?id=" + newCourseId);
    }
}
