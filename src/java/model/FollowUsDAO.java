/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.FollowUS;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class FollowUsDAO extends DBContext {

    public FollowUS getEmail(String email) {
        FollowUS c = new FollowUS();
        String sql = "select * from [FollowUs] WHERE gmail = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                c.setId(rs.getInt("id"));
                c.setEmail(rs.getString("gmail"));
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<String> listMail() {
        List<String> gmail = new ArrayList<>();
        String sql = "select gmail from [FollowUs]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                gmail.add(rs.getString("gmail"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return gmail;
    }

    public List<String> listAllMail() {
        List<String> gmail = new ArrayList<>();
        String sql = "SELECT email FROM [user]\n"
                + "UNION\n"
                + "SELECT gmail FROM FollowUS;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                gmail.add(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return gmail;
    }

    public void insertFollowUs(String email) {
        try {
            PreparedStatement statement = connection.prepareStatement("INSERT INTO FollowUs (gmail) VALUES (?)");
            statement.setString(1, email);
            statement.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void unFollow(String email) {
        try {
            PreparedStatement statement = connection.prepareStatement("Delete from FollowUs where gmail = ?");
            statement.setString(1, email);
            statement.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

}
