<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="attend.BbsDAO3"%>
<%@ page import="attend.Bbs3"%>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<%! int flag = 0 ; %>
<jsp:useBean id="Bbs3" class="attend.Bbs3" scope="page" />
<jsp:setProperty name="Bbs3" property="attendTime"/>
<jsp:setProperty name="Bbs3" property= "closeTime"/>


<!DOCTYPE html>
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>SmartHelmet</title>

<script src="https://code.jquery.com/jquery-3.2.1.js"></script>

<link rel="stylesheet" href="/css/jquery-ui.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />

<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>




<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">

<script type='text/javascript'
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>

<script src="/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>




<script type='text/javascript'>
	$(function() {

		$('.input-group.date').datepicker({

			calendarWeeks : false,

			todayHighlight : true,

			autoclose : true,

			format : "yyyy/mm/dd",

			language : "kr"

		});

	});
</script>


<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">




<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

#helmet {
	text-align: center;
	padding-top: 20px;
	border-color: #eeeeee;
	border-style: solid;
	margin-bottom: 20px;
}

#helmet2 {
	font-size: 15px;
	border-image-slice: 30;
	border-color: #eeeeee;
	text-align: center;
	padding: 10px;
}

#cal1 {
	padding-top: 5px;
	align-content: center;
	border-style: hidden;
	margin-left: 1000 px;
	width: 800px;
}

#cal2 {
	text-align: center;
	margin-left: 50px;
	margin-right: 50px;
}
</style>

</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null && request.getParameter("userID") != null) {
			userID = (String) session.getAttribute("userID");
		} else if (request.getParameter("userID") != null) {
			userID = request.getParameter("userID");
		} else if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">Smart-Helmet</a>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
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
						</ul></li>
				</ul>
				<%
					} else {
				%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul></li>
				</ul>
				<%
					}
				%>
			</div>
		</div>
	</nav>
	<h1>출근부</h1>


	<div id="helmet" class="table table-striped">

		<span id="helmet2"> <span> 사용자 정보 : </span> <span> <%=userID%>
		</span>

		</span>

		<hr>


<form method="post" action="AttendanceSearch.jsp">
		<div id=cal2>
			조회일 <br> <br>
			<p>
				<span id="cal3" class="input-group date"> <input type="text"
					class="form-control" name="attendTime"><span
					class="input-group-addon"><i
						class="glyphicon glyphicon-calendar"></i></span>

				</span>
			</p>



			<div>~</div>

			<p>
				<span id="cal3" class="input-group date"> <input type="text"
					class="form-control" name="closeTime"><span
					class="input-group-addon"><i
						class="glyphicon glyphicon-calendar"></i></span>

				</span>
			</p>
			<input type="submit" class="btn btn-primary form-control"
				name="closeTime" value="검색">
		
		</div>
			 </form>
			
	

	<br>
	<br>


	</div>

	<div class="container">
		<div class="row">
			
			
			<%

			
			
			System.out.println("flag 값 :" + flag);
   String attendTime = Bbs3.getAttendTime();
   String closeTime =  Bbs3.getCloseTime();
   
   System.out.println(attendTime + closeTime);
   
   // 출근부 클릭했을때 flag값 0으로 넣어주기 . 
   
   if(Bbs3.getAttendTime() == null && Bbs3.getCloseTime() ==null && flag ==0)
   {
	   PrintWriter script = response.getWriter();
	   
	   script.println("<script>");
		script.println("alert('아이고  날짜 입력 하셔야죠.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
   }
   %>


			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">근로자ID</th>
						<th style="background-color: #eeeeee; text-align: center;">인정출근</th>
						<th style="background-color: #eeeeee; text-align: center;">인정퇴근</th>
						<th style="background-color: #eeeeee; text-align: center;">날짜</th>
					</tr>
				</thead>
				<tbody>
					<%
					
					
					
						BbsDAO3 bbsDAO3 = new BbsDAO3();
								
						
						ArrayList<Bbs3> list = bbsDAO3.getManageSearchList(pageNumber,userID,attendTime,closeTime);
						
						if(list.size()==0){
							
							 PrintWriter script = response.getWriter();
							   script.println("<script>");
								script.println("alert('자네는 이기간에 일을 하지 않았네.');");
								script.println("history.back();");
								script.println("</script>");
								script.close();
							
						}
							
					
						
						
						
						for (int i = (pageNumber - 1) * 10; i < pageNumber * 10; i++) {
						
							if (i > list.size() - 1)
								break;
							
					%>
					<tr>
						<td><%=list.get(i).getUserID2()%></td>
						<td><%=list.get(i).getAttendTime()%></td>
						<td><%=list.get(i).getCloseTime()%></td>
						<td><%=list.get(i).getDate()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
			<a href="AttendanceSearch.jsp?pageNumber=<%=pageNumber - 1%><% flag = 1; %>&attendTime=<%= attendTime %>&closeTime=<%=closeTime %>"
				class="btn btn-success btn-arrow-left">이전</a>
			<%
				}
			%>

			<a href="AttendanceSearch.jsp?pageNumber=<%=pageNumber + 1 %><% flag = 1; %>&attendTime=<%= attendTime %>&closeTime=<%=closeTime %>"
				class="btn btn-success btn-arrow-right">다음</a>

		</div>
	</div>





</body>
</html>