<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	request.setCharacterEncoding("UTF-8");

	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");
	String userName = request.getParameter("userName");
	String userGender = request.getParameter("userGender");
	String userEmail = request.getParameter("userEmail");
	String userBelong = request.getParameter("userBelong");
	String userAuthority = request.getParameter("userAuthority");

	String url = "jdbc:mysql://localhost:3306/smartdb"; //db연결 주소
	String SQLid = "root"; //db 아이디
	String SQLpw = "passwd"; //db 패스워드

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	int count =1;

	try{
		//여기 별표
		Class.forName("com.mysql.jdbc.Driver"); //연결을 위한 필수 작업
		conn = DriverManager.getConnection(url, SQLid, SQLpw);//데이터베이스 로그인
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from user"); 
		boolean flags = false;
		while(rs.next()) // 로그인 중복 id를 방지
		{
			String UID = rs.getString("userID");
			if(UID.equals(userID)) 
			{
				out.print("Overlapping id");
				flags = true; //중복된 id를 찾으면 true 반환
				break;
			}
			count++;
		}
		
		if(flags == false)
		{
				stmt.executeUpdate("insert into user values('"+userID+"','"+userPassword+"','"+userName+"','"+userGender+"','"+userEmail+"','"+userBelong+"','"+userAuthority+"');");
				out.print("Regist Success");
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