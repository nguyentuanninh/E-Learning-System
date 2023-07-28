/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package controller.about_type;
import entity.AboutType;
import entity.AboutUs;
import entity.Category;
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
import model.CategoryDAO;
import model.ContactDAO;

/**
 *
 * @author Nguyen Minh
 */

@WebServlet(name = "aboutDetails", urlPatterns = {"/aboutDetails"})
public class AboutDetails extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("adminaccount") == null) {
            resp.sendRedirect("adminlogin.jsp");
            return;
        }
        AboutDAO abD = new AboutDAO();
        AboutTypeDAO abtD = new AboutTypeDAO();
        

        List<AboutType> listaboutgroup = abtD.getTypeOfAbout();
  

     
   
        String id = req.getParameter("id");
        int typeid = 0;
        try {
            typeid = Integer.parseInt(id);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        AboutUs abt = abD.getAboutById(typeid);
        req.setAttribute("abt", abt);
        req.setAttribute("listaboutgroup", listaboutgroup);
        req.getRequestDispatcher("aboutDetails.jsp").forward(req, resp);
       
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
    
    
}
