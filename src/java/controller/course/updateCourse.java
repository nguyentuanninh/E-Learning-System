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
@WebServlet(name = "updateCourse", urlPatterns = {"/updateCourse"})
@MultipartConfig(
        location = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/course", // Thư mục để lưu trữ tệp tạm thời
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 50, // Kích thước tệp lớn nhất được phép tải lên (5MB)
        maxRequestSize = 1024 * 1024 * 100 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (10MB)
)
public class updateCourse extends HttpServlet {
    
    private static final String ADMIN_ACCOUNT = "adminaccount";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute(ADMIN_ACCOUNT) == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        
        String id = request.getParameter("courseID");
        if (id == null) {
            response.sendRedirect("adminCourseManage.jsp");
        }
        int courseId = Integer.parseInt(id);
        CourseDAO courseDAO = new CourseDAO();
        Course course = courseDAO.AdminGetCourseById(courseId);
        request.setAttribute("course", course);

        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categoryListAll = categoryDAO.getListCategory();
        request.setAttribute("category", categoryListAll);

        InstructorDAO instructorDAO = new InstructorDAO();
        List<Instructor> listInstructor = instructorDAO.listInstructor();
        request.setAttribute("listInstructor", listInstructor);

        Instructor_courseDAO icDAO = new Instructor_courseDAO();
        List<Integer> listI = icDAO.getInstructorIdOfCourse(courseId);
        request.setAttribute("listI", listI);

        request.getRequestDispatcher("updateCourse.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute(ADMIN_ACCOUNT) == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        AdminAccount adminAccount = (AdminAccount) session.getAttribute(ADMIN_ACCOUNT);
        CourseDAO cdao = new CourseDAO();
        String id = request.getParameter("courseId");
        int courseId = Integer.parseInt(id);
        Course oldCourse = cdao.AdminGetCourseById(courseId);
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String objective = request.getParameter("objective");
        int level = Integer.parseInt(request.getParameter("level"));
        float price = Float.parseFloat(request.getParameter("price"));
        int catogory = Integer.parseInt(request.getParameter("catogory"));

        Part filePart = request.getPart("images");
        if (filePart.getSize() != 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            // Create a physical directory to store uploaded files
            String uploadDir = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/course";
            String dirr = "/SWP391_Group3/images/course";
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdir();
            }
            // Write the file to the directory
            try(FileOutputStream outputStream = new FileOutputStream(new File(dir, fileName))){
                InputStream inputStream = filePart.getInputStream();
            int read;
            final byte[] bytes = new byte[1024];
            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
            outputStream.flush();
            }
            
            Course course = new Course(courseId, name,
                    SlugifyUtil.slugify(name, courseId),
                    dirr + "/" + fileName,
                    description, price,
                    catogory, 0, level, objective,
                    new java.sql.Date(new Date().getTime()),
                    new java.sql.Date(new Date().getTime()),
                    adminAccount.getId(), // id session user
                    null,
                    false);
            cdao.updateCourse(course);
        } else {
            Course course = new Course(courseId, name, SlugifyUtil.slugify(name, courseId), oldCourse.getImage(), description, price, catogory, 0, level, objective,
                    new java.sql.Date(new Date().getTime()), new java.sql.Date(new Date().getTime()), adminAccount.getId()// id session user
                    ,
                     null, false);
            cdao.updateCourse(course);
        }

        Instructor_courseDAO icDAO = new Instructor_courseDAO();
        String[] instructors = request.getParameterValues("instructor");
        icDAO.deleteByCourseId(courseId);
        for (String instructor : instructors) {
            icDAO.createInstructorCourse(Integer.parseInt(instructor), courseId);
        }
        response.sendRedirect("addLesson?id=" + courseId);

    }
}
