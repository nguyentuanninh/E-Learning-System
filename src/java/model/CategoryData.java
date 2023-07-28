/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Category;
import java.sql.PreparedStatement;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author Nguyen Minh
 */
public class CategoryData extends DBContext {

    public static final List<Category> listCategoties = Arrays.asList(
            new Category(1, "name", "name_vn", "slug", "img", "description"),
            new Category(2, "name", "name_vn", "slug", "img", "description"),
            new Category(3, "name", "name_vn", "slug", "img", "description"));

    public void loadCategoryData() {
        try {
            PreparedStatement prst = connection.prepareStatement(
                    "INSERT INTO NewsItem(Name, name_vn, href, slug, Created_by, Parent_id) values\n"
                    + "('Web Development', N'Lập Trình Web', '/SWP391_Group3/listcoursebycategory', '/web-development-1', 1,  8),\n"
                    + "('AI', N'Trí Tuệ Nhân Tạo', '/SWP391_Group3/listcoursebycategory', '/ai-2', 1,  8),\n"
                    + "('Mobile Development', N'Lập Trình Di Động', '/SWP391_Group3/listcoursebycategory', '/mobile-development-3', 1,  8)");
            prst.executeUpdate();
        }catch(Exception ex){
            ex.getStackTrace();
        }
    }
    
    public void dropCategoryData() {
        try {
            PreparedStatement stmt = connection.prepareStatement(
                    "DELETE FROM NewsItem"
            );
            stmt.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
