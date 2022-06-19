<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import = "sensor.PollutionDAO" %>
<%@ page import = "sensor.Pollution" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray"%>

<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>JSP Smart-Helmet</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<style> <%--
.centered { display: table; margin-left: auto; margin-right: auto; } 
 --%> 
    
 #map {
        height: 400px;
        width: 100%;
        
      }
      /* Optional: Makes the sample page fill the window. */

     
</style>

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

 ArrayList<String> GpsUserID = new ArrayList<String>();
 ArrayList<String> PolUserID = new ArrayList<String>();
 ArrayList<Integer> ppmlist = new ArrayList<Integer>();
 ArrayList<String> GpsName = new ArrayList<String>();
 ArrayList<Double> GpsDataX = new ArrayList<Double>();
 ArrayList<Double> GpsDataY = new ArrayList<Double>();
int idcount = 0;

  //여기 별표
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, SQLid, SQLpw);
    stmt = conn.createStatement();
    

    int i=0;

    rs = stmt.executeQuery("select * from locationinfo WHERE 1;");
    while(rs.next()){
		
    GpsUserID.add(rs.getString(1));
	GpsName.add(rs.getString(2));
    GpsDataX.add(rs.getDouble(3));
    GpsDataY.add(rs.getDouble(4));

   	i++;
    }
    
    rs = stmt.executeQuery("select * from sensorpollution INNER JOIN locationinfo ON sensorpollution.userID = locationinfo.userID");
   // rs = stmt.executeQuery("select * from sensorpollution WHERE 1;");

    i=0;
    while(rs.next()){
    	
    	PolUserID.add(rs.getString(1));
    	
        ppmlist.add(rs.getInt(2));    	
    	
    	i++;
    }
    
    rs = stmt.executeQuery("select * from user WHERE 1;");
    // rs = stmt.executeQuery("select * from sensorpollution WHERE 1;");

     i=0;
     while(rs.next()){

     	i++;
     }
    idcount = i;
    

    
    //JSONArray json = JSONArray.fromObject(user.getList(ITSMUserInfoConstants.AUTH_ROLE));
//	JSONArray json = new JSONArray.fromObject(ppmlist.);
    
%>
<div class="centered"> <div class="item">

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
					<li class="active"><a href="main.jsp">메인</a></li>
					<li><a href="bbs.jsp">관리자게시판</a></li>
					<li><a href="bbs2.jsp">근로자게시판</a></li>
					<li><a href="manageAttendance.jsp">출근부</a></li>
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

