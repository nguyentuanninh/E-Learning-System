/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.AdminAccount;
import entity.PasswordEncryption;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class AdminDAO extends DBContext {

    public AdminAccount getAdminByTypeID(int type) {
        AdminAccount a = new AdminAccount();
        String sql = "select * from admin_account where type_id = " + type;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));
                a.setType_id(rs.getInt("type_id"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    public AdminAccount getAdminByID(int id) {
        AdminAccount a = new AdminAccount();
        String sql = "select a.* from admin_account a inner join NewsItem n on a.id = n.created_by where a.id =" + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));
                a.setType_id(rs.getInt("type_id"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    public AdminAccount getAdminByAdminID(int id) {
        AdminAccount a = new AdminAccount();
        String sql = "select * from admin_account where id =" + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));
                a.setType_id(rs.getInt("type_id"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    public AdminAccount login(String username, String password) {
        AdminAccount a = new AdminAccount();
        String sql = "Select * from admin_account where username = '" + username + "' and password = '" + password + "'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));
                a.setType_id(rs.getInt("type_id"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    public AdminAccount getUser(String username, String getBy) {
        String sql = "Select * from [admin_account] where " + getBy + " = '" + username + "'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                AdminAccount a = new AdminAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));
                a.setType_id(rs.getInt("type_id"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateAdminInfo(String username, String telephone, String email, String name, int id) {

        String sql = "Update [admin_account] set username = ?, name=?, phone = ?, email=? where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, name);
            st.setString(3, telephone);
            st.setString(4, email);
            st.setInt(5, id);
            st.executeUpdate();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateAdminPassword(String username, String password) {
        String sql = "update [admin_account] \n"
                + "set password = ? where username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, password);
            st.setString(2, username);
            st.executeUpdate();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<AdminAccount> getListUserByPage(List<AdminAccount> list, int start, int end) {
        List<AdminAccount> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<AdminAccount> searchListUser(String username) {
        List<AdminAccount> data = new ArrayList<>();
        try {
            String sql = "SELECT *\n"
                    + "  FROM [admin_account]\n"
                    + "  where [type_id] = 2";
            if (!username.equals("")) {
                sql = sql + "  and (name like '%" + username + "%'"
                        + "  or username like '%" + username + "%'"
                        + "  or email like '%" + username + "%'"
                        + "  or phone like '%" + username + "%')";
            }
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AdminAccount a = new AdminAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));
                a.setType_id(rs.getInt("type_id"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));
                data.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

    public List<AdminAccount> getListAdminAccount() {
        List<AdminAccount> data = new ArrayList<>();
        try {
            String sql = "SELECT *\n"
                    + "  FROM [admin_account]\n"
                    + "  where [type_id] = 2";

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AdminAccount a = new AdminAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));
                a.setType_id(rs.getInt("type_id"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));
                data.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

    public List<AdminAccount> getTop5Employee() {
        List<AdminAccount> data = new ArrayList<>();
        try {
            String sql = "SELECT top 5 *\n"
                    + "  FROM [admin_account]\n"
                    + "  where [type_id] = 2";

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AdminAccount a = new AdminAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));
                a.setType_id(rs.getInt("type_id"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));
                data.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

        public List<AdminAccount> getNext5Employee(int amount) {
        List<AdminAccount> data = new ArrayList<>();
        try {
            String sql = "SELECT *\n"
                    + "  FROM [admin_account]\n"
                    + "  where [type_id] = 2 order by id offset ? rows fetch next 5 rows only";

            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, amount);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AdminAccount a = new AdminAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setEmail(rs.getString("email"));
                a.setType_id(rs.getInt("type_id"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));
                data.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

    public void updateUserDisabled(int idAcc, int Disabled) {
        String sql = "UPDATE [admin_account]\n"
                + "   SET \n"
                + "      [disabled] = ?\n"
                + " WHERE [id] = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Disabled);
            statement.setInt(2, idAcc);
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertCustomer(String username, String email, String name, String phonenumber, String password) {
        String sql = "Insert into [admin_account](username,password,email,name, phone,type_id) "
                + "values (?,?,?,?,?, 2)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            st.setString(3, email);
            st.setString(4, name);
            st.setString(5, phonenumber);
            st.executeUpdate();
            st.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws NoSuchAlgorithmException {

        System.out.println("a");
    }

}
