/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Cart;
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
public class CartDAO extends GenericDAO<Cart> {

    Connection connection;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List<Cart> findAll() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int insert(Cart t) {
        return insertGenericDAO(t);
    }

    public List<Cart> findCartByID(String userID) {
        List<Cart> cartList = new ArrayList<>();
        Cart cart;
        String sql = "SELECT [cartID]\n"
                + "      ,[userID]\n"
                + "      ,[productID]\n"
                + "      ,[totalPrice]\n"
                + "       , [quantity]\n"
                + "       , [status]\n"
                + ", [orderID]\n"
                + "  FROM [dbo].[Cart] WHERE userID = ? AND status = 1";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                cart = Cart.builder().cartID(rs.getString("cartID")).userID(rs.getString("userID")).productID(rs.getString("productID")).totalPrice(rs.getFloat("totalPrice")).quantity(rs.getInt("quantity")).status(rs.getBoolean("status")).orderID(rs.getString("orderID")).build();
                cartList.add(cart);
            }
        } catch (Exception e) {
        }
        return cartList;
    }

    public List<Cart> findOrder(String orderID) {
        List<Cart> cartList = new ArrayList<>();
        Cart cart;
        String sql = "SELECT [cartID]\n"
                + "      ,[userID]\n"
                + "      ,[productID]\n"
                + "      ,[totalPrice]\n"
                + "       , [quantity]\n"
                + "       , [status]\n"
                + ", [orderID]\n"
                + "  FROM [dbo].[Cart] WHERE orderID = ? AND status = 0";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, orderID);
            rs = ps.executeQuery();
            while (rs.next()) {
                cart = Cart.builder().cartID(rs.getString("cartID")).userID(rs.getString("userID")).productID(rs.getString("productID")).totalPrice(rs.getFloat("totalPrice")).quantity(rs.getInt("quantity")).status(rs.getBoolean("status")).orderID(rs.getString("orderID")).build();
                cartList.add(cart);
            }
        } catch (Exception e) {
        }
        return cartList;
    }

    public Cart findCartByPizzaID(String pizzaID) {
        Cart cart = null;
        String sql = "SELECT [cartID]\n"
                + "      ,[userID]\n"
                + "      ,[productID]\n"
                + "      ,[totalPrice]\n"
                + "       , [quantity]\n"
                + ", [status]\n"
                + ", [orderID]\n"
                + "  FROM [dbo].[Cart] WHERE productID = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, pizzaID);
            rs = ps.executeQuery();
            while (rs.next()) {
                cart = Cart.builder().cartID(rs.getString("cartID")).userID(rs.getString("userID")).productID(rs.getString("productID")).totalPrice(rs.getFloat("totalPrice")).quantity(rs.getInt("quantity")).status(rs.getBoolean("status")).orderID(rs.getString("orderID")).build();
            }
        } catch (Exception e) {
        }
        return cart;
    }

    public void updateQuantity(String productID, int newQuantity) {
        String sql = "UPDATE [dbo].[Cart]\n"
                + "   SET [quantity] = ? WHERE productID = ? ";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, newQuantity);
            ps.setString(2, productID);
            ps.executeUpdate();
        } catch (Exception e) {
        }

    }

    public Cart findCartByPizzaIDAndAccountID(String pizzaID, String userID) {
        Cart cart = null;
        String sql = "SELECT [cartID]\n"
                + "      ,[userID]\n"
                + "      ,[productID]\n"
                + "      ,[totalPrice]\n"
                + "       , [quantity]\n"
                + ", [status]\n"
                + " , [orderID]\n"
                + "  FROM [dbo].[Cart] WHERE productID = ? AND userID = ? AND status = 1";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, pizzaID);
            ps.setString(2, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                cart = Cart.builder().cartID(rs.getString("cartID")).userID(rs.getString("userID")).productID(rs.getString("productID")).totalPrice(rs.getFloat("totalPrice")).quantity(rs.getInt("quantity")).status(rs.getBoolean("status")).orderID(rs.getString("orderID")).build();
            }
        } catch (Exception e) {
        }
        return cart;
    }

    public void updateStatus(String userID) {
        String sql = "UPDATE [dbo].[Cart]\n"
                + "   SET [status] = ? WHERE userID = ? ";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setBoolean(1, false);
            ps.setString(2, userID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateOrderID(String orderID, String cartID) {
        String sql = "UPDATE [dbo].[Cart]\n"
                + "   SET [orderID] = ? WHERE cartID = ? ";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, orderID);
            ps.setString(2, cartID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void deleteCart(String id) {
        String sql = "DELETE FROM [dbo].[Cart]\n"
                + "      WHERE cartID = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

}
