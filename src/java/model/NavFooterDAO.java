/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class NavFooterDAO extends DBContext{
    public NewsGroup getFooter(){
        String sql = "select * from NewsGroup where name = 'footer'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                NewsGroup a = new NewsGroup();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                return a;
            }
        } catch (SQLException e) {
        }
        return null;
    }
    public List<NavFooter> getNewsFooter(int id){
        List<NavFooter> footer = new ArrayList<>();
        String sql = "select id, Name, Name_VN, href, created_date, modified_date, approve_date, image, Created_By, Modified_By, NewsGroup, Parent_id from newsitem where name <> 'logo' and newsgroup = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                NavFooter a = new NavFooter();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setName_vn(rs.getString("name_vn"));
                a.setHref(rs.getString("href"));
                a.setCreated_date(rs.getDate("created_date"));
                a.setApprove_date(rs.getDate("approve_date"));
                a.setApprove_date(rs.getDate("modified_date"));
                a.setImage(rs.getString("image"));
                a.setCreated_by(rs.getInt("created_by"));
                a.setCreated_by(rs.getInt("Modified_By"));
                a.setCreated_by(rs.getInt("Parent_id"));
                a.setNewsgroup(rs.getInt("newsgroup"));
                footer.add(a);
            }
        } catch (SQLException e) {
        }
        if (footer.isEmpty()) {
            return null;
        } else {
            return footer;
        }
    }
    
    public NavFooter getLogo(int id){
        String sql = "select  id, Name, href, image, created_date, modified_date, approve_date, created_by, modified_by, newsgroup, parent_id from newsitem where Name=  'logo' and newsgroup = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                NavFooter a = new NavFooter();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setCreated_date(rs.getDate("created_date"));
                a.setHref(rs.getString("href"));
                a.setImage(rs.getString("image"));
                a.setApprove_date(rs.getDate("approve_date"));
                a.setModified_date(rs.getDate("modified_date"));
                a.setCreated_by(rs.getInt("created_by"));
                a.setModified_by(rs.getInt("modified_by"));
                a.setNewsgroup(rs.getInt("newsgroup"));
                a.setNewsgroup(rs.getInt("parent_id"));
                return a;
            }
        } catch (SQLException e) {
        }
        return null;
    }
    
    public List<NavFooter> getChildItem(int id) {
        List<NavFooter> footer = new ArrayList<>();
        String sql = "select id, Name, Name_VN, href, slug, content, created_date, modified_date, approve_date, Parent_id, created_by, modified_by from newsitem where parent_id =" + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                NavFooter a = new NavFooter();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setName_vn(rs.getString("name_vn"));
                a.setCreated_date(rs.getDate("created_date"));
                a.setHref(rs.getString("href"));
                a.setContent(rs.getString("content"));
                a.setSlug(rs.getString("slug"));
                a.setApprove_date(rs.getDate("approve_date"));
                a.setModified_date(rs.getDate("modified_date"));
                a.setCreated_by(rs.getInt("created_by"));
                a.setModified_by(rs.getInt("modified_by"));
                a.setParent_id(rs.getInt("parent_id"));
                footer.add(a);
            }
        } catch (SQLException e) {
        }
        if (footer.isEmpty()) {
            return null;
        } else {
            return footer;
        }
    }
}
