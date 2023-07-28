/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.CourseReview;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MSII
 */
public class CourseReviewDAO extends DBContext {

    public List<CourseReview> getCourseReviewByCourseId(int courseId) {
        List<CourseReview> courseReviews = new ArrayList<>();

        try {
            String sql = "SELECT * FROM course_reviews WHERE course_id = ? ORDER BY [id] DESC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, courseId);

            ResultSet result = statement.executeQuery();

            while (result.next()) {
                int id = result.getInt("id");
                int userId = result.getInt("user_id");
                int rating = result.getInt("rating");
                String reviewText = result.getString("review_text");
                Date createdAt = result.getDate("created_at");

                CourseReview courseReview = new CourseReview(id, userId, courseId, rating, reviewText, createdAt);
                courseReviews.add(courseReview);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courseReviews;
    }

    public List<CourseReview> getTop3CourseReviewByCourseId(int courseId) {
        List<CourseReview> courseReviews = new ArrayList<>();

        try {
            String sql = "SELECT top 5 * FROM course_reviews WHERE course_id = ? ORDER BY [id] DESC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, courseId);

            ResultSet result = statement.executeQuery();

            while (result.next()) {
                int id = result.getInt("id");
                int userId = result.getInt("user_id");
                int rating = result.getInt("rating");
                String reviewText = result.getString("review_text");
                Date createdAt = result.getDate("created_at");

                CourseReview courseReview = new CourseReview(id, userId, courseId, rating, reviewText, createdAt);
                courseReviews.add(courseReview);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courseReviews;
    }

    public List<CourseReview> getNext3CourseReviewByCourseId(int courseId, int amount) {
        List<CourseReview> courseReviews = new ArrayList<>();

        try {
            String sql = "SELECT * FROM course_reviews WHERE course_id = ? ORDER BY [id] DESC offset ? rows fetch next 5 rows only ";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, courseId);
            statement.setInt(2, amount);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                int id = result.getInt("id");
                int userId = result.getInt("user_id");
                int rating = result.getInt("rating");
                String reviewText = result.getString("review_text");
                Date createdAt = result.getDate("created_at");

                CourseReview courseReview = new CourseReview(id, userId, courseId, rating, reviewText, createdAt);
                courseReviews.add(courseReview);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courseReviews;
    }

    public void createCourseReview(int rate, int userid, String content, int course_id) {
        try {
            PreparedStatement statement = connection.prepareStatement(""
                    + "INSERT INTO [course_reviews] (user_id, course_id, rating, review_text)"
                    + "VALUES (?, ?, ?, ?)");
            statement.setInt(1, userid);
            statement.setInt(2, course_id);
            statement.setInt(3, rate);
            statement.setString(4, content);
            statement.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    public void deleteReview(int id) {
        String sql = "delete course_reviews where id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
