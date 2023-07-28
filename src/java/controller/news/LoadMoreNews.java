/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.news;

import entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import model.NewsDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "LoadMoreNews", urlPatterns = {"/LoadMoreNews"})
public class LoadMoreNews extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        NewsDAO newsD = new NewsDAO();
        SimpleDateFormat outputFormat = new SimpleDateFormat("MM-dd-yyyy");
        String amount = request.getParameter("exits");
        List<News> listAllNews = newsD.getNext5NewsApproved(Integer.parseInt(amount));
        PrintWriter out = response.getWriter();
        for (News lca : listAllNews) {
            out.println("<div class=\"acc row mb-3\" style=\"border: 2px solid #e8e8e8; border-radius: 16px;padding: 10px; width: 100%\">\n"
                    + "                                    <div class=\"col-lg-4 wow fadeInUp \" data-wow-delay=\"0.1s\">\n"
                    + "                                        <div class=\"d-flex align-items-center justify-content-center\" style=\"height: 100%\">\n"
                    + "                                            <img src=\"" + lca.getImage() + "\" alt=\"images\" class=\"img-fluid\"\n"
                    + "                                                 style=\"width: 100%;border-radius: 15px;\">\n"
                    + "                                        </div>\n"
                    + "\n"
                    + "                                    </div>\n"
                    + "                                    <div class=\"col-lg-8 wow fadeInUp\" data-wow-delay=\"0.5s\">\n"
                    + "                                        <div class=\"h-100\">\n"
                    + "\n"
                    + "                                            <h3 style=\"color: black\" ><a class=\"display-6\"\n"
                    + "                                                                         href=\"newsDetails/" + lca.getSlug() + "\" style=\"color: black; font-weight: bold\">" + lca.getTitle() + "</a>\n"
                    + "                                            </h3>\n"
                    + "                                            <div style=\"height: 120px; overflow: hidden\">\n"
                    + "                                                <p class=\" fs-5 mb-4\">" + lca.getDescription() + "</p>\n"
                    + "                                            </div>\n"
                    + "                                            <p style=\"color: black\">" + outputFormat.format(lca.getCreatedDate()) + "</p>\n"
                    + "\n"
                    + "                                        </div>\n"
                    + "                                    </div>\n"
                    + "                                </div>");
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
