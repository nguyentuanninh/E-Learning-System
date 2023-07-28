/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.InstructorDAO;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "DeleteInstructor", urlPatterns = {"/delete-instructor"})
public class DeleteInstructor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        int id = Integer.parseInt(request.getParameter("iid"));
        InstructorDAO idao = new InstructorDAO();
        boolean delete= idao.DeleteInstructor(id);
        if(delete== false){
            response.sendRedirect("instructor-manage?deleteFalse=true");
            return;
        }
        response.sendRedirect("instructor-manage");
    }

}
