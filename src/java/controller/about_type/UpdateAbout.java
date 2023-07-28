/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.about_type;

import entity.AboutType;
import entity.AboutUs;
import entity.AdminAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.AboutDAO;
import model.AboutTypeDAO;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "updateAbout", urlPatterns = {"/updateAbout"})
public class UpdateAbout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        String aboutID = req.getParameter("id");
        int ID = 0;
        try {
            ID = Integer.parseInt(aboutID);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        AboutDAO abD = new AboutDAO();
        AboutTypeDAO abtD = new AboutTypeDAO();
        AboutUs ab = abD.getAboutById(ID);
        List<AboutType> listabouttype = abtD.getTypeOfAbout();
        req.setAttribute("ab", ab);
        req.setAttribute("listabouttype", listabouttype);
        req.getRequestDispatcher("updateAbout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        AdminAccount account = (AdminAccount) session.getAttribute("adminaccount");
        String aboutId = request.getParameter("id");
        System.out.println(aboutId);
        int id = 0;
        try {
            id = Integer.parseInt(aboutId);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        String title = request.getParameter("title");
        String title_vn = request.getParameter("title_vn");
        String content = request.getParameter("content");
        String content_vn = request.getParameter("content_vn");
        String abouttype = request.getParameter("aboutType");
        int type = 0;
        try {
            type = Integer.parseInt(abouttype);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        AboutUs about = new AboutUs(id, title, title_vn, content, content_vn, null, new java.sql.Date(new java.util.Date().getTime()), type);
        AboutDAO abtD = new AboutDAO();
        System.out.println(about.getTitle() + about.getContent() + about.getAboutType() + account.getType_id());
        abtD.UpdateAbout(about);
        request.getRequestDispatcher("aboutManagement").forward(request, response);
    }
}
