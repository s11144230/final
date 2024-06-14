<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert Member</title>
</head>
<body>
    <%
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String birthday = request.getParameter("birthday");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost/ecommerce?serverTimezone=UTC";
            conn = DriverManager.getConnection(url, "root", "1234");

            String sql = "INSERT INTO members (name, gender, birthday, email, phone, address) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, gender);
            stmt.setString(3, birthday);
            stmt.setString(4, email);
            stmt.setString(5, phone);
            stmt.setString(6, address);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<script>alert('保存成功！');</script>");
                // 或者你可以重定向到另一个页面
                // response.sendRedirect("success.jsp");
            } else {
                out.println("<script>alert('保存失败！');</script>");
                // 或者你可以重定向到错误页面
                // response.sendRedirect("error.jsp");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // 输出异常信息到控制台
            out.println("<script>alert('保存失败！');</script>"+e.getMessage());
            // 或者你可以重定向到错误页面
            // response.sendRedirect("error.jsp");
        } finally {
            // 关闭资源
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>
