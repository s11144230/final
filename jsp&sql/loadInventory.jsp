<%@ page import="java.sql.*, org.json.*" %>
<%@ include file="connectDatabase.jsp" %>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    JSONArray productsArray = new JSONArray();

    try {
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        stmt = conn.createStatement();
        String sql = "SELECT name, quantity FROM products";
        rs = stmt.executeQuery(sql);

        while (rs.next()) {
            JSONObject product = new JSONObject();
            product.put("name", rs.getString("name"));
            product.put("quantity", rs.getInt("quantity"));
            productsArray.put(product);
        }

        response.setContentType("application/json");
        response.getWriter().write(productsArray.toString());

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
