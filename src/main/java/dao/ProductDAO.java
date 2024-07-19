/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

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
public class ProductDAO extends GenericDAO<Product> {

    Connection connection;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List<Product> findAll() {
        return queryGenericDAO(Product.class);
    }

    @Override
    public int insert(Product t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean insertV2(Product product) {
        boolean result = false;
        String sql = "INSERT INTO [dbo].[Product]\n"
                + "           ([productID]\n"
                + "           ,[productName]\n"
                + "           ,[price]\n"
                + "           ,[image]\n"
                + "           ,[description]\n"
                + "           ,[status])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?, ?, ?)";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, product.getProductID());
            ps.setString(2, product.getProductName());
            ps.setFloat(3, product.getPrice());
            ps.setString(4, product.getImage());
            ps.setString(5, product.getDescription());
            ps.setBoolean(6, product.isStatus());
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
        }
        return result;
    }

    public List<Product> findByName(String search) {
        List<Product> productList = new ArrayList<>();
        Product product;
        String sql = "SELECT [productID]\n"
                + "      ,[productName]\n"
                + "      ,[price]\n"
                + "      ,[image]\n"
                + "      ,[description]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[Product]\n"
                + "  WHERE productName LIKE ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, '%' + search + '%');
            rs = ps.executeQuery();
            while (rs.next()) {
                product = Product.builder().
                        productID(rs.getString("productID")).
                        productName(rs.getString("productName")).
                        price(rs.getFloat("price")).
                        image(rs.getString("image")).description(rs.getString("description")).status(rs.getBoolean("status")).build();
                productList.add(product);
            }
        } catch (Exception e) {
        }
        return productList;
    }

    public List<Product> findAllV2() {
        List<Product> productList = new ArrayList<>();
        Product product;
        String sql = "SELECT [productID]\n"
                + "      ,[productName]\n"
                + "      ,[price]\n"
                + "      ,[image]\n"
                + "      ,[description]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[Product]";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                product = Product.builder().
                        productID(rs.getString("productID")).
                        productName(rs.getString("productName")).
                        price(rs.getFloat("price")).
                        image(rs.getString("image")).description(rs.getString("description")).status(rs.getBoolean("status")).build();
                productList.add(product);
            }
        } catch (Exception e) {
        }
        return productList;
    }

    public boolean deteleProductById(String productID) {
        boolean result = false;
        String sql = "DELETE FROM [dbo].[Product]\n"
                + "      WHERE ProductID = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, productID);
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
        }
        return result;
    }

    public Product findByID(String productID) {
        Product product = null;
        String sql = "SELECT [productID]\n"
                + "      ,[productName]\n"
                + "      ,[price]\n"
                + "      ,[image]\n"
                + "      ,[description]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[Product]\n"
                + "  WHERE productID = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, productID);
            rs = ps.executeQuery();
            while (rs.next()) {
                product = Product.builder().
                        productID(rs.getString("productID")).
                        productName(rs.getString("productName")).
                        price(rs.getFloat("price")).
                        image(rs.getString("image")).description(rs.getString("description")).status(rs.getBoolean("status")).build();
            }
        } catch (Exception e) {
        }
        return product;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [productName] = ?, [price] = ?, [image] = ?, "
                + "[description] = ? WHERE productID = ?";
        boolean result = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, product.getProductName());
            ps.setFloat(2, product.getPrice());
            ps.setString(3, product.getImage());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getProductID());
            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
        }
        return result;
    }

    public void updateStatusFalse(String productID) {
        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [status] = ? WHERE productID = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, "0");
            ps.setString(2, productID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateStatusTrue(String productID) {
        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [status] = ? WHERE productID = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, "1");
            ps.setString(2, productID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Product> findAllUser() {
        List<Product> productList = new ArrayList<>();
        Product product;
        String sql = "SELECT [productID]\n"
                + "      ,[productName]\n"
                + "      ,[price]\n"
                + "      ,[image]\n"
                + "      ,[description]\n"
                + "      ,[status]\n"
                + "  FROM [dbo].[Product] WHERE status = 1";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                product = Product.builder().
                        productID(rs.getString("productID")).
                        productName(rs.getString("productName")).
                        price(rs.getFloat("price")).
                        image(rs.getString("image")).description(rs.getString("description")).status(rs.getBoolean("status")).build();
                productList.add(product);
            }
        } catch (Exception e) {
        }
        return productList;
    }

    public List<Product> getAllMobilesWithCondition(float minPrice, float maxPrice) {
        List<Product> productList = new ArrayList<>();
        Product product;

        try {
            connection = DBUtils.getConnection();
            String sql = "";
            if (minPrice == -1 && maxPrice != -1) {
                sql = "SELECT * FROM [dbo].[Product]  WHERE price <= ?;";
            } else if (minPrice != -1 && maxPrice == -1) {
                sql = "SELECT * FROM [dbo].[Product] WHERE price >= ?;";
            } else if (minPrice == -1 && maxPrice == -1) {
                sql = "SELECT * FROM [dbo].[Product];";
            } else {
                sql = "SELECT * FROM [dbo].[Product] WHERE price >= ? AND price <= ?;";
            }
            ps = connection.prepareStatement(sql);

            if (minPrice == -1 && maxPrice != -1) {
                ps.setFloat(1, maxPrice);
            } else if (minPrice != -1 && maxPrice == -1) {
                ps.setFloat(1, minPrice);
            } else if (minPrice == -1 && maxPrice == -1) {
            } else {
                ps.setFloat(1, minPrice);
                ps.setFloat(2, maxPrice);
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                product = Product.builder().productID(rs.getString("productID")).productName(rs.getString("productName")).price(rs.getFloat("price")).image(rs.getString("image")).description(rs.getString("description")).status(rs.getBoolean("status")).build();
                productList.add(product);
            }
        } catch (Exception ex) {
        }

        return productList;
    }

    public List<Product> getAllProductWithSort(String value) {
        List<Product> productList = new ArrayList<>();
        Product product;

        try {
            connection = DBUtils.getConnection();
            String sql = "";
            if (value.equalsIgnoreCase("nameasc")) {
                sql = "SELECT * FROM [dbo].[Product] ORDER BY productName ASC";
            } else if (value.equalsIgnoreCase("namedesc")) {
                sql = "SELECT * FROM [dbo].[Product] ORDER BY productName DESC";
            } else if (value.equalsIgnoreCase("priceasc")) {
                sql = "SELECT * FROM [dbo].[Product] ORDER BY price ASC";
            } else if (value.equalsIgnoreCase("pricedesc")){
                sql = "SELECT * FROM [dbo].[Product] ORDER BY price DESC";
            }
            ps = connection.prepareStatement(sql);

            rs = ps.executeQuery();
            while (rs.next()) {
                product = Product.builder().productID(rs.getString("productID")).productName(rs.getString("productName")).price(rs.getFloat("price")).image(rs.getString("image")).description(rs.getString("description")).status(rs.getBoolean("status")).build();
                productList.add(product);
            }
        } catch (Exception ex) {
        }

        return productList;
    }
}
