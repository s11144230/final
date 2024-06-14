
</body><%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
</head>
<body>
    <h2>Your Cart</h2>
    <table border="1">
        <tr>
            <th>Product</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>
        <% 
            // 定義資料庫連線信息
            String url = "jdbc:mysql://localhost:3306/ecommerce";
            String username = "root";
            String password = "password";
            
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            try {
                // 連接資料庫
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, username, password);
                
                // 準備查詢
                String userId = "1"; // 假設當前用戶的ID是1，實際應用中應從session中獲取
                String query = "SELECT p.name, c.quantity, p.price FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, userId);
                
                // 執行查詢
                rs = ps.executeQuery();
                
                // 顯示結果
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getInt("quantity") %></td>
            <td><%= rs.getBigDecimal("price") %></td>
        </tr>
        <% 
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                // 關閉資源
                try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        %>
    </table>
</body>
</html>

</html>
