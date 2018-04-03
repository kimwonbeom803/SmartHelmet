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

	String url = "jdbc:mysql://localhost:3306/smartdb"; //db���� �ּ�
	String SQLid = "root"; //db ���̵�
	String SQLpw = "passwd"; //db �н�����

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	int count =1;

	try{
		//���� ��ǥ
		Class.forName("com.mysql.jdbc.Driver"); //������ ���� �ʼ� �۾�
		conn = DriverManager.getConnection(url, SQLid, SQLpw);//�����ͺ��̽� �α���
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from user"); 
		boolean flags = false;
		while(rs.next()) // �α��� �ߺ� id�� ����
		{
			String UID = rs.getString("userID");
			if(UID.equals(userID)) 
			{
				out.print("Overlapping id");
				flags = true; //�ߺ��� id�� ã���� true ��ȯ
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