<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
</head>
<body>
    <h2>Order Confirmation</h2>
    <%
        // 获取表单提交的订单信息
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String paymentMethod = request.getParameter("payment");
        
        // 假设从 session 中获取用户ID
        String userId = (String) session.getAttribute("user_id");

        // 数据库连接信息
        String url = "jdbc:mysql://localhost:3306/ecommerce?serverTimezone=UTC";
        String username = "root";
        String password = "1234";
        
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // 加载数据库驱动程序
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 建立数据库连接
            con = DriverManager.getConnection(url, username, password);
            
            // 准备插入订单的 SQL 语句
            String insertQuery = "INSERT INTO orders (fullname, address, city, country, payment_method, user_id) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(insertQuery);
            ps.setString(1, fullname);
            ps.setString(2, address);
            ps.setString(3, city);
            ps.setString(4, country);
            ps.setString(5, paymentMethod);
            ps.setString(6, userId);

            // 执行插入操作
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
    %>
    <p>訂單已成功提交！</p>
    <%
            } else {
    %>
    <p>提交訂單失敗。</p>
    <%
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println("資料庫錯誤：" + e.getMessage());
        } finally {
            // 关闭数据库连接
            try { if (ps != null) ps.close(); } catch (SQLException e) { /* ignored */ }
            try { if (con != null) con.close(); } catch (SQLException e) { /* ignored */ }
        }
    %>
</body>
</html>
