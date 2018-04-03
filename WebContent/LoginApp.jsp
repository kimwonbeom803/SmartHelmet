<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");

	String url = "jdbc:mysql://localhost:3306/smartdb";
	String SQLid = "root";
	String SQLpw = "passwd";

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	try{
		//여기 별표
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, SQLid, SQLpw);
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from user;");
		boolean flags = false;
		while(rs.next())
		{
			String UID = rs.getString("userID");
			String UPWD = rs.getString("userPassword");
			if(UID.equals(userID) && UPWD.equals(userPassword))
			{
				out.print("Login Success");
				flags = true;
				break;
			}else if(UID.equals(userID))
			{
				out.print("Check PWD");
				flags = true;
				break;
			}
		}
		if(flags == false)
		{
			out.print("No ID");
		}
	}
	catch(SQLException e){
			out.print(e.getMessage());
	}
		
	finally{
		if(rs != null) try{rs.close();} catch( SQLException ex){}
		if(stmt != null) try{stmt.close();} catch( SQLException ex){}
		if(conn != null) try{conn.close();} catch( SQLException ex){}
	}
	
%>