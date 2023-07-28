/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Docs;
import entity.FileLesson;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author MSII
 */
public class FileDAO extends DBContext{
    public void createLesson(FileLesson file) {
        PreparedStatement stmt = null;

        try {
            // Create SQL statement with parameters
            String sql = "insert into [File](lessons, file_name) values (?,?)";

            // Create prepared statement with SQL statement and parameters
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, file.getLesson());
            stmt.setString(2, file.getFile_name());
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Handle any errors that may occur
            e.printStackTrace();
        }
    }

    public void updateFileLesson(FileLesson file) {
        PreparedStatement stmt = null;

        try {
            // Create SQL statement with parameters
            String sql = "update [File] set file_name=? where lessons= ?";

            // Create prepared statement with SQL statement and parameters
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, file.getFile_name());
            stmt.setInt(2, file.getLesson());
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Handle any errors that may occur
            e.printStackTrace();
        }
    }

    public FileLesson getFileByLesson(int Id) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "select * from [File] where lessons= ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, Id);
            rs = stmt.executeQuery();
            while (rs.next()) {
                FileLesson file = new FileLesson(rs.getInt("id"), rs.getInt("lessons"), rs.getString("file_name"));
                return file;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
