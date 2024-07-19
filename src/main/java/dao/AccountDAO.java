/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Account;
import entity.Product;
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
public class AccountDAO extends GenericDAO<Account> {

    Connection connection;
    PreparedStatement ps;
    ResultSet rs;

    public Account getUser(String id, String password) {
        Account account = null;
        String sql = "SELECT [userID]\n"
                + "      ,[password]\n"
                + "      ,[fullName]\n"
                + "      ,[roleID]\n"
                + "      ,[image]\n"
                + "      ,[phone]\n"
                + "      ,[address]\n"
                + "  FROM [dbo].[Account] WHERE userID = ? AND password = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, password);
            rs = ps.executeQuery();
            while (rs.next()) {
                account = new Account(rs.getString("userID"), rs.getString("password"), rs.getString("fullName"), rs.getString("roleID"), rs.getString("image"), rs.getString("phone"), rs.getString("address"));
                return account;
            }
        } catch (Exception e) {
        }
        return account;
    }

    @Override
    public List<Account> findAll() {
        return queryGenericDAO(Account.class);
    }

    @Override
    public int insert(Account t) {
        return insertGenericDAO(t);
    }

    public boolean insertV2(Account account) {
        boolean result = false;
        String sql = "INSERT INTO [dbo].[Account]\n"
                + "           ([userID]\n"
                + "           ,[password]\n"
                + "           ,[fullName]\n"
                + "           ,[roleID]\n"
                + "           ,[image]\n"
                + "           ,[phone]\n"
                + "           ,[address])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?, ?)";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, account.getUserID());
            ps.setString(2, account.getPassword());
            ps.setString(3, account.getFullName());
            ps.setString(4, account.getRoleID());
            ps.setString(5, account.getImage());
            ps.setString(6, account.getPhone());
            ps.setString(7, account.getAddress());
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
        }
        return result;
    }

    public List<Account> findAllVer2() {
        List<Account> accountList = new ArrayList<>();
        Account account;
        String sql = "SELECT * FROM [PizzaStoreManagement].[dbo].[Account]";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                account = Account.
                        builder().userID(rs.getString("userID")).
                        password(rs.getString("password")).
                        fullName(rs.getString("fullName")).
                        roleID(rs.getString("roleID")).
                        image(rs.getString("image")).
                        phone(rs.getString("phone")).
                        address(rs.getString("addresss")).build();
                accountList.add(account);
            }
        } catch (Exception e) {
        }
        return accountList;
    }

    public List<Account> findbyUserIDorName(String query, String query2) {
        List<Account> accountList = new ArrayList<>();
        Account acc;
        String sql = "SELECT * FROM [dbo].[Account] WHERE userID LIKE ? OR fullName LIKE ?;";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, '%' + query + '%');
            ps.setString(2, '%' + query2 + '%');
            rs = ps.executeQuery();
            while (rs.next()) {
                acc = Account.builder().userID(rs.getString("userID")).fullName(rs.getString("fullName")).password(rs.getString("password")).roleID(rs.getString("roleID")).image(rs.getString("image")).phone(rs.getString("phone")).address(rs.getString("address")).build();
                accountList.add(acc);
            }
        } catch (Exception e) {
        }
        return accountList;
    }

    public boolean deleteAccountByID(String userID) {
        boolean result = false;
        String sql = "DELETE FROM [dbo].[Account]\n"
                + "      WHERE userID = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, userID);
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
        }
        return result;
    }

    public Account findbyID(String userID) {
        Account account = null;
        String sql = "SELECT [userID]\n"
                + "      ,[password]\n"
                + "      ,[fullName]\n"
                + "      ,[roleID]\n"
                + "      ,[image]\n"
                + "      ,[phone]\n"
                + "      ,[address]\n"
                + "  FROM [dbo].[Account] WHERE userID = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                account = Account.builder().userID(rs.getString("userID")).fullName(rs.getString("fullName")).password(rs.getString("password")).roleID(rs.getString("roleID")).image(rs.getString("image")).phone(rs.getString("phone")).address(rs.getString("address")).build();
            }
        } catch (Exception e) {
        }
        return account;
    }

    public boolean updateAccount(Account acccount) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [password] = ?\n"
                + "      ,[fullName] = ?\n"
                + "      ,[roleID] = ?\n"
                + "      ,[image] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[address] = ? where userID = ?";
        boolean result = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, acccount.getPassword());
            ps.setString(2, acccount.getFullName());
            ps.setString(3, acccount.getRoleID());
            ps.setString(4, acccount.getImage());
            ps.setString(5, acccount.getPhone());
            ps.setString(6, acccount.getAddress());
            ps.setString(7, acccount.getUserID());
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
        }
        return result;
    }

    public boolean updateAccountVer2(Account acccount) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "    SET  [fullName] = ?\n"
                + "      ,[image] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[address] = ? where userID = ?";
        boolean result = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, acccount.getFullName());
            ps.setString(2, acccount.getImage());
            ps.setString(3, acccount.getPhone());
            ps.setString(4, acccount.getAddress());
            ps.setString(5, acccount.getUserID());
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
        }
        return result;
    }
}
