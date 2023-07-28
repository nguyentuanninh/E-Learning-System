/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.AboutType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nguyen Minh
 */
public class AboutTypeDAO extends DBContext{
    public List<AboutType> SearchTypeOfAbout(String name) {
        List<AboutType> aboutType = new ArrayList<>();
        String sql = "Select id, Name, Name_VN from NewsItem where NewsGroup = 5";
        if (!name.equals("")) {
            sql = sql + "and ( Name like '%" + name + "%' or Name_VN like '%" + name + "%') ";
        }
        try {
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                AboutType abtt = new AboutType();
                abtt.setId(rs.getInt("id"));
                abtt.setType(rs.getString("Name"));
                abtt.setType_vn(rs.getNString("Name_VN"));
                aboutType.add(abtt);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return aboutType;
    }
    public void AddAboutType(AboutType abouttype) {
        String sql = "insert into NewsItem (Name, Name_VN, NewsGroup) values (?,?,5)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, abouttype.getType());
            ps.setString(2, abouttype.getType_vn());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void DelAboutType(int id) {
        String sql = "delete NewsItem where id = ? and NewsGroup = 5";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void UpdateAboutType(AboutType aboutType) {
        String sql = "update NewsItem set Name = ? , Name_VN = ? where id=? and NewsGroup = 5";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, aboutType.getType());
            ps.setString(2, aboutType.getType_vn());
            ps.setInt(3, aboutType.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
        public AboutType getAboutTypeById(int id) {
        String sql = "select id, Name, Name_VN from NewsItem where NewsGroup = 5 and id = " + id;
        try {
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                AboutType abttype = new AboutType();
                abttype.setId(rs.getInt("id"));
                abttype.setType(rs.getString("Name"));
                abttype.setType_vn(rs.getNString("Name_VN"));
                return abttype;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

       public List<AboutType> getTypeOfAbout() {
        List<AboutType> lag = new ArrayList<>();
        String sql = "select id, Name, Name_VN from NewsItem where NewsGroup = 5";
        try {
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                AboutType at = new AboutType();
                at.setId(rs.getInt("id"));
                at.setType(rs.getString("Name"));
                at.setType_vn(rs.getNString("Name_VN"));
                lag.add(at);

            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return lag;
    }
        public List<AboutType> getListAboutTypeByPage(List<AboutType> list, int start, int end) {
        List<AboutType> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }
}
