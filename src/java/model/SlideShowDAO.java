/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.NewsGroup;
import entity.SlideShow;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class SlideShowDAO extends DBContext {

    public NewsGroup getNewsGroupSlide() {
        String sql = "select * from NewsGroup where name = 'slide'";
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

    public List<SlideShow> getSlide(int id) {
        List<SlideShow> ss = new ArrayList<>();
        String sql = "select id, name, name_vn, created_date, approve_date, image, created_by, newsgroup from NewsItem where NewsGroup = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                SlideShow a = new SlideShow();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setNameVn(rs.getString("name_vn"));
                a.setImage(rs.getString("image"));
                a.setCreatedDate(rs.getDate("created_date"));
                a.setApproveDate(rs.getDate("approve_date"));
                a.setCreatedBy(rs.getInt("created_by"));
                a.setNewsgroup(rs.getInt("newsgroup"));
                ss.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (ss.size() == 0) {
            return null;
        }
        return ss;
    }

    public SlideShow getSlideShowInfo() {
        String sql = "Select * from slide_show";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                SlideShow a = new SlideShow();
                a.setId(rs.getInt("id"));
                a.setImage(rs.getString("image"));
                a.setCreatedDate(rs.getDate("created_date"));
                a.setCreatedBy(rs.getInt("create_by"));
                a.setName(rs.getString("slogan"));
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<SlideShow> getSlideShowByCourseId(List<SlideShow> allSlideShow, int start, int end) {
        List<SlideShow> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(allSlideShow.get(i));
        }
        return arr;
    }

    public List<SlideShow> listSlideShow() {
        List<SlideShow> s = new ArrayList<>();
        String sql = "select * from NewsItem where NewsGroup= (Select id from newsgroup where name = 'Slide')";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                SlideShow a = new SlideShow();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setNameVn(rs.getString("name_vn"));
                a.setImage(rs.getString("image"));
                a.setCreatedDate(rs.getDate("created_date"));
                a.setApproveDate(rs.getDate("approve_date"));
                a.setCreatedBy(rs.getInt("created_by"));
                a.setNewsgroup(rs.getInt("newsgroup"));
                s.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }
//
//

    public void AddSlideShow(String image, Date createdDate, int createBy, String name, String nameVn) {
        String sql = "insert into NewsItem ([name], name_vn, created_date, [image], created_by, newsgroup) values (?,?,?,?,?, (Select id from newsgroup where name = 'Slide'));";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, nameVn);
            ps.setDate(3, new java.sql.Date(createdDate.getTime()));
            ps.setString(4, image);
            ps.setInt(5, createBy);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
//

    public boolean DeleteSlideShow(int sid) {
        String sql = "DELETE FROM [NewsItem] WHERE id =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sid);
            int row = ps.executeUpdate();
            if (row == 0) {
                return false;
            }

            return true;
        } catch (Exception e) {
        }
        return false;
    }
//

    public SlideShow getSlideShowById(int id) {
        String query = "select * from [NewsItem] where id=?";
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                SlideShow a = new SlideShow();
                a.setId(rs.getInt("id"));
                a.setName(rs.getString("name"));
                a.setNameVn(rs.getString("name_vn"));
                a.setImage(rs.getString("image"));
                a.setCreatedDate(rs.getDate("created_date"));
                a.setApproveDate(rs.getDate("approve_date"));
                a.setCreatedBy(rs.getInt("created_by"));
                a.setNewsgroup(rs.getInt("newsgroup"));
                return a;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void UpdateSlideShow(SlideShow slideShow) {
        String sql = " UPDATE [NewsItem] set image= ?, name = ?, name_VN=? where id = ?;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, slideShow.getImage());
            ps.setString(2, slideShow.getName());
            ps.setString(3, slideShow.getNameVn());
            ps.setInt(4, slideShow.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
//    public static void main(String[] args) {
//        SlideShowDAO dao= new SlideShowDAO();
//        dao.UpdateSlideShow(new SlideShow(5, "", "", null, 0));
//    }
//
}
