/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.about_type;

import entity.AboutType;
import entity.AboutUs;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.AboutDAO;
import model.AboutTypeDAO;
import utilities.SlugifyUtil;

/**
 *
 * @author Nguyen Minh
 */
@WebServlet(name = "viewAbout", urlPatterns = {"/viewAbout/*"})
public class ViewAbout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AboutDAO abD = new AboutDAO();
        AboutTypeDAO abtD = new AboutTypeDAO();
        List<AboutType> listaboutgroup = abtD.getTypeOfAbout(); 
        String urlPath = req.getPathInfo();
        String[] parts = urlPath.split("/");
        String slug = parts[parts.length - 1];
        int typeid = SlugifyUtil.getIdFormSlug(slug);
        List<AboutUs> abt = abD.aboutUs(typeid);
        req.setAttribute("abt", abt);
        req.setAttribute("listaboutgroup", listaboutgroup);
        controller.share.NewServlet.headerFooter(req);
        req.getRequestDispatcher("/about.jsp").forward(req, resp);
       
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }

}
