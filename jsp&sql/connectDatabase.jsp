<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Step 0: import library --> 
<%@ page import = "java.sql.*" %> 
<html>
    <head>
        <title>JSP Page</title>
    </head>
    <body> 
<%  	
    try {
//Step 1: 載入資料庫驅動程式 
        	Class.forName("com.mysql.jdbc.Driver");	  
	//使用JDBC去連結MySQL，所以該行語法的意思，就是要告訴電腦我要使用JDBC
        try {
//Step 2: 建立連線 
        	String url="jdbc:mysql://localhost/?serverTimezone=UTC";
            Connection con=DriverManager.getConnection(url,"root","1234");   
		//建立connection(連線)的語法，url代表我所要連結的MySQL所在IP，root是帳號，1234是密碼
		//此連線是指和mySql連線，不是和存在mySql內的特定資料庫連線。		
//Step 5: 顯示結果 				
		   if(con.isClosed())
		//con.isClosed()會回傳True或是false來表示是否連線成功
              out.println("連線建立失敗");
           else
              out.println("連線成功");
//Step 6: 關閉連線
           con.close();
        }            
        catch (SQLException sExec) {
           out.println("SQL錯誤!" + sExec.toString());
        }
    }       
    catch (ClassNotFoundException err) {
          out.println("class錯誤" + err.toString());
    }    
%>      
    </body>
</html>
