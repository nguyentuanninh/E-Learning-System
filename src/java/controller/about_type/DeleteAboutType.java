/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.about_type;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.AboutDAO;
import model.AboutTypeDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "deleteAboutType", urlPatterns = {"/deleteAboutType"})
public class DeleteAboutType extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        String newsId = req.getParameter("id");
        int id = 0;
        try {
            id = Integer.parseInt(newsId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        AboutTypeDAO aboutD = new AboutTypeDAO();
        aboutD.DelAboutType(id);
        resp.sendRedirect("aboutType");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
    
}
