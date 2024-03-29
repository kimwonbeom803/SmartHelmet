<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs2.Bbs2"%>
<%@ page import="bbs2.BbsDAO2"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>Smart-Helmet</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int bbsID2 = 0;
		if (request.getParameter("bbsID2") != null) {
			bbsID2 = Integer.parseInt(request.getParameter("bbsID2"));
		}
		if (bbsID2 == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.');");
			script.println("location.href='bbs2.jsp';");
			script.println("</script>");
			script.close();
		}
		Bbs2 bbs2 = new BbsDAO2().getBbs(bbsID2);
		if (bbs2.getBbsAvailable2() == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제된 글입니다.');");
			script.println("location.href='bbs2.jsp';");
			script.println("</script>");
			script.close();
		}
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
					<li class="active"><a href="bbs.jsp">관리자 게시판</a></li>
					<li class="active"><a href="bbs2.jsp">근로자 게시판</a></li>
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
	<div class="container">
		<div class="row">
			<table class="table table-bordered" style="text-align: center;">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%= bbs2.getBbsTitle2() %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= bbs2.getUserID2() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= bbs2.getBbsDate2().substring(0, 11) + bbs2.getBbsDate2().substring(11, 13) + "시 " + bbs2.getBbsDate2().substring(14, 16) + "분" %></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs2.getBbsContent2().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
				</tbody>
			</table>
			<a href="bbs2.jsp" class="btn btn-primary">목록</a>
			<%
			if(userID != null && userID.equals(bbs2.getUserID2())) {
			%>
				<a href="update2.jsp?bbsID2=<%= bbsID2 %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction2.jsp?bbsID2=<%= bbsID2 %>" class="btn btn-primary">삭제</a>
			<%
			}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>