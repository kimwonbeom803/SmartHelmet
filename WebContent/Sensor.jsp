<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import = "sensor.AccelerationDAO" %>
<%@ page import = "JSP.LocationDAO" %>
<%@ page import = "JSP.CommuteDAO" %>
<%@ page import = "sensor.DistanceDAO" %>
<%@ page import = "sensor.PollutionDAO" %>
<%@ page import = "sensor.VibrationDAO" %>
<%@ page import = "sensor.LedDAO" %>
<%@ page import = "sensor.VibrationInputDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.*" %>
<%@ page import = "user.UserDAO" %>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id = "accel" class = "sensor.Acceleration" scope = "page">
<jsp:setProperty name = "accel" property = "*"/>
</jsp:useBean>
<jsp:useBean id = "distance" class = "sensor.Distance" scope = "page">
<jsp:setProperty name = "distance" property = "*"/>
</jsp:useBean>
<jsp:useBean id = "commute" class = "JSP.Commute" scope = "page">
<jsp:setProperty name = "commute" property = "*"/>
</jsp:useBean>
<jsp:useBean id = "pollution" class = "sensor.Pollution" scope = "page">
<jsp:setProperty name = "pollution" property = "*"/>
</jsp:useBean>
<jsp:useBean id = "outvib" class = "sensor.Vibration" scope = "page">
<jsp:setProperty name = "outvib" property = "*"/>
</jsp:useBean>
<jsp:useBean id = "invib" class = "sensor.VibrationInput" scope = "page">
<jsp:setProperty name = "invib" property = "*"/>
</jsp:useBean>
<jsp:useBean id = "led" class = "sensor.Led" scope = "page">
<jsp:setProperty name = "led" property = "*"/>
</jsp:useBean>
<jsp:useBean id = "location" class = "JSP.Location" scope = "page">
<jsp:setProperty name = "location" property = "*"/>
</jsp:useBean>
<jsp:useBean id = "User" class = "user.User" scope = "page">
<jsp:setProperty name = "User" property = "*"/>
</jsp:useBean>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sensor</title>
</head>
<body>
<%

 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd");
 String today = formatter.format(new java.util.Date());
 
request.setCharacterEncoding("UTF-8");
String kind = request.getParameter("kind");
String userID = request.getParameter("userID");
String data = request.getParameter("data");
String dataX = request.getParameter("dataX");
String dataY = request.getParameter("dataY");




try{

   switch(Integer.parseInt(kind)) {
      //적외선(거리)
      case 1 :
        /* DistanceDAO disDAO = new DistanceDAO();
         int InputDistanceMeasure = Integer.parseInt(data);
         distance.setUserID(userID);
         distance.setInputDistanceMeasure(InputDistanceMeasure);
         disDAO.joinDistance(distance);
         */
         
 		CommuteDAO comDAO = new CommuteDAO();
		String[] array;
		array = data.split("/");
		if(array.length == 1)
		{
			commute.setUserID(userID);
			commute.setDate(today);
			commute.setAttendtime(array[0]);
			commute.setClosetime("--:--:--");
			//comDAO.deleteCommute(commute);

		}else{
			comDAO.deleteCommute(commute);
			commute.setUserID(userID);
			commute.setDate(today);
			commute.setAttendtime(array[0]);
			commute.setClosetime(array[1]);

		}
		 
		 comDAO.joinCommute(commute);
		 break;         
      //가속도(기울기)
      case 2 :
         AccelerationDAO accelDAO = new AccelerationDAO();
         int InputAccelerationMeasure = Integer.parseInt(data);
         accel.setUserID(userID);
         accel.setInputAccelerationMeasure(InputAccelerationMeasure);
         accelDAO.joinAcceleration(accel);
         break;
      //오염도(가스)
      case 3 :
         
    	 PollutionDAO polDAO = new PollutionDAO();
         int InputPollutionMeasure = Integer.parseInt(data);
	 	 polDAO.deletePollution(userID);
	 	 pollution.setUserID(userID);
         pollution.setInputPollutionMeasure(InputPollutionMeasure);
         polDAO.joinPollution(pollution);
         
         break;
      //진동(입력)   
      case 4 :
         VibrationInputDAO invibDAO = new VibrationInputDAO();
         int InputVibrationMeasure = Integer.parseInt(data);
         invib.setUserID(userID);
         invib.setInputVibrationMeasure(InputVibrationMeasure);
         invibDAO.joinVibrationInput(invib);
         break;
      //LED
      case 5 :
         VibrationDAO vibDAO = new VibrationDAO();
         int OutputVibration = Integer.parseInt(data);
         outvib.setUserID(userID);
         outvib.setOutputVibration(OutputVibration);
         vibDAO.joinVibration(outvib);
         break;
      //진동(출력)
      case 6 :
         LedDAO ledDAO = new LedDAO();
         int OutputLED = Integer.parseInt(data);
         led.setUserID(userID);
         led.setOutputLED(OutputLED);
         ledDAO.joinLed(led);
         break;
      case 7 :

	 		LocationDAO locDAO = new LocationDAO();
	 		double X = Double.parseDouble(dataX);
	 		double Y = Double.parseDouble(dataY);
	 		locDAO.deleteLocation(userID);
			location.setUserID(userID);
			location.setName(userID);
			location.setLocationx(X);
			location.setLocationy(Y);
			//
			locDAO.joinLocation(location);
			out.print("0");
			break;
      case 8:
    	  UserDAO userDAO = new UserDAO();
    	  String token = data;
    	  User.setUserToken(token);
    	  User.setUserID(userID);
    	  
    	  userDAO.update(token, userID);
    	   out.print(token);
   }
   
   //out.print("0");
}catch(Exception e) {
   e.printStackTrace();
   out.print("1");
}
%>
</body>
