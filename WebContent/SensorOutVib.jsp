<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "sensor.VibrationDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id = "outvib" class = "sensor.Vibration" scope = "page">
<jsp:setProperty name = "outvib" property = "*"/>
</jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>About OutVib Sensor</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
VibrationDAO vibDAO = new VibrationDAO();

String userID = request.getParameter("userID");
String OutVibration = request.getParameter("OutputVibration");
int OutputVibration = Integer.parseInt(OutVibration);
outvib.setUserID(userID);
outvib.setOutputVibration(OutputVibration);

vibDAO.joinVibration(outvib);
%>

</body>
</html>