/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.FileLesson;
import entity.Video;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author MSII
 */
public class VideoDAO extends DBContext {

    public void createVideoLesson(Video v) {
        PreparedStatement stmt = null;

        try {
            // Create SQL statement with parameters
            String sql = "insert into video(lessons, videoName, videoLink) values (?,?,?)";

            // Create prepared statement with SQL statement and parameters
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, v.getLessons());
            stmt.setString(2, v.getVideoName());
            stmt.setString(3, v.getVideoLink());
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Handle any errors that may occur
            e.printStackTrace();
        }
    }

    public void updateVideoLesson(Video file) {
        PreparedStatement stmt = null;

        try {
            // Create SQL statement with parameters
            String sql = "update [video] set videoName=?, videoLink= ? where lessons= ?";

            // Create prepared statement with SQL statement and parameters
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, file.getVideoName());
            stmt.setString(2, file.getVideoLink());
            stmt.setInt(3, file.getLessons());
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Handle any errors that may occur
            e.printStackTrace();
        }
    }

    public Video getVideoByLessonId(int Id) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "select * from [video] where lessons= ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, Id);
            rs = stmt.executeQuery();
            while (rs.next()) {
                return new Video(rs.getInt("id"),  rs.getInt("lessons"),  rs.getString("videoName"),  rs.getString("videoLink"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
