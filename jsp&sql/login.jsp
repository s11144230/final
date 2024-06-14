<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost/ecommerce?serverTimezone=UTC";
            con = DriverManager.getConnection(url, "root", "1234");
            ps = con.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // 登入成功
                out.print("登入成功，歡迎您，" + rs.getString("username"));
            } else {
                out.print("無效的電子郵件地址或密碼");
            }
        } catch (ClassNotFoundException e) {
            out.print("找不到数据库驱动程序：" + e.getMessage());
        } catch (SQLException e) {
            out.print("数据库错误：" + e.getMessage());
        } finally {
            // 关闭资源
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>
