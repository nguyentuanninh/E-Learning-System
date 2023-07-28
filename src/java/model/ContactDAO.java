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
public class ContactDAO extends DBContext {

    public NewsGroup getContact() {
        String sql = "Select * from newsgroup where name = 'contact'";
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

    public List<NewsItem> getCompanyInfo(int id) {
        List<NewsItem> contact = new ArrayList<>();
        String sql = "select id, name, content, created_date, approve_date, created_by, newsgroup from newsitem where newsgroup = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                NewsItem a = new NewsItem();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setContent(rs.getString("content"));
                a.setCreated_date(rs.getDate("created_date"));
                a.setApprove_date(rs.getDate("approve_date"));
                a.setCreated_by(rs.getInt("created_by"));
                a.setNewsGroup(rs.getInt("newsgroup"));
                a.setId(rs.getInt("id"));
                contact.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return contact;
    }

    public CompanyContact getCompanyContact() {
        String sql = "select Name, Content from NewsItem where NewsGroup= (Select id from newsgroup where name = 'contact')";
        CompanyContact a = new CompanyContact();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                if (rs.getString("Name").equals("phone company")) {
                    a.setPhone(rs.getString("Content"));
                }
                if (rs.getString("Name").equals("email company")) {
                    a.setEmail(rs.getString("Content"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    public void UpdateContact(String phone, String gmail) {
        String sql = "update NewsItem set Content= ? where Name='phone company' and NewsGroup= (Select id from newsgroup where name = 'contact');\n"
                + "update NewsItem set Content= ? where Name='email company' and NewsGroup= (Select id from newsgroup where name = 'contact')";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, phone);
            st.setString(2, gmail);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
