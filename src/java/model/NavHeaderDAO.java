/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class NavHeaderDAO extends DBContext {

    public NewsGroup Header() {
        String sql = "select * from NewsGroup where name = 'header'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                NewsGroup a = new NewsGroup();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Nav_Header> getHeaderItem(int id) {
        List<Nav_Header> header = new ArrayList<>();
        String sql = "select id, name, name_vn, href, created_date, approve_date, created_by, newsgroup from newsitem where name <> 'logo' and newsgroup = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Nav_Header a = new Nav_Header();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setName_vn(rs.getString("name_vn"));
                a.setCreated_date(rs.getDate("created_date"));
                a.setHref(rs.getString("href"));
                a.setApprove_date(rs.getDate("approve_date"));
                a.setCreated_by(rs.getInt("created_by"));
                a.setNewsgroup(rs.getInt("newsgroup"));
                header.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (header.isEmpty()) {
            return null;
        } else {
            return header;
        }
    }

    public Nav_Header getLogo(int id){
        String sql = "select  id, Name, href, image, created_date, modified_date, approve_date, created_by, modified_by, newsgroup from newsitem where Name=  'logo' and newsgroup = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Nav_Header a = new Nav_Header();
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
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Nav_Header> getChildItem(int id) {
        List<Nav_Header> header = new ArrayList<>();
        String sql = "select id, Name, Name_VN, href, slug, created_date, modified_date, approve_date, Parent_id, created_by, modified_by from newsitem where parent_id =" + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Nav_Header a = new Nav_Header();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setName_vn(rs.getString("name_vn"));
                a.setCreated_date(rs.getDate("created_date"));
                a.setHref(rs.getString("href"));
                a.setSlug(rs.getString("slug"));
                a.setApprove_date(rs.getDate("approve_date"));
                a.setModified_date(rs.getDate("modified_date"));
                a.setCreated_by(rs.getInt("created_by"));
                a.setModified_by(rs.getInt("modified_by"));
                a.setParent_id(rs.getInt("parent_id"));
                header.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (header.isEmpty()) {
            return null;
        } else {
            return header;
        }
    }
}
