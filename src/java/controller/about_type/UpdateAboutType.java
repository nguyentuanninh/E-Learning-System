/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.about_type;

import entity.AboutType;
import entity.NewsItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.AboutDAO;
import model.AboutTypeDAO;
import model.NewsTypeDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "updateAboutType", urlPatterns = {"/updateAboutType"})
public class UpdateAboutType extends HttpServlet{
     @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        String newsTypeId = req.getParameter("id");
        int id = 0;
        try {
            id = Integer.parseInt(newsTypeId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        System.out.println(id);

        AboutTypeDAO aboutD = new AboutTypeDAO();
        AboutType abtT = aboutD.getAboutTypeById(id);
        req.setAttribute("abtT", abtT);
        req.getRequestDispatcher("updateAboutType.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        String type_vn = req.getParameter("type_vn");
        String newsTypeId = req.getParameter("id");
        int id = 0;
        try {
            id = Integer.parseInt(newsTypeId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        AboutType aboutType = new AboutType(id, type, type_vn);
        AboutTypeDAO aboutD = new AboutTypeDAO();
        aboutD.UpdateAboutType(aboutType);
        req.getRequestDispatcher("aboutType").forward(req, resp);
    }
}
