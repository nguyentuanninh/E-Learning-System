/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package slideshow;

import entity.SlideShow;
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

@MultipartConfig(
        location = "D:/learn/term_5/SWP/swp391_se1715_group3/web/images/home", // Thư mục để lưu trữ tệp tạm thời
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 50, // Kích thước tệp lớn nhất được phép tải lên (5MB)
        maxRequestSize = 1024 * 1024 * 100 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (10MB)
)
@WebServlet(name = "EditSlideShow", urlPatterns = {"/edit-slide-show"})
public class EditSlideShow extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        String id = request.getParameter("sid");
        int sid = Integer.parseInt(id);
        SlideShowDAO slideDAO = new SlideShowDAO();
        SlideShow s = slideDAO.getSlideShowById(sid);
        request.setAttribute("s", s);
        request.getRequestDispatcher("updateSlideShow.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SlideShowDAO slideDAO = new SlideShowDAO();
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String nameVn = request.getParameter("nameVn");

        int sid = Integer.parseInt(id);
        SlideShow oldSlideShow = slideDAO.getSlideShowById(sid);

        Part filePart = request.getPart("img");
        if (filePart.getSize() != 0) {
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

            slideDAO.UpdateSlideShow(new SlideShow(sid, name, nameVn, dirr + "/" + fileName, null, null, -1, -1));
        } else {
            slideDAO.UpdateSlideShow(new SlideShow(sid, name, nameVn, oldSlideShow.getImage(), null, null, -1, -1));
        }
        response.sendRedirect("slide-show");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
