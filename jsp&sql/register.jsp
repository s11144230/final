<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title>創建表格和插入數據</title>
</head>
<body>
<h1>註冊用戶</h1>


<%
String username = request.getParameter("name");
String password = request.getParameter("password");
String email = request.getParameter("email");

out.println("<h2>表單提交狀態</h2>");
if (username != null && password != null && email != null) {
    out.println("收到的參數:<br>");
    out.println("用戶名: " + username + "<br>");
    out.println("密碼: " + password + "<br>");
    out.println("電子郵件: " + email + "<br>");

    Connection con = null;
    PreparedStatement ps = null;
    try {
        // 步驟1: 載入資料庫驅動程式
        
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 步驟2: 建立連線
        
        String url = "jdbc:mysql://localhost/ecommerce?serverTimezone=UTC";
        con = DriverManager.getConnection(url, "root", "1234");

        // 步驟4: 插入數據
        
        String insertSQL = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";
        ps = con.prepareStatement(insertSQL);
        ps.setString(1, username);
        ps.setString(2, password); // 在實際應用中應使用哈希函數加密密碼
        ps.setString(3, email);
        int i = ps.executeUpdate();
        if (i > 0) {
            out.println("註冊成功...<br>");
        } else {
            out.println("註冊失敗...<br>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("ClassNotFoundException: " + e.getMessage() + "<br>");
    } finally {
        if (ps != null) {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
} else {
    out.println("請填寫所有字段...<br>");
}
%>
</body>
</html>
