/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

/**
 *
 * @author MSII
 */
public class CategoryDAO extends DBContext {

    PreparedStatement ps = null;
    ResultSet rs = null;

    public int getNewCategoryId() {
        int id = 0;
        try {
            PreparedStatement st = connection.prepareStatement("SELECT IDENT_CURRENT('categories')");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (Exception e) {
            Logger.getLogger(e.getMessage());
        }
        return id;
    }

    public Map<Integer, Category> getMapCategory() {
        Map<Integer, Category> list = new HashMap<>();
        String sql = "select * from categories";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category(rs.getInt("id"), rs.getString("name"), rs.getString("name_vn"), rs.getString("slug"), rs.getString("img"), rs.getString("description"));
                list.put(rs.getInt(1), category);
            }
            connection.close();
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList< Category> getListCategory() {
        ArrayList<Category> list = new ArrayList<>();
        String sql = "select * from categories";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setSlug(rs.getString("slug"));
                category.setName(rs.getString("name"));
                category.setName_vn(rs.getString("name_vn"));
                category.setImg(rs.getString("img"));
                category.setDescription(rs.getString("description"));
                list.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList< Category> searchCategory(String name) {
        ArrayList<Category> list = new ArrayList<>();
        String sql = "select * from categories";
        if (!name.equals("")) {
            sql = sql + "  where name like '%" + name + "%'";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setSlug(rs.getString("slug"));
                category.setName(rs.getString("name"));
                category.setName_vn(rs.getString("name_vn"));
                category.setImg(rs.getString("img"));
                category.setDescription(rs.getString("description"));
                list.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Category> listPopularCategory(int option) {
        List<Category> c = new ArrayList<>();
        String sql;
        if (option == 1) {
            sql = "select * from \n"
                    + "(select top (3) categories, Count(categories) as numberofcategories from courses c inner join enrollments e on c.id = e.course_id group by  categories order by  numberofcategories desc)\n"
                    + "as T inner join categories as ca on T.categories = ca.id ";
        }
        else{
            sql = "Select Top(3) * from categories";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setSlug(rs.getString("slug"));
                category.setName(rs.getString("name"));
                category.setName_vn(rs.getString("name_vn"));
                category.setDescription(rs.getString("description"));
                c.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public Category getCategoryById(int id) {
        Category ca = new Category();
        String sql = "select * from categories where id = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ca.setId(rs.getInt("id"));
                ca.setSlug(rs.getString("slug"));
                ca.setName(rs.getString("name"));
                ca.setName_vn(rs.getString("name_vn"));
                ca.setDescription(rs.getString("description"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ca;
    }

    public Category getCategoryBySlug(String slug) {
        Category ca = new Category();
        String sql = "select * from categories where slug = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, slug);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ca.setId(rs.getInt("id"));
                ca.setSlug(rs.getString("slug"));
                ca.setName(rs.getString("name"));
                ca.setName_vn(rs.getString("name_vn"));
                ca.setImg(rs.getString("img"));
                ca.setDescription(rs.getString("description"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ca;
    }

    public List<Category> getListCategoryByPage(List<Category> list, int start, int end) {
        List<Category> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public void addCategory(Category c) {
        String sql = "insert into categories(slug, img, name, description, name_vn) values (?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, c.getSlug());
            ps.setString(2, c.getImg());
            ps.setString(3, c.getName());
            ps.setString(4, c.getDescription());
            ps.setString(5, c.getName_vn());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCategory(Category c) {
        String sql = " update categories set slug=?, img= ?, name= ?, description= ?, name_vn=? where id= ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, c.getSlug());
            ps.setString(2, c.getImg());
            ps.setString(3, c.getName());
            ps.setString(4, c.getDescription());
            ps.setString(5, c.getName_vn());
            ps.setInt(6, c.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public boolean deleteCategory(int iid) {
        String sql = "DELETE FROM [categories] WHERE id =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, iid);
            int row = ps.executeUpdate();
            if (row == 0) {
                return false;
            }

            return true;
        } catch (Exception e) {
        }
        return false;
    }
}