<div>

   
    <div id="map"></div>
    <script>

      function initMap() {
 

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 9,
          center: {lat: <%=GpsDataX.get(1)%>, lng: <%=GpsDataY.get(1)%>}
        });

        // Create an array of alphabetical characters used to label the markers.
        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        var infoWin = new google.maps.InfoWindow();
          
        // Add some markers to the map.
        // Note: The code uses the JavaScript Array.prototype.map() method to
        // create an array of markers based on a given "locations" array.
        // The map() method here has nothing to do with the Google Maps API.
        var markers = locations.map(function(location, i) {
        	var marker = new google.maps.Marker({
            position:location,
            label: labels[i % labels.length]
          });
          
          google.maps.event.addListener(marker, 'click', function(evt) {
              infoWin.setContent(location.info);
              infoWin.open(map, marker);
            })
            return marker;
          });
        
        // Add a marker clusterer to manage the markers.
        var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
      }
      
   	  var NameArrp = new  Array();

	  <%for(int j=0;j< GpsName.size() -1; j++){%>
	  NameArrp[<%=j%>]='<%=GpsName.get(j)%>';
	  <%}%>

	  var DataXArrp = new Array();

	  <%for(int j=0;j< GpsDataX.size() -1; j++){%>
	  DataXArrp[<%=j%>]=<%=GpsDataX.get(j)%>;
	  <%}%>

	  var DataYArrp = new Array();

	  <%for(int j=0;j< GpsDataY.size() -1; j++){%>
	  DataYArrp[<%=j%>]=<%=GpsDataY.get(j)%>;
	  <%}%>

	  var PpmArrp = new Array();

	  <%for(int j=0;j< ppmlist.size() -1; j++){%>
	  PpmArrp[<%=j%>]='<%=ppmlist.get(j)%>';
	  <%}%>
	  
      var locations = [
    	  
        	  {lat: DataXArrp[1], lng: DataYArrp[1], info : "<h3>근로자 " + NameArrp[1] + "</h3>" +
                "Co농도 : " + PpmArrp[1] + "ppm"},
              {lat: DataXArrp[2], lng: DataYArrp[2], info : "<h3>근로자 " + NameArrp[2] + "</h3>" +
                 "Co농도 : " + PpmArrp[2] + "ppm"}, 
              {lat: DataXArrp[3], lng: DataYArrp[3], info : "<h3>근로자 " + NameArrp[3] + "</h3>" +
                 "Co농도 : " + PpmArrp[3] + "ppm"}, 
              {lat: DataXArrp[4], lng: DataYArrp[4], info : "<h3>근로자 " + NameArrp[4] + "</h3>" +
                 "Co농도 : " + PpmArrp[4] + "ppm"}, 
              {lat: DataXArrp[5], lng: DataYArrp[5], info : "<h3>근로자 " + NameArrp[5] + "</h3>" +
                 "Co농도 : " + PpmArrp[5] + "ppm"},
              {lat: DataXArrp[6], lng: DataYArrp[6], info : "<h3>근로자 " + NameArrp[6] + "</h3>" +
                 "Co농도 : " + PpmArrp[6] + "ppm"},                         
              {lat: DataXArrp[7], lng: DataYArrp[7], info : "<h3>근로자 " + NameArrp[7] + "</h3>" +
                 "Co농도 : " + PpmArrp[7] + "ppm"},         
              {lat: DataXArrp[8], lng: DataYArrp[8], info : "<h3>근로자 " + NameArrp[8] + "</h3>" +
                 "Co농도 : " + PpmArrp[8] + "ppm"},        
              {lat: DataXArrp[9], lng: DataYArrp[9], info : "<h3>근로자 " + NameArrp[9] + "</h3>" +
                 "Co농도 : " + PpmArrp[9] + "ppm"},         
              {lat: DataXArrp[10], lng: DataYArrp[10], info : "<h3>근로자 " + NameArrp[10] + "</h3>" +
                 "Co농도 : " + PpmArrp[10] + "ppm"},         
                       
                      ]
	  
      
      google.maps.event.addDomListener(window, "load", initMap);
      
      
    </script>
    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAYB_9N0ldYwuJ9qvlDeHn2RIHwKvsXDMw&callback=initMap">
    </script>
     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Date', '총근로자', '출근한 근로자'],
          ['2018-06-14',  <%=idcount%>,      5 ],
          ['2018-06-15',  <%=idcount%>,      10],
          ['2018-06-16',  <%=idcount%>,      8],
          ['2018-06-17',  <%=idcount%>,      8],
          ['2018-06-18',  <%=idcount%>,      3],
          ['2018-06-19',  <%=idcount%>,      12],
          ['2018-06-20',  <%=idcount%>,      5],
          ['2018-06-21',  <%=idcount%>,      8],
          ['2018-06-22',  <%=idcount%>,      9],
          ['2018-06-23',  <%=idcount%>,      7],
          ['2018-06-24',  <%=idcount%>,      10],
          ['2018-06-25',  <%=idcount%>,      11]
        ]);

        var options = {
          title: '근로자 출근현황',
          hAxis: {title: 'Date',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
     
    <div id="chart_div" style="width: 100%; height: 300px;"></div>
    
     
 <%-- setTimeout("location.reload()",1000000);--%>  

</SCRIPT>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>



</body>
</html>