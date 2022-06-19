<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "sensor.AccelerationDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id = "accel" class = "sensor.Acceleration" scope = "page">
<jsp:setProperty name = "accel" property = "*"/>
</jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>About Acceleration Sensor</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
AccelerationDAO accelDAO = new AccelerationDAO();

String userID = request.getParameter("userID");
String AccelerationMeasure = request.getParameter("InputAccelerationMeasure");
int InputAccelerationMeasure = Integer.parseInt(AccelerationMeasure);
accel.setUserID(userID);
accel.setInputAccelerationMeasure(InputAccelerationMeasure);

accelDAO.joinAcceleration(accel);
%>

</body>
</html>