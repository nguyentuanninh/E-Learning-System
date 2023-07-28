/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Category;
import entity.Course;
import entity.Recharge;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MSII
 */
public class RechargeDAO extends DBContext {

    private static final String AMOUNT = "amount";
    private static final String ID = "id";
    private static final String DATE = "recharge_date";
    private static final String STATUS = "status";
    private static final String USER_ID = "user_id";
    private static final String BANK_ACCOUNT = "bankAccount";
    private static final String DESCRIPTION = "description";

    public List<Recharge> getListCourseByPage(List<Recharge> list, int start, int end) {
        List<Recharge> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public Recharge getRechargeById(int id) {
        Recharge ca = new Recharge();
        String sql = "select * from Recharge where id = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ca.setId(rs.getInt(ID));
                ca.setAmout(rs.getInt(AMOUNT));
                ca.setRechargeDate(rs.getTimestamp(DATE));
                ca.setStatus(rs.getString(STATUS));
                ca.setUserId(rs.getInt(USER_ID));
                ca.setBankAccount(rs.getString(BANK_ACCOUNT));
                ca.setDescription(rs.getString(DESCRIPTION));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ca;
    }

    public void addRecharge(Recharge recharge) {
        String sql = "insert into Recharge(user_id, recharge_date, amount, [status], bankAccount, [description])\n"
                + "values (?,?,?,?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, recharge.getUserId());
            ps.setTimestamp(2, recharge.getRechargeDate());
            ps.setInt(3, recharge.getAmout());
            ps.setString(4, recharge.getStatus());
            ps.setString(5, recharge.getBankAccount());
            ps.setString(6, recharge.getDescription());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Recharge> getById(int id) {
        ArrayList<Recharge> list = new ArrayList<>();
        String sql = "select * from recharge where user_id = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Recharge recharege = new Recharge();
                recharege.setId(rs.getInt(ID));
                recharege.setUserId(rs.getInt(USER_ID));
                recharege.setStatus(rs.getString(STATUS));
                recharege.setRechargeDate(rs.getTimestamp(DATE));
                recharege.setAmout(rs.getInt(AMOUNT));
                recharege.setBankAccount(rs.getString(BANK_ACCOUNT));
                recharege.setDescription(rs.getString(DESCRIPTION));
                list.add(recharege);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Recharge> listAllRecharge() {
        ArrayList<Recharge> list = new ArrayList<>();
        String sql = "select * from recharge order by id DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Recharge recharege = new Recharge();
                recharege.setId(rs.getInt(ID));
                recharege.setUserId(rs.getInt(USER_ID));
                recharege.setStatus(rs.getString(STATUS));
                recharege.setRechargeDate(rs.getTimestamp(DATE));
                recharege.setAmout(rs.getInt(AMOUNT));
                recharege.setBankAccount(rs.getString(BANK_ACCOUNT));
                recharege.setDescription(rs.getString(DESCRIPTION));
                list.add(recharege);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Recharge> listErrorRecharge() {
        ArrayList<Recharge> list = new ArrayList<>();
        String sql = "select * from recharge where status='Error' order by id DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Recharge recharege = new Recharge();
                recharege.setId(rs.getInt(ID));
                recharege.setUserId(rs.getInt(USER_ID));
                recharege.setStatus(rs.getString(STATUS));
                recharege.setRechargeDate(rs.getTimestamp(DATE));
                recharege.setAmout(rs.getInt(AMOUNT));
                recharege.setBankAccount(rs.getString(BANK_ACCOUNT));
                recharege.setDescription(rs.getString(DESCRIPTION));
                list.add(recharege);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Recharge> searchErrorRecharge(String search) {
        ArrayList<Recharge> list = new ArrayList<>();
        String sql = "select * from recharge where status='Error' order by id DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Recharge recharege = new Recharge();
                recharege.setId(rs.getInt(ID));
                recharege.setUserId(rs.getInt(USER_ID));
                recharege.setStatus(rs.getString(STATUS));
                recharege.setRechargeDate(rs.getTimestamp(DATE));
                recharege.setAmout(rs.getInt(AMOUNT));
                recharege.setBankAccount(rs.getString(BANK_ACCOUNT));
                recharege.setDescription(rs.getString(DESCRIPTION));
                list.add(recharege);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Recharge> listSuccessRecharge() {
        ArrayList<Recharge> list = new ArrayList<>();
        String sql = "select * from recharge where status='Success' order by id DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Recharge recharege = new Recharge();
                recharege.setId(rs.getInt(ID));
                recharege.setUserId(rs.getInt(USER_ID));
                recharege.setStatus(rs.getString(STATUS));
                recharege.setRechargeDate(rs.getTimestamp(DATE));
                recharege.setAmout(rs.getInt(AMOUNT));
                recharege.setBankAccount(rs.getString(BANK_ACCOUNT));
                recharege.setDescription(rs.getString(DESCRIPTION));
                list.add(recharege);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Recharge> searchSuccessRecharge(String name) {
        ArrayList<Recharge> list = new ArrayList<>();
        String sql = "select * from recharge where status='Success'\n"
                + "                    and user_id= (select id from [user] where  username= ?)\n"
                + "                    or user_id= (select id from [user] where  email= ?)\n"
                + "                    or user_id= (select id from [user] where  telephone= ?)\n"
                + "                    order by id DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, name);
            st.setString(3, name);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Recharge recharege = new Recharge();
                recharege.setId(rs.getInt(ID));
                recharege.setUserId(rs.getInt(USER_ID));
                recharege.setStatus(rs.getString(STATUS));
                recharege.setRechargeDate(rs.getTimestamp(DATE));
                recharege.setAmout(rs.getInt(AMOUNT));
                recharege.setBankAccount(rs.getString(BANK_ACCOUNT));
                recharege.setDescription(rs.getString(DESCRIPTION));
                list.add(recharege);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateRechargeStatus(String username, int id) {
        String sql = "update Recharge set status='Success', user_id= (select id from [user] where  username= ?) where id= ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean deleteRecharge(int iid) {
        String sql = "DELETE FROM [Recharge] WHERE id =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, iid);
            int row = ps.executeUpdate();
            if (row == 0) {
                return false;
            }

            return true;
        } catch (Exception e) {
        }
        return false;
    }
}
