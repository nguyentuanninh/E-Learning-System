/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Instructor;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class InstructorDAO extends DBContext {

    public Instructor getInstructorById(int id) {
        String query = "select * from instructor_detail where id=?";
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String email = rs.getString("email");
                String slug = rs.getString("slug");
                String img = rs.getString("img");
                String name = rs.getString("name");
                String bio = rs.getString("bio");
                String job = rs.getString("job");
                return new Instructor(id, email, slug, img, name, bio, job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getNewInstructorId() {
        int id = 0;
        try {
            PreparedStatement st = connection.prepareStatement("SELECT IDENT_CURRENT('instructor_detail')");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }

    public List<Instructor> listInstructor() {
        List<Instructor> c = new ArrayList<>();
        String sql = "select * from Instructor_detail";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Instructor d = new Instructor();
                d.setId(rs.getInt("id"));
                d.setEmail(rs.getString("email"));
                d.setSlug(rs.getString("slug"));
                d.setImg(rs.getString("img"));
                d.setName(rs.getString("name"));
                d.setBio(rs.getString("bio"));
                d.setJob(rs.getString("job"));
                c.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public Instructor getInstructorByCourseId(int id) {
        String query = "select email, name,img,slug, bio, job\n"
                + "from instructors join instructor_detail\n"
                + "on id= instructors.instructors_id\n"
                + "where course_id= ?";
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String email = rs.getString("email");
                String slug = rs.getString("slug");
                String img = rs.getString("img");
                String name = rs.getString("name");
                String bio = rs.getString("bio");
                String job = rs.getString("job");
                return new Instructor(id, email, slug, img, name, bio, job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Instructor> getInstructorByCourseId(List<Instructor> allInstructor, int start, int end) {
        List<Instructor> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(allInstructor.get(i));
        }
        return arr;
    }

    public void AddInstructor(String email, String img, String name, String slug, String bio, String job) {
        String sql = "INSERT INTO instructor_detail (email,slug,img,name,bio,job) values(?, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, img);
            ps.setString(3, name);
            ps.setString(4, slug);
            ps.setString(5, bio);
            ps.setString(6, job);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean DeleteInstructor(int iid) {
        String sql = "DELETE FROM [instructor_detail] WHERE id =?";
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

    public void UpdateInstructor(Instructor i) {
        String sql = " UPDATE instructor_detail set email= ? ,slug=?  ,img = ? \n"
                + "  ,name = ?   ,bio = ? , job = ? \n"
                + "  where id = ?;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, i.getEmail());
            ps.setString(2, i.getSlug());
            ps.setString(3, i.getImg());
            ps.setString(4, i.getName());
            ps.setString(5, i.getBio());
            ps.setString(6, i.getJob());
            ps.setInt(7, i.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        InstructorDAO idao = new InstructorDAO();
        Instructor i = idao.getInstructorById(1);
        System.out.println(i.getEmail());
    }
}
