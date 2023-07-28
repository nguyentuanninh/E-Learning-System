/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Course;
import entity.Lession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MSII
 */
public class LessionDAO extends DBContext {

    public List<Lession> getListLessionByPage(List<Lession> list, int start, int end) {
        List<Lession> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public int getNewLessonId() {
        int id = 0;
        try {
            PreparedStatement st = connection.prepareStatement("SELECT IDENT_CURRENT('lessons')");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return id;
    }

    public List<Lession> getLessionByCourseId(int courseId) {
        Lession lession = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Lession> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM lessons WHERE course_id = ? and isDisable= 'false'";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, courseId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                lession = new Lession();
                lession.setId(rs.getInt("id"));
                lession.setCourseId(rs.getInt("course_id"));
                lession.setSlug(rs.getString("slug"));
                lession.setTitle(rs.getString("title"));
                lession.setDescription(rs.getString("description"));
                lession.setType(rs.getString("lessons_type"));
                lession.setCreatedAt(rs.getDate("created_at"));
                lession.setIsDisable(rs.getBoolean("isDisable"));
                list.add(lession);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Lession getLessionById(int Id) {
        Lession lession = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT * FROM lessons WHERE id = ? and isDisable= 'false'";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, Id);
            rs = stmt.executeQuery();
            while (rs.next()) {
                lession = new Lession();
                lession.setId(rs.getInt("id"));
                lession.setCourseId(rs.getInt("course_id"));
                lession.setTitle(rs.getString("title"));
                lession.setSlug(rs.getString("slug"));
                lession.setDescription(rs.getString("description"));
                lession.setType(rs.getString("lessons_type"));
                lession.setCreatedAt(rs.getDate("created_at"));
                lession.setIsDisable(rs.getBoolean("isDisable"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lession;
    }

    public void updateLesson(Lession lesson) {
        PreparedStatement stmt = null;

        try {
            // Create SQL statement with parameters
            String sql = "UPDATE lessons SET title=?,[description]=?, lessons_type=?, isDisable=?,  slug=? WHERE id=?";

            // Create prepared statement with SQL statement and parameters
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, lesson.getTitle());
            stmt.setString(2, lesson.getDescription());
            stmt.setString(3, lesson.getType());
            stmt.setBoolean(4, lesson.isIsDisable());
            stmt.setString(5, lesson.getSlug());
            stmt.setInt(6, lesson.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Handle any errors that may occur
            e.printStackTrace();
        }
    }

    public void createLesson(Lession lesson) {
        PreparedStatement stmt = null;

        try {
            // Create SQL statement with parameters
            String sql = "insert into lessons(course_id, title, description, lessons_type, slug) "
                    + "values (?,?,?,?, ?)";

            // Create prepared statement with SQL statement and parameters
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, lesson.getCourseId());
            stmt.setString(2, lesson.getTitle());
            stmt.setString(3, lesson.getDescription());
            stmt.setString(4, lesson.getType());
            stmt.setString(5, lesson.getSlug());
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Handle any errors that may occur
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        LessionDAO lDAO = new LessionDAO();
        System.out.println(lDAO.getLessionById(6).getTitle());
    }
}
