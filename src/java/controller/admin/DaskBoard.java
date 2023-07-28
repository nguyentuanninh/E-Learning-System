/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import entity.Statistics;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.List;
import model.EnrollmentDAO;
import model.UtilitiesDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DaskBoard", urlPatterns = {"/dashboard"})
public class DaskBoard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Calendar calendar = Calendar.getInstance();
        response.getWriter().print("YEAR: " + calendar.get(Calendar.YEAR));
        response.getWriter().print("MONTH: " + calendar.get(Calendar.MONTH));
        EnrollmentDAO enrollDAO = new EnrollmentDAO();
        float yearIncome = enrollDAO.getYearIncome(calendar.get(Calendar.YEAR));
        float monthIncome = enrollDAO.getMonthIncome(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH)+1);
        int monthEnrolled = enrollDAO.getMonthEnrolled(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH)+1);
        int yearEnrolled = enrollDAO.getYearEnrolled(calendar.get(Calendar.YEAR));
        request.setAttribute("yearIncome", yearIncome);
        request.setAttribute("monthIncome", monthIncome);
        request.setAttribute("monthEnrolled", monthEnrolled);
        request.setAttribute("yearEnrolled", yearEnrolled);
        UtilitiesDAO utilDAO= new UtilitiesDAO();
        List<Statistics> listStatis= utilDAO.getStatistics();
        request.setAttribute("listStatis", listStatis);
        request.getRequestDispatcher("DashBoard.jsp").forward(request, response);
    }

}
