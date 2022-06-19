<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "sensor.PollutionDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id = "pollution" class = "sensor.Pollution" scope = "page">
<jsp:setProperty name = "pollution" property = "*"/>
</jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>About Distance Sensor</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
PollutionDAO polDAO = new PollutionDAO();

String userID = request.getParameter("userID");
String PollutionMeasure = request.getParameter("InputPollutionMeasure");
int InputPollutionMeasure = Integer.parseInt(PollutionMeasure);
pollution.setUserID(userID);
pollution.setInputPollutionMeasure(InputPollutionMeasure);

polDAO.joinPollution(pollution);
%>


</body>
</html>