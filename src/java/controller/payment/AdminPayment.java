/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.payment;

import entity.Recharge;
import entity.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import model.RechargeDAO;
import model.UserDAO;
/**
 *
 * @author MSII
 */
@WebServlet(name = "adminPayment", urlPatterns = {"/adminPayment"})
public class AdminPayment extends HttpServlet {
    private static final String SEARCH = "search"; 
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RechargeDAO rechargeDAO= new RechargeDAO();
        
        List<Recharge> listAllRecharge;
        if (request.getParameter(SEARCH) != null && !request.getParameter(SEARCH).equals("")) {
            String search = request.getParameter(SEARCH);
            listAllRecharge= rechargeDAO.searchSuccessRecharge(search);
        } else {
            listAllRecharge = rechargeDAO.listSuccessRecharge();
        }
        

        //Phân trang course
        int total = listAllRecharge.size();
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
        int end = Math.min((page) * elementPerPage, total);
        List<Recharge> listRecharge = rechargeDAO.getListCourseByPage(listAllRecharge, start, end);
        request.setAttribute("page", page);
        request.setAttribute("numberOfPage", numberOfPage);
        //Xog phân trang

        request.setAttribute("listRecharge", listRecharge);
        
        UserDAO userDAO= new UserDAO();
        Map<Integer, UserAccount> userMap= userDAO.getMapUserAccount();
        request.setAttribute("userMap", userMap);
        request.getRequestDispatcher("adminPayment.jsp").forward(request, response);
    }
}
