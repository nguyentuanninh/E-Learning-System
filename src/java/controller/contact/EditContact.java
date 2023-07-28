/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.contact;

import entity.CompanyContact;
import entity.NewsGroup;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.ContactDAO;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "EditContact", urlPatterns = {"/edit-contact"})
public class EditContact extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        ContactDAO conDAO = new ContactDAO();
        CompanyContact contact = conDAO.getCompanyContact();
        
        request.setAttribute("c", contact);
        request.getRequestDispatcher("updateContact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String phone = request.getParameter("phone");
         String email = request.getParameter("gmail");
         ContactDAO cDao = new ContactDAO();
         cDao.UpdateContact(phone , email);
         response.sendRedirect("edit-contact");
           
}

}