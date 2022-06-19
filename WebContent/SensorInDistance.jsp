
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "sensor.DistanceDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.*" %>
<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id = "distance" class = "sensor.Distance" scope = "page">
<jsp:setProperty name = "distance" property = "*"/>
</jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
DistanceDAO disDAO = new DistanceDAO();

String userID = request.getParameter("userID");
String DistanceMeasure = request.getParameter("InputDistanceMeasure");
String DistanceID = request.getParameter("DistanceID");

int InputDistanceMeasure = Integer.parseInt(DistanceMeasure);
int DistancedID = Integer.parseInt(DistanceID);

distance.setUserID(userID);
distance.setInputDistanceMeasure(InputDistanceMeasure);
distance.setDistanceID(DistanceID);

disDAO.joinDistance(distance);
%>
</body>
</html>