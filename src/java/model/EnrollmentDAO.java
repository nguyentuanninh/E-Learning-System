/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Enrollment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author MSII
 */
public class EnrollmentDAO extends DBContext {

    PreparedStatement ps = null;
    ResultSet rs = null;

    public int getNumberEnrollmentByCourseId(int id) {
        String sql = "select * from enrollments where course_id= ?";
        int result = 0;
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                result++;
            }
        } catch (Exception e) {
        }
        return result;
    }

    public void insertEnrollment(int userid, int courseid, float price) {
        String sql = "Insert into enrollments(user_id, course_id, price) values(?,?,?)";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userid);
            statement.setInt(2, courseid);
            statement.setFloat(3, price);
            statement.executeUpdate();
            statement.close();
        } catch (SQLException e) {
        }
    }

    public Enrollment getEnrollment(int user_id, int course_id) {
        Enrollment en = new Enrollment();
        String sql = "select * from enrollments WHERE user_id = " + user_id + "and course_id = " + course_id;
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                en.setCourse_id(rs.getInt("course_id"));
                en.setUser_id(rs.getInt("user_id"));
                en.setEnrolled_at(rs.getDate("enrolled_at"));
                en.setPrice(rs.getFloat("price"));
                return en;
            }
        } catch (SQLException e) {
        }
        System.out.println(sql);
        return null;
    }

    public float getYearIncome(int year) {
        float income = 0;
        String sql = "select SUM(PRICE)as income from enrollments where YEAR(enrolled_at) = "+year;
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                income = rs.getFloat("income");
            }
        } catch (SQLException e) {
        }
        return income;
    }
    public float getMonthIncome(int year, int month) {
        float income = 0;
        String sql = "select SUM(PRICE)as income from enrollments where YEAR(enrolled_at) = "+year+" and MONTH(enrolled_at) = " + month;
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                income = rs.getFloat("income");
            }
        } catch (SQLException e) {
        }
        return income;
    }
    public int getYearEnrolled(int year) {
        int count = 0;
        String sql = "select COUNT(*) as count from enrollments where YEAR(enrolled_at) = "+year;
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
        }
        return count;
    }
    public int getMonthEnrolled(int year, int month) {
        int count = 0;
        String sql = "select Count(*) as count from enrollments where YEAR(enrolled_at) = "+year+" and MONTH(enrolled_at) = " + month;
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
        }
        return count;
    }

    public static void main(String[] args) {
        EnrollmentDAO ed = new EnrollmentDAO();
        ed.getEnrollment(1, 2);
    }
}
