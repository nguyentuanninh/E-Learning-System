/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Instructor;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MSII
 */
public class Instructor_courseDAO extends DBContext {

    public void createInstructorCourse(int instructors_id, int course_id) {
        try {
            PreparedStatement statement = connection.prepareStatement("insert into instructors(instructors_id, course_id) values (?, ?)");
            statement.setInt(1, instructors_id);
            statement.setInt(2, course_id);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Instructor> getInstructorOfCourse(int courseId) {
        List<Instructor> list = new ArrayList<>();
        String sql = "select id, email, img, [name], bio, job "
                + "from instructors join instructor_detail id on id.id = instructors.instructors_id\n"
                + "where course_id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, courseId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Instructor n = new Instructor();
                n.setId(rs.getInt("id"));
                n.setEmail(rs.getString("email"));
                n.setImg(rs.getString("img"));
                n.setName(rs.getString("name"));
                n.setBio(rs.getString("bio"));
                n.setJob(rs.getString("job"));
                list.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Integer> getInstructorIdOfCourse(int courseId) {
        List<Integer> list = new ArrayList<>();
        String sql = "select * from instructors where course_id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, courseId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("instructors_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteByCourseId(int courseId) {
        List<Integer> list = new ArrayList<>();
        String sql = "delete from instructors where course_id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, courseId);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        Instructor_courseDAO a = new Instructor_courseDAO();
        List<Integer> b = a.getInstructorIdOfCourse(11);
        System.out.println(b.contains(1));
    }
}
