/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Account;
import entity.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author ASUS
 */
public class OrderDAO extends GenericDAO<Order> {

    Connection connection;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List<Order> findAll() {
        return queryGenericDAO(Order.class);
    }

    public List<Order> findAllVer2() {
        List<Order> orderList = new ArrayList<>();
        Order order;
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Order]";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                order = Order.builder().orderID(rs.getString("orderID")).userID(rs.getString("userID")).date(rs.getDate("date")).build();
                orderList.add(order);
            }
        } catch (Exception e) {
        }
        return orderList;
    }

    @Override
    public int insert(Order t) {
        return insertGenericDAO(t);
    }

    public boolean insertV2(Order order) {
        boolean result = false;
        String sql = "INSERT INTO [dbo].[Order]\n"
                + "           ([orderID]\n"
                + "           ,[userID]\n"
                + "           ,[date])\n"
                + "     VALUES\n"
                + "           (?, ? , ?)";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, order.getOrderID());
            ps.setString(2, order.getUserID());
            ps.setDate(3, order.getDate());
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
        }
        return result;
    }
    public Order findByID(String id){
        Order order = null;
        String sql = "SELECT *\n"
                + "  FROM [dbo].[Order] WHERE orderID = ? ";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while(rs.next()){
                order  = Order.builder().orderID(rs.getString("orderID")).userID(rs.getString("userID")).date(rs.getDate("date")).build();
            }
        } catch (Exception e) {
        }
        return order;
    }
}
