/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin_comment;

import entity.CourseReview;
import entity.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import model.CourseReviewDAO;
import model.UserDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "AdminLoadMoreComment", urlPatterns = {"/AdminLoadMoreComment"})
public class AdminLoadMoreComment extends HttpServlet {

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
        SimpleDateFormat outputFormat = new SimpleDateFormat("MM-dd-yyyy");
        String courseid = request.getParameter("courseid");
        String amount = request.getParameter("exits");
        CourseReviewDAO courseReviewDAO = new CourseReviewDAO();
        List<CourseReview> courseReviews = courseReviewDAO.getNext3CourseReviewByCourseId(Integer.parseInt(courseid), Integer.parseInt(amount));
        UserDAO userDAO = new UserDAO();
        Map<Integer, UserAccount> mapUser = userDAO.getMapUserAccount();
        for (CourseReview cr : courseReviews) {
            System.out.println(cr.getReviewText());
            out.print("<tr class=\"acc\">\n"
                    + "                                            <td>" + mapUser.get(cr.getUserId()).getName() + "</td>\n"
                    + "                                            <td>" + cr.getRating() + "</td>\n"
                    + "                                            <td>" + cr.getReviewText() + "</td>\n"
                    + "                                            <td>\n"+outputFormat.format(cr.getCreatedAt()) 
                    + "                                            </td>\n"
                    + "                                            <td>\n"
                    + "                                                <a href=\"adminComment?id=" + cr.getId() + "\">\n"
                    + "                                                    <button  type=\"submit\" class=\"btn btn-danger btn-sm\" title=\"Delete\">Delete</button>\n"
                    + "                                                </a>\n"
                    + "                                            </td>\n"
                    + "                                        </tr>"
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
