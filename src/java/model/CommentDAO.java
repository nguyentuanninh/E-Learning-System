/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.CourseReview;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author asus
 */
public class CommentDAO extends DBContext {

    public List<CourseReview> getListComment() {
        List<CourseReview> data = new ArrayList<CourseReview>();
        try {
            String sql = "SELECT[id],\n"
                    + "[user_id],\n"
                    + "[course_id] ,\n"
                    + "[rating],\n"
                    + "[review_text],\n"
                    + "[created_at] \n"
                    + "FROM [course_reviews]";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CourseReview a = new CourseReview();
                a.setId(rs.getInt("id"));
                a.setUserId(rs.getInt("user_id"));
                a.setCourseId(rs.getInt("course_id"));
                a.setRating(rs.getInt("rating"));
                a.setReviewText(rs.getString("review_text"));
                a.setCreatedAt(rs.getDate("created_at"));
                data.add(a);
            }
        } catch (Exception e) {
        }
        return data;
    }
    
        public List<CourseReview> getListCommentByCourseId(int id) {
        List<CourseReview> data = new ArrayList<CourseReview>();
        try {
            String sql = "SELECT[id],\n"
                    + "[user_id],\n"
                    + "[course_id] ,\n"
                    + "[rating],\n"
                    + "[review_text],\n"
                    + "[created_at] \n"
                    + "FROM [course_reviews] where [course_id]= ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CourseReview a = new CourseReview();
                a.setId(rs.getInt("id"));
                a.setUserId(rs.getInt("user_id"));
                a.setCourseId(rs.getInt("course_id"));
                a.setRating(rs.getInt("rating"));
                a.setReviewText(rs.getString("review_text"));
                a.setCreatedAt(rs.getDate("created_at"));
                data.add(a);
            }
        } catch (Exception e) {
        }
        return data;
    }
    

    public void deleteCourseReview(int id) {
        try {
            String sql = "DELETE FROM course_reviews WHERE id = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    
    public List<CourseReview> getListCommentByPage(List<CourseReview> list, int start, int end) {
        List<CourseReview> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

 
}
