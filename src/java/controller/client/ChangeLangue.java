/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author MSII
 */
@WebServlet(name = "ChangeLangue", urlPatterns = {"/language"})
public class ChangeLangue extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String lang = request.getParameter("value");
        if (lang.equals("vi_VN")) {
            session.setAttribute("language", "vi_VN");
        } else {
            session.setAttribute("language", "");
        }
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer);

    }

}
