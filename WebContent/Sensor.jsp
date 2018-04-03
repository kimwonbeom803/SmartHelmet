<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "sensor.AccelerationDAO" %>
<%@ page import = "sensor.DistanceDAO" %>
<%@ page import = "sensor.PollutionDAO" %>
<%@ page import = "sensor.VibrationDAO" %>
<%@ page import = "sensor.LedDAO" %>
<%@ page import = "sensor.VibrationInputDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.*" %>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id = "accel" class = "sensor.Acceleration" scope = "page">
<jsp:setProperty name = "accel" property = "*"/>
</jsp:useBean>
<jsp:useBean id = "distance" class = "sensor.Distance" scope = "page">
<jsp:setProperty name = "distance" property = "*"/>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Sensor</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String kind = request.getParameter("kind");
String userID = request.getParameter("userID");
String data = request.getParameter("data");

/*int Distance = 0;
int Accel = 0;
int Pollution = 0;
int InVibration = 0;
int OutVibration = 0;
int OutLED = 0;

if (kind == "InputDistanceMeasure"){
	Distance = 1;
	out.print("1");
	DistanceDAO disDAO = new DistanceDAO();
	int InputDistanceMeasure = Integer.parseInt(data);
	distance.setUserID(userID);
	distance.setInputDistanceMeasure(InputDistanceMeasure);
	disDAO.joinDistance(distance);
} else if (kind == "InputPollutionMeasure") {
	Pollution = 3 ;
	PollutionDAO polDAO = new PollutionDAO();
	int InputPollutionMeasure = Integer.parseInt(data);
	pollution.setUserID(userID);
	pollution.setInputPollutionMeasure(InputPollutionMeasure);
	polDAO.joinPollution(pollution);
	out.print("3");
}
/*if (kind == "InputAccelerationMeasure") {
	Accel = 2;
	out.print("2");
}*/
/*if (kind == "InputPollutionMeasure") {
	Pollution = 3 ;
	PollutionDAO polDAO = new PollutionDAO();
	int InputPollutionMeasure = Integer.parseInt(data);
	pollution.setUserID(userID);
	pollution.setInputPollutionMeasure(InputPollutionMeasure);
	polDAO.joinPollution(pollution);
	out.print("3");
}
if (kind == "InputVibrationMeasure") {
	InVibration = 4;
	out.print("4");
}
if (kind == "OutputVibration"){
	OutVibration = 5;
	out.print("6");
}
if (kind == "OutputLED"){
	OutLED = 6;
	out.print("6");
}
*/


try{

	switch(Integer.parseInt(kind)) {
		//적외선(거리)
		case 1 :
			DistanceDAO disDAO = new DistanceDAO();
			int InputDistanceMeasure = Integer.parseInt(data);
			distance.setUserID(userID);
			distance.setInputDistanceMeasure(InputDistanceMeasure);
			disDAO.joinDistance(distance);
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
	}
	out.print("0");
}catch(Exception e) {
	e.printStackTrace();
	out.print("1");
}
%>
</body>
</html>