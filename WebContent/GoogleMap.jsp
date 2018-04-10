
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import = "sensor.AccelerationDAO" %>
<%@ page import = "JSP.LocationDAO" %>
<%@ page import = "JSP.Location" %>
<%@ page import = "sensor.PollutionDAO" %>
<%@ page import = "sensor.VibrationDAO" %>
<%@ page import = "sensor.LedDAO" %>
<%@ page import = "sensor.VibrationInputDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id = "location" class = "JSP.Location" scope = "page">
<jsp:setProperty name = "location" property = "*"/>
</jsp:useBean>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>근로자 위치 검색</title> 

</head>

<body onload="initialize()"> 

<% 
 request.setCharacterEncoding("UTF-8");
 String kind = request.getParameter("kind");
 String userID = request.getParameter("userID");
 String dataX = request.getParameter("dataX");
 String dataY = request.getParameter("dataY");
 

 String id = request.getParameter("id");
 String pwd = request.getParameter("pwd");

 String url = "jdbc:mysql://localhost/wbkim11";
 String SQLid = "wbkim11";
 String SQLpw = "q1w2e3r4";

 Connection conn = null;
 Statement stmt = null;
 ResultSet rs = null;
 double DataX;
 double DataY; 
 
 
    //여기 별표
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, SQLid, SQLpw);
    stmt = conn.createStatement();
    rs = stmt.executeQuery("select * from locationinfo WHERE 1;");
    boolean flags = false;
    //while(rs.next())
   // {
    	rs.next();
       DataX = rs.getDouble("locationx");
       DataY = rs.getDouble("locationy");
       
       

    
// String DatazX = String.valueOf(DataX); 
// String DatazY = String.valueOf(DataY);

// <input type="hidden" name="xyz" value='<%=request.getParameter(DataX)

 %>
  
 <%-- 
<input type=hidden name="address" value='<%=DataX %>'>
<input type=hidden name="address1" value='<%=DataY %>'> 
--%> 

<%-- 
<script>
  var LocationX = '<%=Data1X%>';
  document.write(LocationX);
  </script>  
  --%>

<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&language=ko"></script>

 <script> 

 function initialize() { 
 // var LocationX = DataX;
 // var request = new Request();
  // test 라는 파라메터 값을 얻기
 //  request.getParameter("address");
 //  var request1 = new Request();
   // test 라는 파라메터 값을 얻기
  //  request1.getParameter("address1");
 // var obj = document.getElementById("address");	
 // var obj1 = document.getElementById("address1");	

 
 
  var myLatlng = new google.maps.LatLng(12,12); // y, x좌표값
  var mapOptions = { 
        zoom: 15, 
        center: myLatlng, 
        mapTypeId: google.maps.MapTypeId.ROADMAP 
  } 
 
  var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
  var marker = new google.maps.Marker({ 
            position: myLatlng, 
            map: map, 
            title: "회사이름" 
  }); 
  var infowindow = new google.maps.InfoWindow( 
          { 
            content: "<h1>회사이름</h1>", 
            maxWidth: 300 
          } 
  ); 

  google.maps.event.addListener(marker, 'click', function() { 
  infowindow.open(map, marker); 
  }); 
  }

 </script> 

<div id="map_canvas" style="width:600px; height:400px;"></div> 


</body> 

</html> 
