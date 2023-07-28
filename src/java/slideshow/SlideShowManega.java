/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package slideshow;

import entity.SlideShow;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.SlideShowDAO;

/**
 *
 * @author ASUS
 */
    @WebServlet(name = "SlideShow", urlPatterns = {"/slide-show"})
public class SlideShowManega extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }

        SlideShowDAO slideDAO = new SlideShowDAO();
        //Phân trang       
        List<SlideShow> allSlideShow = slideDAO.listSlideShow();
        int total = allSlideShow.size();
        int elementPerPage = 5;
        int numberOfPage = (total % elementPerPage == 0) ? (total / elementPerPage) : (total / elementPerPage + 1); //Số trang
        int page;
        String xpage = request.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start = (page - 1) * elementPerPage;
        int end = Math.min((page) * elementPerPage  , total );
        List<SlideShow> ol = slideDAO.getSlideShowByCourseId(allSlideShow, start, end);
        request.setAttribute("page", page);
        request.setAttribute("numberOfPage", numberOfPage);
        request.setAttribute("ol", ol);
        String deleteFalse = request.getParameter("delete-false");
        if (deleteFalse != null) {
            request.setAttribute("deleteFalse", deleteFalse);
        }
        request.getRequestDispatcher("slideshow.jsp").forward(request, response);
    }
}
