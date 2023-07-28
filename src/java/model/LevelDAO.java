/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Category;
import entity.Level;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author MSII
 */
public class LevelDAO extends DBContext {

    PreparedStatement ps = null;
    ResultSet rs = null;

    public Map<Integer, Level> getMapLevel() {
        Map<Integer, Level> list = new HashMap<>();
        String sql = "select * from courses_level";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Level level = new Level(rs.getInt(1), rs.getString(2));
                list.put(rs.getInt(1), level);
            }
            connection.close();
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Level getLevelById(int id) {
        Level level = new Level();
        String sql = "select * from courses_level where id= ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
                        
            rs = ps.executeQuery();
            while (rs.next()) {
                level = new Level(rs.getInt(1), rs.getString(2));
            }
            connection.close();
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return level;
    }
}
