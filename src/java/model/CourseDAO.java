/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Course;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import utilities.SlugifyUtil;

/**
 *
 * @author Admin
 */
public class CourseDAO extends DBContext {

    public List<Course> getListCourseByPage(List<Course> list, int start, int end) {
        List<Course> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public int getNewCourseID() {
        int id = 0;
        try {
            PreparedStatement st = connection.prepareStatement("SELECT IDENT_CURRENT('Courses')");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return id;
    }

    public List<Course> listPendingCourse() {
        List<Course> c = new ArrayList<>();
        String sql = "select * from courses WHERE approve_at is null";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setDisabled(rs.getBoolean("disabled"));
                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
                c.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public List<Course> searchPendingCourse(String name) {
        List<Course> c = new ArrayList<>();
        String sql = "select * from courses WHERE approve_at is null";
        if (!name.equals("")) {
            sql = sql + "  and name like '%" + name + "%'";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setDisabled(rs.getBoolean("disabled"));
                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
                c.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public List<Course> listCourse() {
        List<Course> c = new ArrayList<>();
        String sql = "select * from courses WHERE approve_at is not null";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setDisabled(rs.getBoolean("disabled"));
                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
                c.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public List<Course> listCourseEnrolled(int id) {
        List<Course> c = new ArrayList<>();
        String sql = "select c.* from courses c inner join enrollments e on c.id = e.course_id where e.user_id = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setDisabled(rs.getBoolean("disabled"));
                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
                c.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public List<Course> listCourseByCategory(int id) {
        List<Course> c = new ArrayList<>();
        String sql = "select * from courses where disabled = 0 and categories= ? and approve_at is not null";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setDisabled(rs.getBoolean("disabled"));
                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
                c.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public List<Course> listCourseByPrice(String status) {
        List<Course> c = new ArrayList<>();
        String sql = "select * from courses where disabled = 0 and approve_at is not null";
        if (status.equals("fee-course")) {
            sql = sql + " and price <> 0";
        } else {
            sql = sql + " and price = 0";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setDisabled(rs.getBoolean("disabled"));
                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
                c.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public List<Course> listPopularCourse() {
        List<Course> c = new ArrayList<>();
        String sql = "select top 3 * from courses  where disabled = 0 and approve_at is not null order by NumberEnrolled desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setDisabled(rs.getBoolean("disabled"));
                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
                c.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public Course getCourseById(int courseId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Course course = null;
        try {
            String sql = "SELECT * FROM courses WHERE id=? and approve_at is not null and disabled= 'false' ";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, courseId);

            // Execute query and retrieve results
            rs = stmt.executeQuery();

            // Map result set to Course object
            if (rs.next()) {
                course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setDisabled(rs.getBoolean("disabled"));

                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return course;
    }

    public Course getCourseBySlug(String slug) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Course course = null;
        try {
            String sql = "SELECT * FROM courses WHERE slug=? and approve_at is not null and disabled= 'false'";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, slug);

            // Execute query and retrieve results
            rs = stmt.executeQuery();

            // Map result set to Course object
            if (rs.next()) {
                course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setDisabled(rs.getBoolean("disabled"));
                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return course;
    }

    public Course AdminGetCourseById(int courseId) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Course course = null;
        try {
            String sql = "SELECT * FROM courses WHERE id=?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, courseId);

            // Execute query and retrieve results
            rs = stmt.executeQuery();

            // Map result set to Course object
            if (rs.next()) {
                course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setDisabled(rs.getBoolean("disabled"));
                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return course;
    }

    public List<Course> searchCourse(String name) {
        List<Course> c = new ArrayList<>();
        String sql = "select * from courses";
        if (!name.equals("")) {
            sql = sql + "  where name like '%" + name + "%'";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setName(rs.getString("name"));
                course.setSlug(rs.getString("slug"));
                course.setImage(rs.getString("image"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getFloat("price"));
                course.setCategory(rs.getInt("categories"));
                course.setNumberEnrolled(rs.getInt("NumberEnrolled"));
                course.setLevelId(rs.getInt("level"));
                course.setObjectives(rs.getString("Objectives"));
                course.setCreatedAt(rs.getDate("create_at"));
                course.setModifiedAt(rs.getDate("modified_at"));
                course.setModified_by(rs.getInt("modified_by"));
                course.setApprove_at(rs.getDate("approve_at"));
                course.setDisabled(rs.getBoolean("disabled"));
                c.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    public void createCourse(Course course) {
        try {
            PreparedStatement statement = connection.prepareStatement(""
                    + "INSERT INTO courses (name, image, description, price, categories, slug, numberEnrolled, level, objectives, create_at, disabled, approve_at) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            statement.setString(1, course.getName());
            statement.setString(2, course.getImage());
            statement.setString(3, course.getDescription());
            statement.setFloat(4, course.getPrice());
            statement.setInt(5, course.getCategory());
            statement.setString(6, course.getSlug());
            statement.setInt(7, course.getNumberEnrolled());
            statement.setInt(8, course.getLevelId());
            statement.setString(9, course.getObjectives());
            statement.setDate(10, new java.sql.Date(course.getCreatedAt().getTime()));
            statement.setBoolean(11, course.isDisabled());
            statement.setDate(12, new java.sql.Date(course.getApprove_at().getTime()));
            statement.executeUpdate();
        } catch (SQLException ex) {
        }
    }

    public void updateCourse(Course course) {

        String query = "UPDATE courses SET name=?, image=?, description=?, price=?, "
                + "categories=?, slug=?, NumberEnrolled=?, level=?, Objectives=?, "
                + "modified_at=?,modified_by=?, disabled=? WHERE id=?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, course.getName());
            statement.setString(2, course.getImage());
            statement.setString(3, course.getDescription());
            statement.setFloat(4, course.getPrice());
            statement.setInt(5, course.getCategory());
            statement.setString(6, course.getSlug());
            statement.setInt(7, course.getNumberEnrolled());
            statement.setInt(8, course.getLevelId());
            statement.setString(9, course.getObjectives());
            statement.setDate(10, new java.sql.Date(course.getModifiedAt().getTime()));
            statement.setInt(11, course.getModified_by());
            statement.setBoolean(12, course.isDisabled());
            statement.setInt(13, course.getId());

            statement.executeUpdate();
            statement.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void approveCourse(int courseID) {
        String sql = "UPDATE Courses SET approve_at = GETDATE() where id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, courseID);
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCourseStatus(int courseID, int Status) {
        String sql = "update Courses set disabled = ? where [id] = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Status);
            statement.setInt(2, courseID);
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCourse(int id) {
        try {
            PreparedStatement stmt = connection.prepareStatement("DELETE FROM courses WHERE id = ?");
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void main(String[] args) {
        Course course = new Course(
                -1,
                "aaa",
                SlugifyUtil.slugify("aaa", 1),
                "a",
                "a",
                2,
                2,
                0,
                1,
                "a",
                new java.sql.Date(new Date().getTime()),
                null,
                -1,
                null,
                false);
        CourseDAO cdao = new CourseDAO();
        cdao.createCourse(course);
    }
}
