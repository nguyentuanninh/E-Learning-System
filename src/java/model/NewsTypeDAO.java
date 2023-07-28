

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import entity.NewsGroup;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nguyen Minh
 */
public class NewsTypeDAO extends DBContext {

    public List<NewsGroup> getListNewsTypeByPage(List<NewsGroup> list, int start, int end) {
        List<NewsGroup> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<NewsGroup> getTypeOfNews() {
        List<NewsGroup> newsGr = new ArrayList<>();
        String sql = "Select id, Name from NewsItem where NewsGroup = 6";
        try {
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                NewsGroup ng = new NewsGroup();
                ng.setId(rs.getInt("id"));
                ng.setName(rs.getString("Name"));
                newsGr.add(ng);
            }
        } catch (SQLException e) {
            e.getMessage();
        }
        return newsGr;
    }

    public void AddNewsType(NewsGroup newsgroup) {
        String sql = "insert into NewsItem (Name, NewsGroup) values (?, 6)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newsgroup.getName());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.getMessage();
        }
    }
    public void DelNewsType(int id) {
        String sql = "delete NewsItem where id = ? and NewsGroup = 6";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.getMessage();
        }
    }
    public void UpdateNewsType(NewsGroup newsgroup) {
        String sql = "update NewsItem set Name = ? where id=? and NewsGroup = 6";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newsgroup.getName());
            ps.setInt(2, newsgroup.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.getMessage();
        }
    }
    public NewsGroup getNewsTypeById(int id) {
        String sql = "Select * from NewsItem where NewsGroup = 6 and id = " + id;
        try {
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                NewsGroup ng = new NewsGroup();
                ng.setId(rs.getInt("id"));
                ng.setName(rs.getString("Name"));
                return ng;
            }
        } catch (SQLException e) {
            e.getMessage();
        }
        return null;
    }
    public List<NewsGroup> SearchTypeOfNews(String name) {
        List<NewsGroup> newsGr = new ArrayList<>();
        String sql = "Select * from NewsItem where NewsGroup = 6";
        if (!name.equals("")) {
            sql = sql + "  and Name like '%" + name + "%' ";
        }
        try {
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                NewsGroup ng = new NewsGroup();
                ng.setId(rs.getInt("id"));
                ng.setName(rs.getString("Name"));
               
                newsGr.add(ng);
            }
        } catch (SQLException e) {
            e.getMessage();
        }
        return newsGr;
    }
}
















