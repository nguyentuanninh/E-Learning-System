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
import java.io.PrintWriter;
import model.RechargeDAO;
import model.UserDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "updatePayment", urlPatterns = {"/updatePayment"})
public class UpdatePayment extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RechargeDAO reDAO= new RechargeDAO();
        if(request.getParameter("delete")!= null){
            int id= Integer.parseInt(request.getParameter("id"));
            reDAO.deleteRecharge(id);
            response.sendRedirect("adminPaymentError");
        }
        if(request.getParameter("edit")!= null){
            int id= Integer.parseInt(request.getParameter("id"));
            UserDAO udao= new UserDAO();
            String username= request.getParameter("username");
            if(udao.getUserByUsername(username)!= null){
                //update status and username of recharge
                reDAO.updateRechargeStatus(username, id);
                //update amout of user
                Recharge recharge= reDAO.getRechargeById(id);
                UserAccount user= udao.getUserByUsername(username);
                udao.updateAmount(user.getId(), user.getAmount()+ recharge.getAmout());
            } else{
                response.sendRedirect("adminPaymentError?error=true");
                return;
            }
            response.sendRedirect("adminPaymentError");
        }
    }

}
