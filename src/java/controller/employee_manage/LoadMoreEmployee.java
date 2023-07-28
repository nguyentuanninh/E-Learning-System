/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.employee_manage;

import entity.AdminAccount;
import entity.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import model.AdminDAO;
import model.UserDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "LoadMoreEmployee", urlPatterns = {"/LoadMoreEmployee"})
public class LoadMoreEmployee extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        SimpleDateFormat outputFormat = new SimpleDateFormat("MM-dd-yyyy");
        AdminDAO ud = new AdminDAO();
        String amount = request.getParameter("exits");
        List<AdminAccount> list = ud.getNext5Employee(Integer.parseInt(amount));
        PrintWriter out = response.getWriter();
        for (AdminAccount acc : list) {
            out.println(""
                    + "<tr class=\"acc\">\n"
                    + "                                        <td>" + acc.getUsername() + "</td>\n"
                    + "                                        <td>" + acc.getName() + "</td>\n"
                    + "                                        <td>" + acc.getEmail() + "</td>\n"
                    + "                                        <td>" + acc.getPhone()+ "</td>\n"
                    + "                                        <td>\n" + outputFormat.format(acc.getCreated_at())
                    + "                                        </td>\n"
                    + (!acc.isDisabled() ? "<td class=\"text-success\">Enable</td>\n" : "<td class=\"text-danger\">Disable</td>\n")
                    + (!acc.isDisabled() ? "<td>\n"
                    + "                                                <form\n"
                    + "                                                    action=\"adminManageUser?idUser=" + acc.getId() + "&Disabled='true'\"\n"
                    + "                                                    method=\"POST\" class=\"d-inline\">\n"
                    + "                                                    <button type=\"submit\"\n"
                    + "                                                            class=\"btn btn-danger btn-sm btn-circle border-0\"\n"
                    + "                                                            title=\"Disable\">\n"
                    + "                                                        <i class=\"fa-solid fa-circle-xmark\"></i>\n"
                    + "                                                    </button>\n"
                    + "                                                </form>\n"
                    + "                                                <a href=\"resetPasswordUser?id=" + acc.getId() + "&username=" + acc.getUsername() + "\"\n"
                    + "                                                   class=\"btn btn-primary btn-sm btn-circle\"\n"
                    + "                                                   title=\"Reset Password\">\n"
                    + "                                                    <i class=\"fa-solid fa-pen-to-square\"></i>\n"
                    + "                                                </a>\n"
                    + "                                            </td>\n"
                    : "<td>\n"
                    + "                                                <form\n"
                    + "                                                    action=\"adminManageUser?idUser=" + acc.getId() + "&Enabled='true'\"\n"
                    + "                                                    method=\"POST\" class=\"d-inline\">\n"
                    + "                                                    <button type=\"submit\"\n"
                    + "                                                            class=\"btn btn-success btn-sm btn-circle border-0\"\n"
                    + "                                                            title=\"Enable\">\n"
                    + "                                                        <i\n"
                    + "                                                            class=\"fa-sharp fa-solid fa-circle-check\"></i>\n"
                    + "                                                    </button>\n"
                    + "                                                </form>\n"
                    + "                                                <a href=\"resetPasswordUser?id=" + acc.getId() + "&username=" + acc.getUsername() + "\"\n"
                    + "                                                   class=\"btn btn-primary btn-sm btn-circle\"\n"
                    + "                                                   title=\"Reset Password\">\n"
                    + "                                                    <i class=\"fa-solid fa-pen-to-square\"></i>\n"
                    + "                                                </a>\n"
                    + "\n"
                    + "                                            </td>\n")
                    + "\n"
                    + "                                    </tr>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
