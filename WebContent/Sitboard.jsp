<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import = "sensor.PollutionDAO" %>
<%@ page import = "sensor.Pollution" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id = "Pollution" class = "sensor.Pollution" scope = "page">
<jsp:setProperty name = "Pollution" property = "*"/>
</jsp:useBean>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width" , initial-scale="1">
	<title>Smart-Helmet</title>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css">
	<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
	</style>
	
	
</head>
<body>


<% 

String userID = null;
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}

 String url = "jdbc:mysql://localhost/wbkim11";
 String SQLid = "wbkim11";
 String SQLpw = "q1w2e3r4";

 Connection conn = null;
 Statement stmt = null;
 ResultSet rs = null;


 
    //여기 별표
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, SQLid, SQLpw);
    stmt = conn.createStatement();
    rs = stmt.executeQuery("select * from sensorpollution WHERE 1;");
    boolean flags = false;

    rs.next();
    int Ppm = rs.getInt(2);
    

    
%>

<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">Smart-Helmet</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="main.jsp">메인</a></li>
					<li><a href="bbs.jsp">관리자게시판</a></li>
					<li><a href="bbs2.jsp">근로자게시판</a></li>
					<li><a href="Attend.jsp">출근부</a></li>
					<li><a href="GoogleMap.jsp">근로자 위치 검색</a></li>
				</ul>
				<%
				if (userID == null) {
				%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
				<%
				}
				else {
				%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				</ul>
				<%
				}
				%>
			</div>
		</div>
	</nav>
	
	

</body>
</html>



