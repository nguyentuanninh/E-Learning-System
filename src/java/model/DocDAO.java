/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Docs;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author MSII
 */
public class DocDAO extends DBContext {

    public void createLesson(Docs docs) {
        PreparedStatement stmt = null;

        try {
            // Create SQL statement with parameters
            String sql = "insert into Docs(lessons, content) values (?,?)";

            // Create prepared statement with SQL statement and parameters
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, docs.getLessons());
            stmt.setString(2, docs.getContent());
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Handle any errors that may occur
            e.printStackTrace();
        }
    }

    public void updateDocLesson(Docs docs) {
        PreparedStatement stmt = null;

        try {
            // Create SQL statement with parameters
            String sql = "update Docs set content=? where lessons= ?";

            // Create prepared statement with SQL statement and parameters
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, docs.getContent());
            stmt.setInt(2, docs.getLessons());
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Handle any errors that may occur
            e.printStackTrace();
        }
    }

    public Docs getDocsByLesson(int Id) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "select * from Docs where lessons= ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, Id);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Docs doc = new Docs(rs.getInt("id"), rs.getInt("lessons"), rs.getString("content"));
                return doc;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        DocDAO d = new DocDAO();
        System.out.println(d.getDocsByLesson(41).getContent());
    }
}
