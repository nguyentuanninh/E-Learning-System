/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.News;
import java.sql.Date;
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
public class NewsDAO extends DBContext {

    public List<News> getListNewsByPage(List<News> list, int start, int end) {
        List<News> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public int getNewNavId() {
        int id = 0;
        try {
            PreparedStatement st = connection.prepareStatement("SELECT IDENT_CURRENT('NewsItem')");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.getSQLState();
        }
        return id;
    }

    public void updateNewsStatus(int id, int Status) {
        String sql = "";
        try {
            PreparedStatement statement = null;
            Date approveDate = new Date(System.currentTimeMillis());
            if (Status == 1) {
                sql = "update NewsItem set approve_date = ? where [id] = ?";
                statement = connection.prepareStatement(sql);
                statement.setDate(1, approveDate);
                statement.setInt(2, id);
            }
            if (Status == 0) {
                sql = "delete NewsItem where approve_date is null and id=?";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, id);
            }
            statement.executeUpdate();
            statement.close();
        } catch (SQLException e) {
            e.getSQLState();
        }
    }

    public List<News> getTopNews() {
        List<News> news = new ArrayList<>();
        String sql = "Select top 4 id, Name, Content, Description, slug, image, Parent_id, created_date,"
                + " modified_date, Created_By, Modified_By, approve_date from NewsItem"
                + " where approve_date is not null and Parent_id in (select id from NewsItem where NewsGroup = 6) order by approve_date desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setContent(rs.getString("Content"));
                n.setDescription(rs.getNString("Description"));
                n.setSlug(rs.getString("slug"));
                n.setImage(rs.getString("image"));
                n.setNewsType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                n.setCreatedBy(rs.getInt("Created_By"));
                n.setModifiedBy(rs.getInt("Modified_By"));
                n.setApproveDate(rs.getDate("approve_date"));
                news.add(n);
            }
        } catch (SQLException e) {
            e.getMessage();
        }
        return news;
    }

    public List<News> getNewsUnapproved() {
        List<News> news = new ArrayList<>();

        try {
            String sql = "Select id, Name, Content, Description, slug, image, Parent_id, created_date,"
                    + " modified_date, Created_By, Modified_By, approve_date from NewsItem"
                    + " where approve_date is null and Parent_id in (select id from NewsItem where NewsGroup = 6)";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setContent(rs.getString("Content"));
                n.setDescription(rs.getNString("Description"));
                n.setSlug(rs.getString("slug"));
                n.setImage(rs.getString("image"));
                n.setNewsType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                n.setCreatedBy(rs.getInt("Created_By"));
                n.setModifiedBy(rs.getInt("Modified_By"));
                n.setApproveDate(rs.getDate("approve_date"));
                news.add(n);
                System.out.println(news);
            }
        } catch (SQLException e) {
            e.getMessage();
        }
        return news;
    }

    public List<News> getNewsApproved() {
        List<News> news = new ArrayList<>();
        String sql = "Select id, Name, Content, Description, slug, image, Parent_id, created_date,"
                + " modified_date, Created_By, Modified_By, approve_date from NewsItem"
                + " where approve_date is not null and Parent_id in (select id from NewsItem where NewsGroup = 6)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setContent(rs.getString("Content"));
                n.setDescription(rs.getNString("Description"));
                n.setSlug(rs.getString("slug"));
                n.setImage(rs.getString("image"));
                n.setNewsType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                n.setCreatedBy(rs.getInt("Created_By"));
                n.setModifiedBy(rs.getInt("Modified_By"));
                n.setApproveDate(rs.getDate("approve_date"));
                news.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return news;
    }

    public List<News> getTop5NewsApproved() {
        List<News> news = new ArrayList<>();
        String sql = "Select top 3 id, Name, Content, Description, slug, image, Parent_id, created_date,"
                + " modified_date, Created_By, Modified_By, approve_date from NewsItem"
                + " where approve_date is not null and Parent_id in (select id from NewsItem where NewsGroup = 6)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setContent(rs.getString("Content"));
                n.setDescription(rs.getNString("Description"));
                n.setSlug(rs.getString("slug"));
                n.setImage(rs.getString("image"));
                n.setNewsType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                n.setCreatedBy(rs.getInt("Created_By"));
                n.setModifiedBy(rs.getInt("Modified_By"));
                n.setApproveDate(rs.getDate("approve_date"));
                news.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return news;
    }
    
        public List<News> getNext5NewsApproved(int amount) {
        List<News> news = new ArrayList<>();
        String sql = "Select id, Name, Content, Description, slug, image, Parent_id, created_date,"
                + " modified_date, Created_By, Modified_By, approve_date from NewsItem"
                + " where approve_date is not null and Parent_id in (select id from NewsItem where NewsGroup = 6)"
                + "ORDER BY [id] offset ? rows fetch next 5 rows only";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, amount);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setContent(rs.getString("Content"));
                n.setDescription(rs.getNString("Description"));
                n.setSlug(rs.getString("slug"));
                n.setImage(rs.getString("image"));
                n.setNewsType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                n.setCreatedBy(rs.getInt("Created_By"));
                n.setModifiedBy(rs.getInt("Modified_By"));
                n.setApproveDate(rs.getDate("approve_date"));
                news.add(n);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return news;
    }

    public News getNewsById(int id) {
        String sql = "Select id, Name, Content, Description, slug, image, Parent_id, created_date,"
                + " modified_date, Created_By, Modified_By, approve_date from NewsItem "
                + " where Parent_id in (select id from NewsItem where NewsGroup = 6) and id = " + id;
        try {
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                News n = new News();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setContent(rs.getString("Content"));
                n.setDescription(rs.getNString("Description"));
                n.setSlug(rs.getString("slug"));
                n.setImage(rs.getString("image"));
                n.setNewsType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                n.setCreatedBy(rs.getInt("Created_By"));
                n.setModifiedBy(rs.getInt("Modified_By"));
                n.setApproveDate(rs.getDate("approve_date"));
                return n;
            }
        } catch (SQLException e) {
            e.getMessage();
        }
        return null;
    }

    public void AddNews(News news) {
        String sql = "insert into NewsItem (Name, [Content], Description, slug, [image], Parent_id, created_date, Created_By) values (?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getContent());
            ps.setString(3, news.getDescription());
            ps.setString(4, news.getSlug());
            ps.setString(5, news.getImage());
            ps.setInt(6, news.getNewsType());
            ps.setDate(7, news.getCreatedDate());
            ps.setInt(8, news.getCreatedBy());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public void DelNews(int id) {
        String sql = "delete NewsItem where id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public void UpdateNews(News news) {
        String sql = "update NewsItem set Name=?, [Content]=?, Description=?, slug =? ,[image]=?, Parent_id=?, modified_date=?, Modified_By=? where id=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getContent());
            ps.setString(3, news.getDescription());
            ps.setString(4, news.getSlug());
            ps.setString(5, news.getImage());
            ps.setInt(6, news.getNewsType());
            ps.setDate(7, news.getModifiedDate());
            ps.setInt(8, news.getModifiedBy());
            ps.setInt(9, news.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public List<News> searchNews(String name, int type) {
        List<News> news = new ArrayList<>();
        String sql = "Select * from NewsItem where Parent_id in (Select id from NewsItem where NewsGroup = 6)";
        if (!name.equals("")) {
            sql = sql + "and ( Name like '%" + name + "%' "
                    + "or created_date like '%" + name + "%' "
                    + "or modified_date like '%" + name + "%' "
                    + "or Created_By like '%" + name + "%' "
                    + "or Modified_By like '%" + name + "%'"
                    + "or approve_date like '%" + name + "%')";
        }
        if (type == 1) {
            sql = sql + "and approve_date is null";
        } else {
            sql = sql + "and approve_date is not null";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("Name"));
                n.setContent(rs.getString("Content"));
                n.setDescription(rs.getNString("Description"));
                n.setSlug(rs.getString("slug"));
                n.setImage(rs.getString("image"));
                n.setNewsType(rs.getInt("Parent_id"));
                n.setCreatedDate(rs.getDate("created_date"));
                n.setModifiedDate(rs.getDate("modified_date"));
                n.setCreatedBy(rs.getInt("Created_By"));
                n.setModifiedBy(rs.getInt("Modified_By"));
                n.setApproveDate(rs.getDate("approve_date"));
                news.add(n);
            }
        } catch (SQLException e) {
            e.getMessage();
        }
        return news;
    }

}
