/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.NewsItem;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class NewsGroupDAO extends DBContext {

    public void deleteParent(int id) {
        String sql = "delete NewsItem where id = ? and name <> 'logo'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
        }
    }

    public void deleteChildren(int id, String role) {
        String sql;
        if (role.equals("parent")) {
            sql = "delete NewsItem where parent_id = ?";
        } else {
            sql = "delete NewsItem where id = ?";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
        }
    }

    public NewsItem getNewsParent(int id) {
        String sql = "select * from NewsItem where id = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                NewsItem a = new NewsItem();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setName_vn(rs.getString("name_vn"));
                a.setHref(rs.getString("href"));
                a.setSlug(rs.getString("slug"));
                a.setContent(rs.getString("content"));
                a.setContent_vn(rs.getString("content_vn"));
                return a;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public NewsItem getItemInfo(int id) {
        String sql = "select * from NewsItem where id = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                NewsItem a = new NewsItem();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setName_vn(rs.getString("name_vn"));
                a.setHref(rs.getString("href"));
                a.setSlug(rs.getString("slug"));
                a.setContent(rs.getString("content"));
                a.setContent_vn(rs.getString("content_vn"));
                return a;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public void insertNavigation(String name, String name_vn, String link, String slug, int parent_id, int parent) {
        String sql = "";
        if (parent == 1) {
            sql = "Insert into newsitem (name, name_vn, href, slug, newsgroup) values (?,?,?,?,?)";
        } else if (parent == 2) {
            sql = "Insert into newsitem (name, name_vn, href, slug, parent_id) values (?,?,?,?,?)";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, name_vn);
            st.setString(3, link);
            st.setString(4, slug);
            st.setInt(5, parent_id);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
        }
    }
    
    public void updateNewsItem(int id, String name, String name_vn, String link, String slug, String content, String content_vn, Date modified_date, int modified_by){
        String sql = "Update newsItem set name = ?, name_vn =?, href=?, slug=?, content=?,content_vn=?, modified_date=?, modified_by=? where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, name_vn);
            st.setString(3, link);
            st.setString(4, slug);
            st.setString(5, content);
            st.setString(6, content_vn);
            st.setDate(7, modified_date);
            st.setInt(8, modified_by);
            st.setInt(9, id);
           
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
        }
    }
}
