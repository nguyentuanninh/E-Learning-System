/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.News;
import entity.UserAccount;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Admin
 */
public class UserDAO extends DBContext {

    public UserAccount login(String username, String password) {
        String sql = "Select * from [user] where username = '" + username + "' and password = '" + password + "'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                UserAccount a = new UserAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setTelephone(rs.getString("telephone"));
                a.setEmail(rs.getString("email"));
                a.setAmount(rs.getInt("amount"));
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

    public UserAccount getUser(String username, String getBy) {
        String sql = "Select * from [user] where " + getBy + " = '" + username + "'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                UserAccount a = new UserAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setTelephone(rs.getString("telephone"));
                a.setEmail(rs.getString("email"));
                a.setAmount(rs.getInt("amount"));
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

    public void insertCustomer(String username, String email, String name, String phonenumber, String password) {
        String sql = "Insert into [user](username,password,email,name,telephone) values (?,?,?,?,?)";
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
            e.printStackTrace();
        }
    }

    public void insertGoogleUser(String username, String email, String name, String password) {
        String sql = "Insert into [user](username,password,email,name) values (?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            st.setString(3, email);
            st.setString(4, name);
            st.executeUpdate();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateUserPassword(String username, String password) {
        String sql = "update [user] \n"
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

    public void updateUserAmount(int id, double amount) {
        String sql = "update [user] \n"
                + "set amount = ? where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDouble(1, amount);
            st.setInt(2, id);
            st.executeUpdate();
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public UserAccount getUserById(int Id) {
        String sql = "Select * from [user] where id=" + Id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                UserAccount a = new UserAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setTelephone(rs.getString("telephone"));
                a.setEmail(rs.getString("email"));
                a.setAmount(rs.getInt("amount"));
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

    public UserAccount getUserByUsername(String id) {
        String sql = "Select * from [user] where username= ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                UserAccount a = new UserAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setTelephone(rs.getString("telephone"));
                a.setEmail(rs.getString("email"));
                a.setAmount(rs.getInt("amount"));
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

    public Map<Integer, UserAccount> getMapUserAccount() {
        Map<Integer, UserAccount> map = new HashMap<>();
        try {

            String sql = "SELECT * FROM [user]";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                UserAccount a = new UserAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setTelephone(rs.getString("telephone"));
                a.setEmail(rs.getString("email"));
                a.setAmount(rs.getInt("amount"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));

                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setTelephone(rs.getString("telephone"));
                a.setEmail(rs.getString("email"));
                a.setAmount(rs.getInt("amount"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));

                map.put(a.getId(), a);
            }

        } catch (Exception e) {
        }
        return map;
    }

    public List<UserAccount> getListUser() {
        List<UserAccount> data = new ArrayList<>();

        try {
            String sql = "SELECT  [id]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[email]\n"
                    + "      ,[name]\n"
                    + "      ,[telephone]\n"
                    + "      ,[amount]\n"
                    + "      ,[disabled]\n"
                    + "      ,[created_at]\n"
                    + "      ,[modified_at]\n"
                    + "  FROM [user]";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                UserAccount a = new UserAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setTelephone(rs.getString("telephone"));
                a.setEmail(rs.getString("email"));
                a.setAmount(rs.getInt("amount"));
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

    public List<UserAccount> getTop5User() {
        List<UserAccount> data = new ArrayList<>();

        try {
            String sql = "SELECT top 5  [id] ,[username],[password] ,[email],[name] ,[telephone],[amount],[disabled],[created_at],[modified_at] FROM [user]";
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                UserAccount a = new UserAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setTelephone(rs.getString("telephone"));
                a.setEmail(rs.getString("email"));
                a.setAmount(rs.getInt("amount"));
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

    public List<UserAccount> getNext5User(int amount) {
        List<UserAccount> data = new ArrayList<>();

        try {
            String sql = "SELECT [id] ,[username],[password] ,[email],[name] ,[telephone],[amount],[disabled],[created_at],[modified_at] FROM [user] order by id offset ? rows fetch next 5 rows only";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, amount);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                UserAccount a = new UserAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setTelephone(rs.getString("telephone"));
                a.setEmail(rs.getString("email"));
                a.setAmount(rs.getInt("amount"));
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

    public void updateUserDisabled(int idUser, int Disabled) {
        String sql = "UPDATE [user]\n"
                + "   SET \n"
                + "      [disabled] = ?\n"
                + " WHERE [id] = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Disabled);
            statement.setInt(2, idUser);
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateAmount(int id, double amount) {
        String sql = "UPDATE [user]\n"
                + "   SET \n"
                + "      [amount] = ?\n"
                + " WHERE [id] = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setDouble(1, amount);
            statement.setInt(2, id);
            statement.executeUpdate();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<UserAccount> getListUserByPage(List<UserAccount> list, int start, int end) {
        List<UserAccount> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public void updateUserInfor(String username, String telephone, String email, String name, int id) {

        String sql = "Update [user] set username = ?, name=?, telephone = ?, email=? where id = ?";
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

    public List<UserAccount> searchListUser(String username) {
        List<UserAccount> data = new ArrayList<>();
        try {
            String sql = "SELECT *\n"
                    + "  FROM [user]";
            if (!username.equals("")) {
                sql = sql + "  where name like '%" + username + "%'"
                        + "  or username like '%" + username + "%'"
                        + "  or email like '%" + username + "%'"
                        + "  or telephone like '%" + username + "%'";
            }
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                UserAccount a = new UserAccount();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setName(rs.getString("name"));
                a.setTelephone(rs.getString("telephone"));
                a.setEmail(rs.getString("email"));
                a.setAmount(rs.getInt("amount"));
                a.setCreated_at(rs.getDate("created_at"));
                a.setModified_at(rs.getDate("modified_at"));
                a.setDisabled(rs.getBoolean("disabled"));
                data.add(a);
            }
            System.out.println(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return data;
    }

    public static void main(String[] args) {
        UserDAO user = new UserDAO();
        user.searchListUser("hello");
    }
}
