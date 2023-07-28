/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Statistics;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 *
 * @author MSII
 */
public class UtilitiesDAO extends DBContext {

    public List<Statistics> getStatistics() {
        List<Statistics> list = new ArrayList<>();
        String sql = "SELECT TOP 6 month(enrolled_at),  year(enrolled_at) as month, sum(price) as sumPrice\n"
                + "FROM enrollments  group by MONTH(enrolled_at), year(enrolled_at)\n"
                + "                  order by MONTH(enrolled_at) DESC , year(enrolled_at) DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Statistics s= new Statistics(rs.getInt(1), rs.getInt(2), rs.getInt(3));
                list.add(s);
            }

        } catch (Exception e) {
            Logger.getLogger(e.getMessage());
        }
        return list;
    }

}
