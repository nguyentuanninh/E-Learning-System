/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.about_type;

import entity.AboutType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.AboutTypeDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "createAboutType", urlPatterns = {"/createAboutType"})
public class CreateAboutType extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        req.getRequestDispatcher("createAboutType.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        String type_vn =req.getParameter("type_vn"); 
        AboutTypeDAO aboutD = new AboutTypeDAO();
        AboutType abouttype = new AboutType(-1 ,type , type_vn);
        aboutD.AddAboutType(abouttype);
        System.out.println(abouttype);
        req.getRequestDispatcher("aboutType").forward(req, resp);
    }
}
