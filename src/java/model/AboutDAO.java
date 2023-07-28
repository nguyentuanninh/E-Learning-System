/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.AboutUs;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 *
 * @author Nguyen Minh
 */
public class AboutDAO extends DBContext {

    public List<AboutUs> getListAboutByPage(List<AboutUs> list, int start, int end) {
        List<AboutUs> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public void CreateAbout(AboutUs AboutUs) {
        String sql = "insert into NewsItem (Name, Name_VN, Content, Content_VN,  created_date, Parent_id) values (?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, AboutUs.getTitle());
            ps.setString(2, AboutUs.getTitle_vn());
            ps.setString(3, AboutUs.getContent());
            ps.setString(4, AboutUs.getContent_vn());
            ps.setDate(5, AboutUs.getCreatedDate());
            ps.setInt(6, AboutUs.getAboutType());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            Logger.getLogger(e.getMessage());
        }
    }

    public void DelAbout(int id) {
        String sql = "delete NewsItem where id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void UpdateAbout(AboutUs AboutUs) {
        String sql = "update NewsItem set Name=?, Name_VN=?, [Content]=?, Content_VN=?, Parent_id=?, modified_date=? where id=? "
                + "and Parent_id in (Select id from NewsItem where NewsGroup = 5)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, AboutUs.getTitle());
            ps.setString(2, AboutUs.getTitle_vn());
            ps.setString(3, AboutUs.getContent());
            ps.setString(4, AboutUs.getContent_vn());
            ps.setInt(5, AboutUs.getAboutType());
            ps.setDate(6, AboutUs.getModifiedDate());
            ps.setInt(7, AboutUs.getId());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public List<AboutUs> AboutNews() {
        List<AboutUs> aboutUs = new ArrayList<>();
        String sql = "select id, Name, Name_VN, Content, Content_VN, Parent_id, created_date,"
                + " modified_date from NewsItem where Parent_id in (Select id from NewsItem where NewsGroup = 5)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AboutUs n = new AboutUs();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setTitle_vn(rs.getNString("Name_VN"));
                n.setContent(rs.getString("Content"));
                n.setContent_vn(rs.getNString("Content_VN"));
                n.setAboutType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                aboutUs.add(n);
            }
        } catch (SQLException e) {
            e.getMessage();
        }
        return aboutUs;
    }

    public List<AboutUs> AboutUs() {
        List<AboutUs> abt = new ArrayList<>();
        String sql = "select id, Name, Name_VN, Content, Content_VN, Parent_id, created_date,"
                + " modified_date from NewsItem where Parent_id = 13";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AboutUs n = new AboutUs();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setTitle_vn(rs.getNString("Name_VN"));
                n.setContent(rs.getString("Content"));
                n.setContent_vn(rs.getNString("Content_VN"));
                n.setAboutType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                abt.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return abt;
    }

    public List<AboutUs> SloganNews() {
        List<AboutUs> slogan = new ArrayList<>();
        String sql = "select id, Name, Name_VN, Content, Content_VN, Parent_id, created_date,"
                + " modified_date from NewsItem where Parent_id = 14";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AboutUs n = new AboutUs();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setTitle_vn(rs.getNString("Name_VN"));
                n.setContent(rs.getString("Content"));
                n.setContent_vn(rs.getNString("Content_VN"));
                n.setAboutType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                slogan.add(n);
            }
        } catch (SQLException e) {
            e.getMessage();
        }
        return slogan;
    }

    public List<AboutUs> aboutUs(int type) {
        List<AboutUs> au = new ArrayList<>();
        String sql = "select id, Name, Name_VN, Content, Content_VN, Parent_id, created_date,"
                + " modified_date from NewsItem where Parent_id = " + type;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AboutUs n = new AboutUs();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setTitle_vn(rs.getNString("Name_VN"));
                n.setContent(rs.getString("Content"));
                n.setContent_vn(rs.getNString("Content_VN"));
                n.setAboutType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                au.add(n);
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return au;
    }

    public AboutUs getAboutById(int id) {
        String sql = "select id, Name, Name_VN, Content, Content_VN, Parent_id, created_date,"
                + " modified_date from NewsItem where Id = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AboutUs n = new AboutUs();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setTitle_vn(rs.getNString("Name_VN"));
                n.setContent(rs.getString("Content"));
                n.setContent_vn(rs.getNString("Content_VN"));
                n.setAboutType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                return n;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<AboutUs> SearchAboutNews(String name) {
        List<AboutUs> aboutUs = new ArrayList<>();
        String sql = "select id, Name, Name_VN, Content, Content_VN, Parent_id, created_date,"
                + " modified_date from NewsItem where Parent_id in (Select id from NewsItem where NewsGroup = 5) and ";
        if (!name.equals("")) {
            sql = sql + " (Name like '%" + name + "%' "
                    + "or Content like '%" + name + "%' "
                    + "or Name_VN like '%" + name + "%' "
                    + "or Content_VN like '%" + name + "%' "
                    + "or created_date like '%" + name + "%' "
                    + "or modified_date like '%" + name + "%'"
                    + "or Parent_id like '%" + name + "%')";
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AboutUs n = new AboutUs();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setTitle_vn(rs.getNString("Name_VN"));
                n.setContent(rs.getString("Content"));
                n.setContent_vn(rs.getNString("Content_VN"));
                n.setAboutType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                aboutUs.add(n);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return aboutUs;
    }

}
