/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.share;

import entity.NavFooter;
import entity.Nav_Header;
import entity.NewsGroup;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import model.ContactDAO;
import model.NavFooterDAO;
import model.NavHeaderDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "NewServlet", urlPatterns = {"/NewServlet"})
public class NewServlet extends HttpServlet {

    public static void headerFooter(HttpServletRequest request)
            throws ServletException, IOException {
        //--------------contact
        ContactDAO contactDAO = new ContactDAO();
        NewsGroup contact = contactDAO.getContact();
        contact.setChildren(contactDAO.getCompanyInfo(contact.getId()));
        request.setAttribute("pageinfo", contact);

        //---------------Header-----------------
        NavHeaderDAO headerDAO = new NavHeaderDAO();
        NewsGroup header = headerDAO.Header();
        List<Nav_Header> headerItem;
        if (header.getName() != null) {
            headerItem = headerDAO.getHeaderItem(header.getId());
            for (Nav_Header nav_Header : headerItem) {
                List<Nav_Header> navchild = headerDAO.getChildItem(nav_Header.getId());
                nav_Header.setChildren(navchild);
            }
            Nav_Header logo = headerDAO.getLogo(header.getId());
            request.setAttribute("nav_header", headerItem);
            request.setAttribute("logo", logo);
        }

        //---------------Footer---------------
        NavFooterDAO footerDAO = new NavFooterDAO();
        NewsGroup footer = footerDAO.getFooter();
        List<NavFooter> footerItem;
        if (footer.getName() != null) {
            footerItem = footerDAO.getNewsFooter(footer.getId());
            for (NavFooter navFooter : footerItem) {
                List<NavFooter> navchild = footerDAO.getChildItem(navFooter.getId());
                navFooter.setChildren(navchild);
            }
            NavFooter logo = footerDAO.getLogo(footer.getId());
            request.setAttribute("nav_footer", footerItem);
            request.setAttribute("logo_footer", logo);
        }

    }
}
