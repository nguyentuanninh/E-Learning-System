/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course.comment;

import entity.CourseReview;
import entity.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import model.CourseReviewDAO;
import model.UserDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "loadMoreComment", urlPatterns = {"/loadMoreComment"})
public class loadMoreComment extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        String courseid = request.getParameter("courseid");
        String amount = request.getParameter("exits");
        CourseReviewDAO courseReviewDAO = new CourseReviewDAO();
        List<CourseReview> courseReviews = courseReviewDAO.getNext3CourseReviewByCourseId(Integer.parseInt(courseid), Integer.parseInt(amount));
        UserDAO userDAO = new UserDAO();
        Map<Integer, UserAccount> mapUser = userDAO.getMapUserAccount();
        for (CourseReview cr : courseReviews) {
            System.out.println(cr.getReviewText());
            out.print("<div class=\"acc media g-mb-30 media-comment\">\n"
                    + "                                                <img class=\"d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15\" src=\"https://bootdey.com/img/Content/avatar/avatar7.png\" alt=\"Image Description\">\n"
                    + "                                                <div class=\"media-body u-shadow-v18 g-bg-secondary g-pa-30\">\n"
                    + "                                                    <div class=\"row\">\n"
                    + "                                                        <div class=\"col-6\"><div class=\"g-mb-15\">\n"
                    + "                                                                <h6 class=\"h6 g-color-gray-dark-v1 mb-0 text-black\">" + mapUser.get(cr.getUserId()).getName() + "</h6>\n"
                    + "                                                                <c:forEach begin=\"1\" end=\"" + cr.getRating() + "\">\n"
                    + "                                                                    <i class=\"fa-sharp fa-solid fa-star fa-2xs\" style=\"color: #51be78;\"></i>\n"
                    + "                                                                </c:forEach>\n"
                    + "                                                            </div></div>\n"
                    + "                                                        <div class=\"col-6\"><div class=\"g-mb-15\" style=\"text-align: right\">\n"
                    + "                                                                <span class=\"g-color-gray-dark-v4 g-font-size-12\" >" + cr.getCreatedAt() + "</span>\n"
                    + "                                                            </div></div>\n"
                    + "                                                    </div>\n"
                    + "\n"
                    + "\n"
                    + "                                                    <p>" + cr.getReviewText() + "</p>\n"
                    + "\n"
                    + "                                                </div>\n"
                    + "                                            </div>"
            );
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
