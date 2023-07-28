/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course_category;

import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.CategoryDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "CourseCategory", urlPatterns = {"/course-category"})
public class CategoryManage extends HttpServlet {
    private static final String SEARCH = "search"; 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminaccount") == null) {
            response.sendRedirect("adminlogin.jsp");
            return;
        }
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> allCategory;
        if (request.getParameter(SEARCH) != null && !request.getParameter(SEARCH).equals("")) {
            String search = request.getParameter(SEARCH);
            allCategory = categoryDAO.searchCategory(search);
        } else {
            allCategory = categoryDAO.getListCategory();
        }
        int total = allCategory.size();
        int elementPerPage = 5;
        int numberOfPage = (total % elementPerPage == 0) ? (total / elementPerPage) : (total / elementPerPage + 1); //Số trang
        int page;
        String xpage = request.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start = (page - 1) * elementPerPage;
        int end = Math.min((page) * elementPerPage, total);
        List<Category> listCategory = categoryDAO.getListCategoryByPage(allCategory, start, end);
        request.setAttribute("page", page);
        request.setAttribute("numberOfPage", numberOfPage);
        request.setAttribute("listCategory", listCategory);
        request.getRequestDispatcher("categoryManage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        CategoryDAO cdao = new CategoryDAO();
        boolean delete = cdao.deleteCategory(id);
        if (delete == false) {
            response.sendRedirect("course-category?deleteFalse=true");
            return;
        }
        response.sendRedirect("course-category");

    }
}
