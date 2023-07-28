/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.about_type;

import entity.AdminAccount;
import entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.AboutDAO;
import model.AdminDAO;
import model.NewsDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "deleteAbout", urlPatterns = {"/deleteAbout"})
public class DeleteAbout extends HttpServlet {

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
        }
        AboutDAO abtD = new AboutDAO();
        abtD.DelAbout(id);
        resp.sendRedirect("aboutManagement");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }

}
